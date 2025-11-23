package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/edit-profile")
public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Bắt buộc đăng nhập mới được sửa
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("user", user); // Đẩy thông tin cũ lên form
        req.getRequestDispatcher("/views/site/edit-profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User currentUser = (User) req.getSession().getAttribute("user");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try (UserDAO dao = new UserDAO()) {
            // Lấy dữ liệu từ form
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");

            // Cập nhật entity
            currentUser.setFullname(fullname);
            currentUser.setEmail(email);

            // Gọi DAO update xuống DB
            dao.update(currentUser);

            // Cập nhật lại Session
            req.getSession().setAttribute("user", currentUser);

            req.setAttribute("message", "Cập nhật hồ sơ thành công!");
            req.setAttribute("type", "success");

        } catch (Exception e) {
            req.setAttribute("message", "Lỗi cập nhật: " + e.getMessage());
            req.setAttribute("type", "danger");
            e.printStackTrace();
        }

        req.getRequestDispatcher("/views/site/edit-profile.jsp").forward(req, resp);
    }
}