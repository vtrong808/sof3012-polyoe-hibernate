<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* Admin Color Palette */
    :root {
        --adm-primary: #5D001E; /* Đỏ rượu nền Sidebar */
        --adm-light: #E3E2DF;   /* Nền content */
        --adm-pink-light: #E3AFBC;
        --adm-accent: #9A1750;  /* Active item */
        --adm-highlight: #EE4C7C; /* Button */
    }
    .bg-adm-primary { background-color: var(--adm-primary) !important; }
    .bg-adm-light { background-color: var(--adm-light) !important; }

    .admin-sidebar {
        width: 260px;
        background-color: var(--adm-primary);
        min-height: 100vh;
        color: #E3E2DF;
        box-shadow: 4px 0 10px rgba(0,0,0,0.1);
    }
    .admin-sidebar .nav-link {
        color: #E3AFBC;
        padding: 12px 20px;
        font-weight: 500;
        border-left: 4px solid transparent;
    }
    .admin-sidebar .nav-link:hover {
        color: #fff;
        background-color: rgba(255,255,255,0.1);
    }
    .admin-sidebar .nav-link.active {
        background-color: var(--adm-accent);
        color: #fff;
        border-left-color: var(--adm-highlight);
    }
    .admin-content { flex: 1; background-color: var(--adm-light); }

    .btn-adm { background-color: var(--adm-accent); color: white; }
    .btn-adm:hover { background-color: var(--adm-highlight); color: white; }
</style>

<!-- Navbar Top -->
<nav class="navbar navbar-expand navbar-dark bg-adm-primary border-bottom" style="border-color: #9A1750 !important;">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold ps-3" href="#" style="color: #EE4C7C;">
            <i class="bi bi-shield-lock-fill"></i> PolyOE Admin
        </a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=EE4C7C&color=fff" class="rounded-circle" width="30"> Quản trị viên
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow">
                    <li><a class="dropdown-item" href="<c:url value='/home'/>"><i class="bi bi-house"></i> Xem trang chủ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div class="d-flex">
    <!-- Sidebar -->
    <div class="admin-sidebar d-none d-md-block pt-3">
        <div class="px-3 mb-3 text-uppercase small fw-bold" style="color: #EE4C7C;">Quản lý chính</div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="<c:url value='/admin'/>"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
            <a class="nav-link" href="<c:url value='/admin/video'/>"><i class="bi bi-film me-2"></i> Quản lý Video</a>
            <a class="nav-link" href="<c:url value='/admin/user'/>"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
        </nav>

        <div class="px-3 mb-3 mt-4 text-uppercase small fw-bold" style="color: #EE4C7C;">Thống kê</div>
        <nav class="nav flex-column">
            <a class="nav-link" href="#"><i class="bi bi-bar-chart me-2"></i> Lượt thích</a>
            <a class="nav-link" href="#"><i class="bi bi-share me-2"></i> Lượt chia sẻ</a>
        </nav>
    </div>