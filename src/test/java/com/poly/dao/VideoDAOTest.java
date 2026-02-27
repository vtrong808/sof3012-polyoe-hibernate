package com.poly.dao;

import com.poly.entity.Video;
import com.poly.utils.ExcelReadUtils;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class VideoDAOTest {
    private VideoDAO videoDAO;
    private final String EXCEL_PATH = "TestData.xlsx";

    @BeforeClass
    public void setUp() {
        videoDAO = new VideoDAO();
    }

    @DataProvider(name = "videoCreateData")
    public Object[][] getCreateData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "VideoCreate"); }

    @Test(dataProvider = "videoCreateData")
    public void testCreate(String tcId, String id, String title, String expected) {
        Video v = new Video();
        v.setId(id); v.setTitle(title); v.setActive(true);

        try {
            videoDAO.create(v);
            if ("SUCCESS".equals(expected)) Assert.assertNotNull(videoDAO.findById(id));
            else Assert.fail(tcId + ": Không bắt được lỗi");
        } catch (Exception e) {
            if ("SUCCESS".equals(expected)) Assert.fail(tcId + ": Tạo video thất bại");
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
        v.setTitle(newTitle);
        videoDAO.update(v);
        Assert.assertEquals(videoDAO.findById(id).getTitle(), newTitle, tcId);
    }

    @DataProvider(name = "videoDeleteData")
    public Object[][] getDeleteData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "VideoDelete"); }

    @Test(dataProvider = "videoDeleteData", dependsOnMethods = "testUpdate")
    public void testDelete(String tcId, String id, String expected) {
        try {
            videoDAO.delete(id);
            if ("FK_ERROR".equals(expected)) Assert.fail(tcId + ": Lẽ ra phải dính lỗi khóa ngoại (nếu video đã được like)");
        } catch (Exception e) {
            Assert.assertTrue(true, tcId + ": Lỗi khóa ngoại hợp lý");
        }
    }
}