package com.poly.service;

import com.poly.dao.UserDAO;
import com.poly.entity.User;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public User login(String id, String password) {
        if (id == null || password == null) return null;

        User user = userDAO.findById(id);

        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }
}
