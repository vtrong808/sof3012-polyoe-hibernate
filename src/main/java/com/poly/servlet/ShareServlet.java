package com.poly.servlet;

import com.poly.dao.ShareDAO;
import com.poly.dao.VideoDAO;
import com.poly.entity.Share;
import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.utils.XEmail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

@WebServlet("/video/share")
public class ShareServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Set tiếng Việt
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // 2. Kiểm tra đăng nhập
            User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            // 3. Lấy dữ liệu
            String videoId = req.getParameter("videoId");
            String emailTo = req.getParameter("email");

            if (emailTo == null || emailTo.trim().isEmpty()) {
                req.getSession().setAttribute("error", "Vui lòng nhập email người nhận!");
                redirectBack(req, resp);
                return;
            }

            // 4. Xử lý Logic
            try (ShareDAO shareDao = new ShareDAO();
                 VideoDAO videoDao = new VideoDAO()) {

                Video video = videoDao.findById(videoId);
                if (video != null) {
                    // A. Gửi Email trước (Nếu gửi lỗi thì văng Exception xuống catch, không lưu DB)
                    String subject = "Chia sẻ video hay: " + video.getTitle();
                    String link = req.getRequestURL().toString().replace("share", "detail?id=" + videoId);

                    StringBuilder body = new StringBuilder();
                    body.append("<h3>Xin chào,</h3>");
                    body.append("<p>Người dùng <b>").append(user.getFullname()).append("</b> đã chia sẻ video này với bạn:</p>");
                    body.append("<p style='color:blue; font-weight:bold;'>").append(video.getTitle()).append("</p>");
                    body.append("<a href='").append(link).append("'>Xem ngay tại đây</a>");

                    XEmail.send(emailTo, subject, body.toString());

                    // B. Lưu vào DB sau khi gửi thành công
                    Share share = new Share();
                    share.setUser(user);
                    share.setVideo(video);
                    share.setEmails(emailTo);
                    share.setShareDate(new Date());
                    shareDao.create(share);

                    // C. Thông báo thành công
                    req.getSession().setAttribute("message", "Đã gửi email chia sẻ thành công!");
                } else {
                    req.getSession().setAttribute("error", "Video không tồn tại!");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Lỗi gửi mail: " + e.getMessage());
        }

        // 5. Quay lại trang cũ
        redirectBack(req, resp);
    }

    private void redirectBack(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/home");
    }
}