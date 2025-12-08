package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import com.poly.utils.GooglePojo;
import com.poly.utils.GoogleUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login-google")
public class LoginGoogleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");

        if (code == null || code.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/login?message=Google login failed");
            return;
        }

        try (UserDAO dao = new UserDAO()) {
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googleUser = GoogleUtils.getUserInfo(accessToken);

            // Kiểm tra xem email này đã có trong DB chưa
            User user = dao.findByEmail(googleUser.getEmail());

            if (user == null) {
                // Chưa có -> Tự động đăng ký
                user = new User();
                user.setId(googleUser.getEmail().split("@")[0]); // Lấy phần trước @ làm username
                user.setEmail(googleUser.getEmail());
                user.setFullname(googleUser.getName());
                user.setPassword("123"); // Mật khẩu mặc định hoặc random
                user.setAdmin(false);

                dao.create(user);
            }

            // Đăng nhập thành công -> Lưu vào session
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/login?message=Login error");
        }
    }
}