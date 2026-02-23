package com.poly.service;

import com.poly.entity.User;
import org.testng.Assert;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class UserServiceTest {

    private UserService service = new UserService();

    @DataProvider(name = "loginData")
    public Object[][] data() {
        return new Object[][]{
                {"adminVanTrone", "123", true},     // đúng
                {"admin", "wrong", false},  // sai pass
                {"abc", "123", false},      // user không tồn tại
                {null, null, false}         // null
        };
    }

    @Test(dataProvider = "loginData")
    public void testLogin(String id, String password, boolean expected) {
        User user = service.login(id, password);

        if (expected) {
            Assert.assertNotNull(user);
        } else {
            Assert.assertNull(user);
        }
    }
}
