package com.poly.dao;

import com.poly.entity.User;
import org.testng.Assert;
import org.testng.annotations.Test;

public class UserDAOTest {

    private UserDAO dao = new UserDAO();

    @Test
    public void testCRUDUser() {
        String id = "test_selenium";

        // CREATE
        User user = new User();
        user.setId(id);
        user.setPassword("123");
        user.setEmail("test@gmail.com");
        user.setAdmin(false);
        dao.create(user);

        Assert.assertNotNull(dao.findById(id));

        // UPDATE
        user.setPassword("456");
        dao.update(user);
        Assert.assertEquals(dao.findById(id).getPassword(), "456");

        // DELETE
        dao.delete(id);
        Assert.assertNull(dao.findById(id));
    }
}
