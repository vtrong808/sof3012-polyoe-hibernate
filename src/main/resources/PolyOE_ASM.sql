CREATE DATABASE PolyOE_ASM;
GO

USE PolyOE_ASM;
GO

-- 1. Bảng Users (Người dùng & Quản trị viên)
CREATE TABLE Users (
    Id NVARCHAR(20) PRIMARY KEY,     -- Username
    Password NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Fullname NVARCHAR(100) NOT NULL,
    Admin BIT DEFAULT 0              -- 0: User, 1: Admin
);

-- 2. Bảng Video (Phim/Clip)
CREATE TABLE Video (
    Id NVARCHAR(20) PRIMARY KEY,     -- Video Code (e.g., V001)
    Title NVARCHAR(255) NOT NULL,    -- Sửa lỗi chính tả 'Titile' trong ảnh
    Poster NVARCHAR(255),            -- Link ảnh hoặc tên file ảnh
    Views INT DEFAULT 0,
    Description NVARCHAR(MAX),
    Active BIT DEFAULT 1             -- 1: Đang chiếu, 0: Ẩn
);

-- 3. Bảng Favorite (Lưu video yêu thích)
CREATE TABLE Favorite (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId NVARCHAR(20) NOT NULL,
    VideoId NVARCHAR(20) NOT NULL,
    LikeDate DATE DEFAULT GETDATE(),

    CONSTRAINT FK_Fav_User FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Fav_Video FOREIGN KEY (VideoId) REFERENCES Video(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_Fav_User_Video UNIQUE (UserId, VideoId) -- Mỗi người chỉ like 1 video 1 lần
);

-- 4. Bảng Share (Chia sẻ video qua email)
CREATE TABLE Share (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId NVARCHAR(20) NOT NULL,
    VideoId NVARCHAR(20) NOT NULL,
    Emails NVARCHAR(MAX) NOT NULL,   -- Danh sách email nhận
    ShareDate DATE DEFAULT GETDATE(),

    CONSTRAINT FK_Share_User FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    CONSTRAINT FK_Share_Video FOREIGN KEY (VideoId) REFERENCES Video(Id) ON DELETE CASCADE
);
GO

-- Thêm dữ liệu mẫu để test giao diện
INSERT INTO Users (Id, Password, Email, Fullname, Admin) VALUES
('admin', '123', 'admin@poly.edu.vn', N'Admin Manager', 1),
('teonv', '123', 'teonv@gmail.com', N'Nguyễn Văn Tèo', 0);

INSERT INTO Video (Id, Title, Poster, Views, Description, Active) VALUES
('V01', N'Java Programming 101', 'v1.jpg', 1500, N'Hướng dẫn Java cơ bản', 1),
('V02', N'Spring Boot Tutorial', 'v2.jpg', 2300, N'Học Spring Boot trong 10 phút', 1),
('V03', N'Hibernate Deep Dive', 'v3.jpg', 500, N'Tìm hiểu sâu về JPA/Hibernate', 1),
('V04', N'Angular vs React', 'v4.jpg', 9999, N'So sánh Frontend Framework', 0); -- Video này bị ẩn

USE PolyOE_ASM;
GO

-- =============================================
-- 1. THÊM 20 VIDEO MỚI (Tổng cộng sẽ có 24 video)
-- =============================================
INSERT INTO Video (Id, Title, Poster, Views, Description, Active) VALUES 
('V005', N'Lập trình C# cơ bản', 'v5.jpg', 1200, N'Khóa học C# cho người mới bắt đầu từ con số 0.', 1),
('V006', N'HTML5 & CSS3 Masterclass', 'v6.jpg', 5600, N'Làm chủ giao diện web với HTML5 và CSS3 hiện đại.', 1),
('V007', N'Javascript ES6+ Tiên tiến', 'v7.jpg', 3450, N'Cập nhật các tính năng mới nhất của Javascript.', 1),
('V008', N'ReactJS trong 1 giờ', 'v8.jpg', 8900, N'Xây dựng ứng dụng Single Page Application nhanh chóng.', 1),
('V009', N'NodeJS Restful API', 'v9.jpg', 2100, N'Xây dựng Backend mạnh mẽ với NodeJS và Express.', 1),
('V010', N'Python for Data Science', 'v10.jpg', 4500, N'Phân tích dữ liệu với Python, Pandas và NumPy.', 1),
('V011', N'Docker & Kubernetes', 'v11.jpg', 150, N'Triển khai ứng dụng với Containerization.', 1),
('V012', N'Git & Github toàn tập', 'v12.jpg', 6700, N'Quản lý mã nguồn hiệu quả cho đội nhóm.', 1),
('V013', N'Flutter Mobile App', 'v13.jpg', 3200, N'Lập trình ứng dụng di động đa nền tảng.', 1),
('V014', N'SQL Server nâng cao', 'v14.jpg', 900, N'Tối ưu hóa truy vấn và quản trị cơ sở dữ liệu.', 1),
('V015', N'DevOps là gì?', 'v15.jpg', 5000, N'Tìm hiểu văn hóa và công cụ DevOps.', 1),
('V016', N'Agile & Scrum', 'v16.jpg', 120, N'Quy trình phát triển phần mềm linh hoạt.', 1),
('V017', N'UI/UX Design cơ bản', 'v17.jpg', 8800, N'Thiết kế giao diện người dùng thân thiện.', 1),
('V018', N'Angular vs VueJS', 'v18.jpg', 2340, N'So sánh hai Framework Frontend phổ biến.', 1),
('V019', N'Bảo mật Web (OWASP)', 'v19.jpg', 670, N'Các lỗ hổng bảo mật web thường gặp và cách phòng chống.', 1),
('V020', N'Microservices Architecture', 'v20.jpg', 4300, N'Kiến trúc vi dịch vụ trong các hệ thống lớn.', 1),
('V021', N'Machine Learning 101', 'v21.jpg', 9900, N'Giới thiệu về Học máy và Trí tuệ nhân tạo.', 1),
('V022', N'Blockchain Basics', 'v22.jpg', 1100, N'Công nghệ chuỗi khối và ứng dụng thực tế.', 1),
('V023', N'Game Development Unity', 'v23.jpg', 3300, N'Làm game 2D/3D với Unity Engine.', 1),
('V024', N'Soft Skills for Devs', 'v24.jpg', 7600, N'Kỹ năng mềm cần thiết cho lập trình viên.', 1);

-- =============================================
-- 2. THÊM 15 DỮ LIỆU FAVORITE (YÊU THÍCH)
-- =============================================
-- Admin thích một số video
INSERT INTO Favorite (UserId, VideoId, LikeDate) VALUES 
('admin', 'V01', '2023-01-10'),
('admin', 'V005', '2023-02-15'),
('admin', 'V008', '2023-03-20'),
('admin', 'V010', '2023-04-05'),
('admin', 'V012', '2023-05-12'),
('admin', 'V020', '2023-06-18'),
('admin', 'V024', '2023-07-22');

-- Teonv thích một số video khác
INSERT INTO Favorite (UserId, VideoId, LikeDate) VALUES 
('teonv', 'V01', '2023-01-11'),
('teonv', 'V02', '2023-01-12'),
('teonv', 'V006', '2023-02-18'),
('teonv', 'V007', '2023-03-25'),
('teonv', 'V015', '2023-04-10'),
('teonv', 'V018', '2023-05-30'),
('teonv', 'V021', '2023-06-15'),
('teonv', 'V023', '2023-08-01');

-- =============================================
-- 3. THÊM 15 DỮ LIỆU SHARE (CHIA SẺ)
-- =============================================
INSERT INTO Share (UserId, VideoId, Emails, ShareDate) VALUES 
('admin', 'V01', 'friend1@gmail.com', '2023-01-12'),
('admin', 'V005', 'colleague@company.com', '2023-02-16'),
('admin', 'V010', 'student@school.edu.vn', '2023-04-06'),
('admin', 'V012', 'devteam@tech.com', '2023-05-13'),
('admin', 'V020', 'architect@sys.com', '2023-06-19'),
('teonv', 'V02', 'crush@gmail.com', '2023-01-13'),
('teonv', 'V006', 'mom@family.com', '2023-02-19'),
('teonv', 'V007', 'dad@family.com', '2023-03-26'),
('teonv', 'V015', 'boss@work.com', '2023-04-11'),
('teonv', 'V018', 'hr@recruitment.com', '2023-05-31'),
('teonv', 'V021', 'ai_enthusiast@forum.net', '2023-06-16'),
('teonv', 'V005', 'newbie@code.org', '2023-02-20'),
('admin', 'V006', 'designer@uiux.io', '2023-02-21'),
('teonv', 'V008', 'react_fan@fb.com', '2023-03-22'),
('admin', 'V014', 'dba@sqlserver.com', '2023-04-08');
GO

PRINT 'Đã thêm thành công 50 dòng dữ liệu mẫu!';