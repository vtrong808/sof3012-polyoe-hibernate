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

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Chặn truy cập trực tiếp nếu chưa có quy trình gửi OTP
        HttpSession session = req.getSession();
        if (session.getAttribute("otp") == null) {
            resp.sendRedirect(req.getContextPath() + "/forgot-password");
            return;
        }
        req.getRequestDispatcher("/views/site/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Lấy mã người dùng nhập
            String userOtp = req.getParameter("otp");

            // 2. Lấy thông tin từ Session (đã lưu ở bước ForgotPassword)
            HttpSession session = req.getSession();
            Integer serverOtp = (Integer) session.getAttribute("otp");
            String email = (String) session.getAttribute("resetEmail");
            Long otpTime = (Long) session.getAttribute("otpTime");

            // 3. Kiểm tra OTP
            // - Check 1: Session có tồn tại không
            if (serverOtp == null || email == null || otpTime == null) {
                req.setAttribute("message", "Phiên giao dịch đã hết hạn. Vui lòng thử lại!");
                req.setAttribute("type", "danger");
                req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
                return;
            }

            // - Check 2: Thời gian hết hạn (5 phút = 300000ms)
            if (System.currentTimeMillis() > otpTime + (5 * 60 * 1000)) {
                req.setAttribute("message", "Mã OTP đã hết hạn!");
                req.getRequestDispatcher("/views/site/verify-otp.jsp").forward(req, resp);
                return;
            }

            // - Check 3: So khớp mã
            if (userOtp.equals(String.valueOf(serverOtp))) {
                // --- OTP ĐÚNG ---

                // Lấy mật khẩu gốc từ CSDL
                UserDAO dao = new UserDAO();
                User user = dao.findByEmail(email);

                if (user != null) {
                    // Gửi mật khẩu về mail
                    String subject = "PolyOE - Khôi phục mật khẩu thành công";
                    String body = "Xin chào " + user.getFullname() + ",<br><br>" +
                            "Xác thực thành công. Mật khẩu của bạn là: <b style='color:blue; font-size:18px;'>" + user.getPassword() + "</b><br>" +
                            "Vui lòng đăng nhập và đổi mật khẩu ngay để bảo mật.";

                    XEmail.send(email, subject, body);

                    // Xóa session OTP để tránh dùng lại
                    session.removeAttribute("otp");
                    session.removeAttribute("resetEmail");
                    session.removeAttribute("otpTime");

                    // Chuyển về trang đăng nhập kèm thông báo
                    req.setAttribute("message", "Thành công! Mật khẩu đã được gửi về email của bạn.");
                    req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                }
            } else {
                // --- OTP SAI ---
                req.setAttribute("message", "Mã OTP không chính xác. Vui lòng kiểm tra lại!");
                req.getRequestDispatcher("/views/site/verify-otp.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/site/verify-otp.jsp").forward(req, resp);
        }
    }
}