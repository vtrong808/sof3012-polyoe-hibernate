package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import com.poly.utils.XEmail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy email từ form
        String email = req.getParameter("email");

        // 2. Gọi DAO để kiểm tra user
        try (UserDAO dao = new UserDAO()) {
            User user = dao.findByEmail(email);

            if (user != null) {
                // --- Logic tạo OTP ---

                // A. Tạo mã OTP ngẫu nhiên (6 số)
                int otp = (int) (Math.random() * 900000) + 100000;

                // B. Lưu OTP vào Session
                HttpSession session = req.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("resetEmail", email);
                session.setAttribute("otpTime", System.currentTimeMillis()); // Lưu thời gian tạo để check hết hạn
                session.setMaxInactiveInterval(5 * 60); // Session sống 5 phút

                // C. Gửi Email
                String subject = "Mã xác thực OTP - PolyOE";
                String body = "Mã OTP của bạn là: <b style='font-size:20px; color:red;'>" + otp + "</b>" +
                        "<br>Vui lòng không chia sẻ mã này cho ai. Mã sẽ hết hạn sau 5 phút.";

                XEmail.send(email, subject, body);

                // D. Chuyển hướng sang trang nhập OTP
                req.setAttribute("message", "Mã OTP đã được gửi đến email: " + email);
                req.setAttribute("type", "success"); // Để hiện màu xanh (nếu có hỗ trợ bên JSP)
                req.getRequestDispatcher("/views/site/verify-otp.jsp").forward(req, resp);

            } else {
                // Email không tồn tại
                req.setAttribute("message", "Email này chưa được đăng ký!");
                req.setAttribute("type", "danger");
                req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
        }
    }
}