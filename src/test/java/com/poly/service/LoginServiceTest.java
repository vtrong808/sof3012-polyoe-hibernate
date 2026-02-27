package com.poly.service;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import com.poly.utils.ExcelReadUtils;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class LoginServiceTest {
    private UserDAO userDAO;
    private final String EXCEL_PATH = "TestData.xlsx";

    @BeforeClass
    public void setUp() {
        userDAO = new UserDAO();
    }

    @DataProvider(name = "loginData")
    public Object[][] getLoginData() {
        return ExcelReadUtils.readExcel(EXCEL_PATH, "Login");
    }

    @Test(dataProvider = "loginData")
    public void testLogin(String tcId, String user, String pass, String expected) {
        if (user == null || user.isEmpty()) {
            Assert.assertEquals(expected, "EMPTY_USER", tcId);
            return;
        }
        if (pass == null || pass.isEmpty()) {
            Assert.assertEquals(expected, "EMPTY_PASS", tcId);
            return;
        }

        User u = userDAO.findById(user);
        if (u == null) {
            Assert.assertEquals(expected, "WRONG_USER", tcId);
        } else if (!u.getPassword().equals(pass)) {
            Assert.assertEquals(expected, "WRONG_PASS", tcId);
        } else {
            Assert.assertEquals(expected, "SUCCESS", tcId);
        }
    }
}