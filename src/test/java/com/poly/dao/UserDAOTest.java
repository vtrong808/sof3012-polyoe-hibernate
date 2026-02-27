package com.poly.dao;

import com.poly.entity.User;
import com.poly.utils.ExcelReadUtils;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class UserDAOTest {
    private UserDAO userDAO;
    private final String EXCEL_PATH = "TestData.xlsx";

    @BeforeClass
    public void setUp() {
        userDAO = new UserDAO();
        // DỌN DẸP ĐÚNG 1 LẦN DUY NHẤT TRƯỚC KHI BẮT ĐẦU CHUỖI TEST
        try {
            if (userDAO.findById("new01") != null) userDAO.delete("new01");
            if (userDAO.findById("new02") != null) userDAO.delete("new02");
        } catch (Exception e) {
            // Bỏ qua lỗi
        }
    }

    // --- FIND TESTS ---
    @DataProvider(name = "userFindData")
    public Object[][] getFindData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "UserFind"); }

    @Test(dataProvider = "userFindData")
    public void testFind(String tcId, String id, String expected) {
        User u = userDAO.findById(id);
        if ("NOT_NULL".equals(expected)) Assert.assertNotNull(u, tcId + " failed");
        else Assert.assertNull(u, tcId + " failed");
    }

    // --- CREATE TESTS ---
    @DataProvider(name = "userCreateData")
    public Object[][] getCreateData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "UserCreate"); }

    @Test(dataProvider = "userCreateData")
    public void testCreate(String tcId, String id, String pass, String name, String email, String expected) {
        User u = new User();
        u.setId(id); u.setPassword(pass); u.setFullname(name); u.setEmail(email);

        try {
            userDAO.create(u);
            if ("SUCCESS".equals(expected)) {
                Assert.assertNotNull(userDAO.findById(id), tcId);
            } else {
                Assert.fail(tcId + ": Expected fail but succeeded");
            }
        } catch (Exception e) {
            if ("SUCCESS".equals(expected)) Assert.fail(tcId + ": " + e.getMessage());
            else Assert.assertTrue(true, tcId + ": Bắt lỗi đúng dự kiến");
        }
    }

    // --- UPDATE TESTS ---
    @DataProvider(name = "userUpdateData")
    public Object[][] getUpdateData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "UserUpdate"); }

    @Test(dataProvider = "userUpdateData", dependsOnMethods = "testCreate")
    public void testUpdate(String tcId, String id, String newName, String expected) {
        try {
            User u = userDAO.findById(id);
            if (u == null && "ERROR".equals(expected)) {
                Assert.assertTrue(true); return;
            }
            u.setFullname(newName);
            userDAO.update(u);
            Assert.assertEquals(userDAO.findById(id).getFullname(), newName, tcId);
        } catch (Exception e) {
            if ("SUCCESS".equals(expected)) Assert.fail(tcId + ": Lỗi update");
        }
    }

    // --- DELETE TESTS ---
    @DataProvider(name = "userDeleteData")
    public Object[][] getDeleteData() { return ExcelReadUtils.readExcel(EXCEL_PATH, "UserDelete"); }

    @Test(dataProvider = "userDeleteData", dependsOnMethods = "testUpdate")
    public void testDelete(String tcId, String id, String expected) {
        try {
            userDAO.delete(id); // Code DB thật sẽ xóa
            if ("SUCCESS".equals(expected)) {
                Assert.assertNull(userDAO.findById(id), tcId);
            }
        } catch (Exception e) {
            if ("SUCCESS".equals(expected)) Assert.fail(tcId + ": Xóa thất bại");
            else Assert.assertTrue(true, tcId + ": Không cho phép xóa đúng dự kiến");
        }
    }
}