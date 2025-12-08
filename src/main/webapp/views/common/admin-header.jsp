<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* Admin Color Palette - Red Wine Theme */
    :root {
        --adm-primary: #5D001E;    /* Nền Sidebar */
        --adm-light: #E3E2DF;      /* Nền Content */
        --adm-pink-light: #E3AFBC; /* Text phụ */
        --adm-accent: #9A1750;     /* Active Item */
        --adm-highlight: #EE4C7C;  /* Button/Hover */
    }

    /* Sidebar Styling */
    .admin-sidebar {
        width: 260px;
        background-color: var(--adm-primary);
        min-height: 100vh;
        color: #fff;
        box-shadow: 4px 0 10px rgba(0,0,0,0.1);
        display: flex;
        flex-direction: column;
    }

    .admin-sidebar .nav-link {
        color: var(--adm-pink-light);
        padding: 12px 24px;
        font-weight: 500;
        border-left: 4px solid transparent;
        transition: all 0.3s;
    }

    .admin-sidebar .nav-link:hover {
        color: #fff;
        background-color: rgba(255,255,255,0.05);
        padding-left: 30px; /* Hiệu ứng đẩy chữ sang phải */
    }

    .admin-sidebar .nav-link.active {
        background-color: var(--adm-accent);
        color: #fff;
        border-left-color: var(--adm-highlight);
        box-shadow: inset -5px 0 10px rgba(0,0,0,0.2);
    }

    /* Top Navbar */
    .admin-navbar {
        background-color: #5D001E;
        border-bottom: 1px solid #e0e0e0;
        padding: 0.8rem 1.5rem;
    }

    /* Layout Wrapper */
    .admin-wrapper {
        display: flex;
        min-height: 100vh;
    }
    .admin-main {
        flex: 1;
        background-color: var(--adm-light);
        display: flex;
        flex-direction: column;
    }
</style>

<div class="admin-wrapper">
    <nav class="admin-sidebar">
        <div class="py-4 px-4 mb-3 text-center border-bottom border-secondary">
            <h4 class="fw-bold m-0" style="color: var(--adm-highlight);">
                <i class="bi bi-film"></i> PolyOE
            </h4>
            <small class="text-white-50">Administration</small>
        </div>

        <div class="px-3 mb-2 text-uppercase small fw-bold" style="color: var(--adm-highlight); opacity: 0.8;">Quản lý</div>
        <nav class="nav flex-column mb-4">
            <a class="nav-link ${pageContext.request.servletPath.contains('/home.jsp') ? 'active' : ''}"
               href="<c:url value='/admin/home'/>">
                <i class="bi bi-speedometer2 me-2"></i> Trang chủ
            </a>
            <a class="nav-link ${pageContext.request.servletPath.contains('/video') ? 'active' : ''}"
               href="<c:url value='/admin/video'/>">
                <i class="bi bi-collection-play me-2"></i> Video
            </a>
            <a class="nav-link ${pageContext.request.servletPath.contains('/user') ? 'active' : ''}"
               href="<c:url value='/admin/user'/>">
                <i class="bi bi-people me-2"></i> Người dùng
            </a>
        </nav>

        <div class="px-3 mb-2 text-uppercase small fw-bold" style="color: var(--adm-highlight); opacity: 0.8;">Thống kê</div>
        <nav class="nav flex-column">
            <a class="nav-link ${param.tab == 'favorite-users' || param.tab == 'favorites' ? 'active' : ''}"
               href="<c:url value='/admin/reports?tab=favorites'/>">
                <i class="bi bi-heart me-2"></i> Lượt thích
            </a>

            <a class="nav-link ${param.tab == 'shared-friends' || param.tab == 'shares' ? 'active' : ''}"
               href="<c:url value='/admin/reports?tab=shares'/>">
                <i class="bi bi-share me-2"></i> Chia sẻ
            </a>
        </nav>

        <div class="mt-auto p-3 border-top border-secondary text-center">
            <small class="text-white-50">&copy; 2025 PolyOE</small>
        </div>
    </nav>

    <div class="admin-main">
        <nav class="navbar navbar-expand admin-navbar shadow-sm">
            <div class="container-fluid">
                <button class="btn btn-link text-dark d-md-none"><i class="bi bi-list fs-4"></i></button>

                <div class="d-flex ms-auto align-items-center">
                    <div class="dropdown">
                        <a class="d-flex align-items-center text-white text-decoration-none dropdown-toggle text-dark fw-bold"
                           href="#" role="button" data-bs-toggle="dropdown">
                            <div class="bg-danger text-white rounded-circle d-flex justify-content-center align-items-center me-2"
                                 style="width: 35px; height: 35px;">A</div>
                            <span class="text-white" >Admin</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end border-0 shadow">
                            <li><a class="dropdown-item" href="<c:url value='/home'/>"><i class="bi bi-house me-2"></i>Xem trang web</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>