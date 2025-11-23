<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu - PolyOE</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">

<div class="card shadow-lg border-0 rounded-4" style="width: 400px;">
    <div class="card-header bg-cli-dark text-white text-center py-4 rounded-top-4">
        <h4 class="fw-bold mb-0">QUÊN MẬT KHẨU?</h4>
        <small class="text-cli-primary">Đừng lo, chúng tôi sẽ giúp bạn lấy lại!</small>
    </div>
    <div class="card-body p-4">

        <c:if test="${not empty message}">
            <div class="alert alert-${not empty type ? type : 'danger'} text-center">
                    ${message}
            </div>
        </c:if>

        <form action="<c:url value='/forgot-password'/>" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold text-secondary">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control" placeholder="Nhập username" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold text-secondary">Email đăng ký</label>
                <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
            </div>

            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-cli-primary py-2 fw-bold">Lấy lại mật khẩu</button>
            </div>
        </form>
    </div>
    <div class="card-footer text-center bg-white border-0 pb-4">
        <a href="<c:url value='/login'/>" class="text-decoration-none text-muted small">
            <i class="bi bi-arrow-left"></i> Quay lại đăng nhập
        </a>
    </div>
</div>

</body>
</html>