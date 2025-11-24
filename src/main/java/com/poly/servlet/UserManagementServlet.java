package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin/user",
        "/admin/user/index",
        "/admin/user/create",
        "/admin/user/update",
        "/admin/user/delete",
        "/admin/user/edit/*",
        "/admin/user/reset"
})
public class UserManagementServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO dao = new UserDAO();
        User form = new User(); // Đối tượng dùng để hứng dữ liệu form
        String uri = req.getRequestURI();
        String message = "";
        String error = "";

        try {
            // 1. Xử lý logic
            if (uri.contains("edit")) {
                String id = uri.substring(uri.lastIndexOf("/") + 1);
                form = dao.findById(id);
            } else if (uri.contains("create")) {
                try {
                    BeanUtils.populate(form, req.getParameterMap());
                    // Kiểm tra trùng ID
                    if (dao.findById(form.getId()) == null) {
                        dao.create(form);
                        message = "Thêm người dùng mới thành công!";
                    } else {
                        error = "Mã người dùng (Username) đã tồn tại!";
                    }
                } catch (Exception e) {
                    error = "Lỗi thêm mới: " + e.getMessage();
                }
            } else if (uri.contains("update")) {
                try {
                    BeanUtils.populate(form, req.getParameterMap());
                    dao.update(form);
                    message = "Cập nhật thông tin thành công!";
                } catch (Exception e) {
                    error = "Lỗi cập nhật: " + e.getMessage();
                }
            } else if (uri.contains("delete")) {
                try {
                    String id = req.getParameter("id");
                    // Không cho phép xóa chính mình (người đang đăng nhập)
                    User currentUser = (User) req.getSession().getAttribute("user");
                    if (currentUser != null && currentUser.getId().equals(id)) {
                        error = "Không thể tự xóa tài khoản đang đăng nhập!";
                        form = dao.findById(id); // Load lại info để hiện lên form
                    } else {
                        dao.delete(id);
                        message = "Xóa người dùng thành công!";
                        form = new User(); // Reset form
                    }
                } catch (Exception e) {
                    error = "Lỗi xóa: " + e.getMessage();
                }
            } else if (uri.contains("reset")) {
                form = new User();
            }

            // 2. Đổ dữ liệu ra View
            req.setAttribute("form", form); // Dùng tên 'form' để tránh trùng 'user' trong session
            req.setAttribute("items", dao.findAll());
            req.setAttribute("message", message);
            req.setAttribute("error", error);

            // 3. Forward
            req.getRequestDispatcher("/views/admin/user.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        } finally {
            dao.close();
        }
    }
}