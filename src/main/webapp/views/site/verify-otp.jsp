<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực OTP - PolyOE</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">

<div class="card shadow-lg border-0 rounded-4" style="width: 400px;">
    <div class="card-header bg-cli-dark text-white text-center py-4 rounded-top-4">
        <h4 class="fw-bold mb-0">XÁC THỰC OTP</h4>
        <small class="text-cli-primary">Kiểm tra email của bạn nhé!</small>
    </div>

    <div class="card-body p-4">
        <c:if test="${not empty message}">
            <div class="alert alert-${not empty type ? type : 'danger'} text-center mb-3">
                    ${message}
            </div>
        </c:if>

        <p class="text-muted text-center small mb-4">
            Chúng tôi đã gửi một mã xác thực 6 số đến email của bạn. Mã này sẽ hết hạn sau 5 phút.
        </p>

        <form action="<c:url value='/verify-otp'/>" method="post">
            <div class="mb-4">
                <label class="form-label fw-bold text-secondary">Nhập mã OTP</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-shield-lock-fill"></i></span>
                    <input type="text" name="otp" class="form-control form-control-lg text-center fw-bold text-primary"
                           placeholder="------" maxlength="6" required autocomplete="off" style="letter-spacing: 5px;">
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-cli-primary py-2 fw-bold">
                    <i class="bi bi-check-circle-fill me-2"></i> Xác nhận
                </button>
            </div>
        </form>
    </div>

    <div class="card-footer text-center bg-white border-0 pb-4">
        <div class="d-flex justify-content-between px-3">
            <a href="<c:url value='/forgot-password'/>" class="text-decoration-none text-muted small">
                <i class="bi bi-arrow-counterclockwise"></i> Gửi lại mã
            </a>
            <a href="<c:url value='/login'/>" class="text-decoration-none text-muted small">
                <i class="bi bi-x-circle"></i> Hủy bỏ
            </a>
        </div>
    </div>
</div>

</body>
</html>