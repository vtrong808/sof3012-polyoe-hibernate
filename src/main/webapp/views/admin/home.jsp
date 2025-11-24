<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản trị viên - Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>"> <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        /* Style riêng cho các card thống kê */
        .stat-card {
            border: none;
            border-radius: 12px;
            background: #fff;
            transition: transform 0.2s;
            position: relative;
            overflow: hidden;
        }
        .stat-card:hover { transform: translateY(-5px); }
        .stat-card::after {
            content: "";
            position: absolute;
            top: 0; right: 0;
            width: 80px; height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0,0,0,0.03));
        }
        .icon-square {
            width: 50px; height: 50px;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>

<jsp:include page="/views/common/admin-header.jsp" />

<div class="p-4">

    <div class="alert border-0 shadow-sm d-flex align-items-center" style="background-color: #fff; border-left: 5px solid var(--adm-accent) !important;">
        <div class="me-3 text-danger display-6"><i class="bi bi-emoji-sunglasses"></i></div>
        <div>
            <h4 class="mb-1 fw-bold" style="color: var(--adm-primary);">Xin chào, Quản trị viên!</h4>
            <p class="mb-0 text-muted">Hệ thống PolyOE đang hoạt động ổn định. Chúc bạn một ngày làm việc hiệu quả!</p>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="stat-card p-3 shadow-sm">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted small text-uppercase fw-bold mb-1">Tổng Video</p>
                        <h3 class="fw-bold mb-0" style="color: var(--adm-primary);">${vidCount}</h3>
                    </div>
                    <div class="icon-square" style="background-color: #fde2e9; color: var(--adm-highlight);">
                        <i class="bi bi-film"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card p-3 shadow-sm">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted small text-uppercase fw-bold mb-1">Người dùng</p>
                        <h3 class="fw-bold mb-0" style="color: var(--adm-primary);">${userCount}</h3>
                    </div>
                    <div class="icon-square" style="background-color: #e3f2fd; color: #0d6efd;">
                        <i class="bi bi-people-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card p-3 shadow-sm">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted small text-uppercase fw-bold mb-1">Lượt xem</p>
                        <h3 class="fw-bold mb-0" style="color: var(--adm-primary);">${totalViews}</h3>
                    </div>
                    <div class="icon-square" style="background-color: #fff3cd; color: #ffc107;">
                        <i class="bi bi-eye-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card p-3 shadow-sm">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted small text-uppercase fw-bold mb-1">Lượt thích</p>
                        <h3 class="fw-bold mb-0" style="color: var(--adm-primary);">${favCount}</h3>
                    </div>
                    <div class="icon-square" style="background-color: #d1e7dd; color: #198754;">
                        <i class="bi bi-heart-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom-0">
            <h6 class="mb-0 fw-bold text-uppercase" style="color: var(--adm-accent);">
                <i class="bi bi-bar-chart-line-fill me-2"></i> Video được xem nhiều nhất
            </h6>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">Tiêu đề Video</th>
                        <th>Lượt xem</th>
                        <th>Lượt thích</th>
                        <th>Trạng thái</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="ps-4 fw-bold text-secondary">Java Programming 101</td>
                        <td>1,500</td>
                        <td>250</td>
                        <td><span class="badge bg-success rounded-pill">Hoạt động</span></td>
                    </tr>
                    <tr>
                        <td class="ps-4 fw-bold text-secondary">Spring Boot Tutorial</td>
                        <td>2,300</td>
                        <td>400</td>
                        <td><span class="badge bg-success rounded-pill">Hoạt động</span></td>
                    </tr>
                    <tr>
                        <td class="ps-4 fw-bold text-secondary">Angular vs React</td>
                        <td>9,999</td>
                        <td>1,200</td>
                        <td><span class="badge bg-secondary rounded-pill">Đã ẩn</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
<jsp:include page="/views/common/admin-footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>