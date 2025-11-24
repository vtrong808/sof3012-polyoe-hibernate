package com.poly.servlet;

import com.poly.dao.ReportDAO;
import com.poly.dao.VideoDAO;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ReportDAO reportDao = new ReportDAO();
        VideoDAO videoDao = new VideoDAO();

        String tab = req.getParameter("tab");
        String videoId = req.getParameter("id"); // ID video chọn từ dropdown

        // Mặc định vào tab favorite-users nếu không có tham số
        if (tab == null) {
            tab = "favorite-users";
        }

        try {
            // Load danh sách Video để đổ vào Dropdown cho cả 2 tab
            List<Video> vList = videoDao.findAll();
            req.setAttribute("vidList", vList);

            // Logic cho Tab Chia sẻ (Shared Friends)
            if (tab.equals("shared-friends")) {
                // Nếu chưa chọn video nào thì mặc định chọn cái đầu tiên
                if (videoId == null && !vList.isEmpty()) {
                    videoId = vList.get(0).getId();
                }

                if (videoId != null) {
                    // Gọi DAO lấy list người share (Ông nhớ cập nhật ReportDAO nhé)
                    List<Object[]> list = reportDao.getShareFriends(videoId);
                    req.setAttribute("items", list);
                    req.setAttribute("vidSelected", videoId); // Giữ lại ID để dropdown chọn đúng
                }
            }
            // Logic cho Tab Yêu thích (Favorite Users)
            else if (tab.equals("favorite-users")) {
                if (videoId == null && !vList.isEmpty()) {
                    videoId = vList.get(0).getId();
                }
                if (videoId != null) {
                    List<Object[]> list = reportDao.getFavoriteUsers(videoId);
                    req.setAttribute("items", list);
                    req.setAttribute("vidSelected", videoId);
                }
            }

        } catch (Exception e) {
            req.setAttribute("error", "Lỗi báo cáo: " + e.getMessage());
            e.printStackTrace();
        } finally {
            videoDao.close();
            // reportDao không có close() thì thôi, hoặc thêm vào nếu muốn chuẩn
        }

        req.setAttribute("tab", tab);
        req.getRequestDispatcher("/views/admin/report.jsp").forward(req, resp);
    }
}