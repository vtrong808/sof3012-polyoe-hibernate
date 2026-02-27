package com.poly.dao;

import com.poly.entity.Video;
import com.poly.utils.ExcelReadUtils;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class VideoDAOTest {
    private VideoDAO videoDAO;
    private final String EXCEL_PATH = "TestData.xlsx";

    @BeforeClass
    public void setUp() {
        videoDAO = new VideoDAO();
        // DỌN DẸP ĐÚNG 1 LẦN DUY NHẤT TRƯỚC KHI BẮT ĐẦU CHUỖI TEST
        try {
            if (videoDAO.findById("v01") != null) videoDAO.delete("v01");
            if (videoDAO.findById("v02") != null) videoDAO.delete("v02");
        } catch (Exception e) {
            // Bỏ qua lỗi
        }
    }

    @DataProvider(name = "videoCreateData")
    public Object[][] getCreateData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "VideoCreate"); }

    @Test(dataProvider = "videoCreateData")
    public void testCreate(String tcId, String id, String title, String expected) {
        Video v = new Video();
        v.setId(id); v.setTitle(title); v.setActive(true);

        try {
            videoDAO.create(v);
            if ("SUCCESS".equals(expected)) Assert.assertNotNull(videoDAO.findById(id), tcId);
            else Assert.fail(tcId + ": Lẽ ra phải lỗi nhưng lại tạo thành công");
        } catch (Exception e) {
            if ("SUCCESS".equals(expected)) Assert.fail(tcId + ": Tạo video thất bại - " + e.getMessage());
            else Assert.assertTrue(true, tcId + ": Bắt lỗi đúng dự kiến");
        }
    }

    @DataProvider(name = "videoFindData")
    public Object[][] getFindData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "VideoFind"); }

    @Test(dataProvider = "videoFindData", dependsOnMethods = "testCreate")
    public void testFind(String tcId, String id, String expected) {
        Video v = videoDAO.findById(id);
        Assert.assertNotNull(v, tcId);
    }

    @DataProvider(name = "videoUpdateData")
    public Object[][] getUpdateData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "VideoUpdate"); }

    @Test(dataProvider = "videoUpdateData", dependsOnMethods = "testFind")
    public void testUpdate(String tcId, String id, String newTitle, String expected) {
        Video v = videoDAO.findById(id);
        if (v != null) {
            v.setTitle(newTitle);
            videoDAO.update(v);
            Assert.assertEquals(videoDAO.findById(id).getTitle(), newTitle, tcId);
        } else {
            Assert.fail(tcId + ": Không tìm thấy video để update");
        }
    }

    @DataProvider(name = "videoDeleteData")
    public Object[][] getDeleteData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "VideoDelete"); }

    @Test(dataProvider = "videoDeleteData", dependsOnMethods = "testUpdate")
    public void testDelete(String tcId, String id, String expected) {
        try {
            videoDAO.delete(id);
            if ("FK_ERROR".equals(expected)) {
                Assert.fail(tcId + ": Lẽ ra phải dính lỗi khóa ngoại nhưng lại xóa thành công (Vì video này mới tạo, chưa có ai like). Hãy đổi EXPECTED trong Excel thành SUCCESS.");
            } else {
                Assert.assertNull(videoDAO.findById(id), tcId);
            }
        } catch (Exception e) {
            if ("SUCCESS".equals(expected)) {
                Assert.fail(tcId + ": Xóa thất bại - " + e.getMessage());
            } else {
                Assert.assertTrue(true, tcId + ": Bắt lỗi khóa ngoại hợp lý");
            }
        }
    }
}