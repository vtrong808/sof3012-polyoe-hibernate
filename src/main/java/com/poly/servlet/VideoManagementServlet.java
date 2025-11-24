package com.poly.servlet;

import com.poly.dao.VideoDAO;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin/video",
        "/admin/video/index",
        "/admin/video/create",
        "/admin/video/update",
        "/admin/video/delete",
        "/admin/video/edit/*", // Đường dẫn có tham số phía sau (vd: /edit/V001)
        "/admin/video/reset"
})
public class VideoManagementServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        VideoDAO dao = new VideoDAO();
        Video video = new Video();
        String uri = req.getRequestURI();
        String message = "";
        String error = "";

        try {
            // 1. Xử lý các hành động form
            if (uri.contains("edit")) {
                String id = uri.substring(uri.lastIndexOf("/") + 1);
                video = dao.findById(id);
            } else if (uri.contains("create")) {
                try {
                    BeanUtils.populate(video, req.getParameterMap());
                    dao.create(video);
                    message = "Thêm mới thành công!";
                } catch (Exception e) {
                    error = "Lỗi thêm mới: " + e.getMessage();
                }
            } else if (uri.contains("update")) {
                try {
                    BeanUtils.populate(video, req.getParameterMap());
                    dao.update(video);
                    message = "Cập nhật thành công!";
                } catch (Exception e) {
                    error = "Lỗi cập nhật: " + e.getMessage();
                }
            } else if (uri.contains("delete")) {
                try {
                    String id = req.getParameter("id");
                    dao.delete(id);
                    message = "Xóa thành công!";
                    video = new Video(); // Reset form
                } catch (Exception e) {
                    error = "Lỗi xóa: " + e.getMessage();
                }
            } else if (uri.contains("reset")) {
                video = new Video();
            }

            // 2. Đổ dữ liệu ra View
            req.setAttribute("video", video); // Đối tượng để hiện lên form
            req.setAttribute("items", dao.findAll()); // Danh sách video cho tab List
            req.setAttribute("message", message);
            req.setAttribute("error", error);

            // 3. Forward về trang JSP
            req.getRequestDispatcher("/views/admin/video.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        } finally {
            dao.close(); // Đóng kết nối
        }
    }
}