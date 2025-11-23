<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa hồ sơ | PolyOE</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<jsp:include page="/views/common/header.jsp" />

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm rounded-3">
                <div class="card-header bg-white border-bottom-0 py-3">
                    <h4 class="fw-bold mb-0" style="color: var(--cli-dark);">
                        <i class="bi bi-person-gear me-2"></i> CẬP NHẬT TÀI KHOẢN
                    </h4>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty message}">
                        <div class="alert alert-${type} mb-4">${message}</div>
                    </c:if>

                    <form action="<c:url value='/edit-profile'/>" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold text-secondary">Tên đăng nhập</label>
                                <input type="text" class="form-control bg-light" value="${sessionScope.user.id}" readonly>
                                <div class="form-text">Không thể thay đổi tên đăng nhập.</div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold text-secondary">Mật khẩu</label>
                                <input type="password" class="form-control bg-light" value="******" readonly>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold text-secondary">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control" value="${sessionScope.user.fullname}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label fw-bold text-secondary">Email</label>
                                <input type="email" name="email" class="form-control" value="${sessionScope.user.email}" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 mt-4">
                            <a href="<c:url value='/home'/>" class="btn btn-light border px-4">Hủy bỏ</a>
                            <button type="submit" class="btn btn-cli-primary px-4 fw-bold">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>