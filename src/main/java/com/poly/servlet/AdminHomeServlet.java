package com.poly.servlet;

import com.poly.dao.ReportDAO; // Import DAO mới tạo
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/admin", "/admin/home"})
public class AdminHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra bảo mật (Giữ nguyên code cũ)
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || !user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 2. Lấy số liệu thống kê (Code mới)
        ReportDAO dao = new ReportDAO();

        req.setAttribute("vidCount", dao.countVideos());
        req.setAttribute("userCount", dao.countUsers());
        req.setAttribute("totalViews", dao.totalViews());
        req.setAttribute("favCount", dao.countFavorites());

        // 3. Forward về trang admin
        req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
    }
}