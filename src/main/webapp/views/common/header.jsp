<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">

<nav class="navbar navbar-expand-lg navbar-dark bg-cli-dark sticky-top shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold d-flex align-items-center" href="<c:url value='/home'/>">
            <i class="bi bi-play-circle-fill text-cli-primary fs-3 me-2"></i>
            <span class="text-white">Poly<span class="text-cli-primary">OE</span></span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#siteNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="siteNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link active" href="<c:url value='/home'/>">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="<c:url value='/favorite'/>">Yêu thích</a></li>
            </ul>

            <!-- Search -->
            <form class="d-flex mx-auto" style="width: 40%;" action="<c:url value='/video/search'/>">
                <div class="input-group">
                    <input class="form-control border-0" type="search" placeholder="Tìm kiếm phim..." aria-label="Search">
                    <button class="btn btn-light" type="submit"><i class="bi bi-search text-cli-dark"></i></button>
                </div>
            </form>

            <!-- Auth Buttons -->
            <div class="d-flex ms-3">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="<c:url value='/login'/>" class="btn btn-cli-primary rounded-pill px-4">Đăng nhập</a>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown">
                            <a class="btn btn-outline-light dropdown-toggle rounded-pill" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-1"></i> ${sessionScope.user.fullname}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="<c:url value='/edit-profile'/>">Cập nhật tài khoản</a></li>
                                <c:if test="${sessionScope.user.admin}">
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/admin'/>">Trang quản trị</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="<c:url value='/logout'/>">Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="alert-absolute-top-right">
    <%-- 1. Thông báo thành công --%>
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success alert-dismissible fade show shadow border-0" role="alert">
            <div class="d-flex align-items-center">
                <i class="bi bi-check-circle-fill fs-4 me-3"></i>
                <div>
                    <h6 class="fw-bold mb-0">Thành công!</h6>
                    <small>${sessionScope.message}</small>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>

    <%-- 2. Thông báo lỗi --%>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger alert-dismissible fade show shadow border-0" role="alert">
            <div class="d-flex align-items-center">
                <i class="bi bi-exclamation-triangle-fill fs-4 me-3"></i>
                <div>
                    <h6 class="fw-bold mb-0">Thất bại!</h6>
                    <small>${sessionScope.error}</small>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>
</div>