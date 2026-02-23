package com.poly.servlet;

import com.poly.entity.User;
import com.poly.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Tạo URL đăng nhập Google
        String googleLoginUrl = "https://accounts.google.com/o/oauth2/auth?scope=email%20profile"
                + "&redirect_uri=" + com.poly.utils.GoogleUtils.GOOGLE_REDIRECT_URI
                + "&response_type=code"
                + "&client_id=" + com.poly.utils.GoogleUtils.GOOGLE_CLIENT_ID;

        req.setAttribute("googleUrl", googleLoginUrl);
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        // Gọi service xử lý login
        User user = userService.login(id, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            // Phân quyền
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            req.setAttribute("message", "Sai thông tin đăng nhập rồi bạn ơi!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
