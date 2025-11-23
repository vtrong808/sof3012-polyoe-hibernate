package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Giai đoạn 1: Chỉ mô phỏng kiểm tra User
        String username = req.getParameter("username");
        String email = req.getParameter("email");

        try (UserDAO dao = new UserDAO()) {
            User user = dao.findById(username);

            if (user == null) {
                req.setAttribute("message", "Tên tài khoản không tồn tại!");
            } else if (!user.getEmail().equalsIgnoreCase(email)) {
                req.setAttribute("message", "Email không khớp với tài khoản đăng ký!");
            } else {
                // Giai đoạn 2 sẽ gửi mail ở đây. Tạm thời thông báo thành công.
                req.setAttribute("message", "Mật khẩu đã được gửi về email: " + email);
                req.setAttribute("type", "success"); // Để tô màu xanh thông báo
            }
        } catch (Exception e) {
            req.setAttribute("message", "Lỗi hệ thống: " + e.getMessage());
        }

        req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
    }
}