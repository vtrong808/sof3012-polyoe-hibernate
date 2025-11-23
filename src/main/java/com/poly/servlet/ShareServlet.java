package com.poly.servlet;

    import com.poly.dao.ShareDAO;
import com.poly.entity.Share;
import com.poly.entity.User;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/video/share")
public class ShareServlet extends HttpServlet {

    // doGet có thể bỏ qua hoặc redirect về Home nếu ai đó cố tình truy cập link trực tiếp
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Kiểm tra đăng nhập (Bắt buộc đăng nhập mới được share)
            User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            // 2. Lấy dữ liệu từ Form Modal
            String videoId = req.getParameter("videoId");
            String emailTo = req.getParameter("email");

            // 3. Logic Gửi Email & Lưu Database (Code giả lập)
            // ShareDAO shareDao = new ShareDAO();
            // Share share = new Share();
            // share.setUser(user);
            // share.setVideo(new Video(videoId)); ...
            // shareDao.create(share);
            // MailService.send(...)

            System.out.println("User " + user.getId() + " shared video " + videoId + " to " + emailTo);

            // 4. Thông báo (Dùng Session để hiển thị thông báo sau khi redirect)
            // req.getSession().setAttribute("message", "Đã gửi video thành công tới " + emailTo);

        } catch (Exception e) {
            e.printStackTrace();
            // req.getSession().setAttribute("error", "Lỗi khi gửi email: " + e.getMessage());
        }

        // 5. Quan trọng: Quay lại trang cũ (Home hoặc Favorite)
        String referer = req.getHeader("Referer");
        if (referer != null) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}