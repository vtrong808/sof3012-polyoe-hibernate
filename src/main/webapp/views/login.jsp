<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - PolyOE</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">

<div class="card shadow-lg border-0 rounded-4" style="width: 400px;">
    <div class="card-header bg-cli-dark text-white text-center py-4 rounded-top-4">
        <h3 class="fw-bold mb-0">ĐĂNG NHẬP</h3>
        <small class="text-cli-primary">Chào mừng trở lại PolyOE!</small>
    </div>
    <div class="card-body p-4">
        <c:if test="${not empty message}">
            <div class="alert alert-danger text-center">${message}</div>
        </c:if>

        <form action="<c:url value='/login'/>" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Tên đăng nhập</label>
                <input type="text" name="id" class="form-control" placeholder="Nhập username (vd: admin)" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Mật khẩu</label>
                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-cli-primary py-2">Đăng nhập ngay</button>
            </div>

            <div class="d-grid">
                <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/PolyOE_ASM/login-google&response_type=code&client_id=YOUR_CLIENT_ID"
                   class="btn btn-outline-dark py-2">
                    <i class="bi bi-google me-2"></i> Đăng nhập bằng Google
                </a>
            </div>
        </form>
        <div class="d-flex justify-content-between mb-4 align-items-center">
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="remember">
                <label class="form-check-label small text-muted" for="remember">Ghi nhớ tôi?</label>
            </div>

            <a href="<c:url value='/forgot-password'/>"
               class="text-decoration-none small fw-bold link-forgot">
                Quên mật khẩu?
            </a>
        </div>
    </div>
    <div class="card-footer text-center bg-white border-0 pb-4">
        <a href="<c:url value='/home'/>" class="text-decoration-none text-muted small">
            <i class="bi bi-arrow-left"></i> Quay lại trang chủ
        </a>
    </div>
</div>

</body>
</html>