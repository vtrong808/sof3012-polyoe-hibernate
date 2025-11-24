<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo thống kê</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .nav-pills .nav-link { color: var(--adm-primary); font-weight: 600; }
        .nav-pills .nav-link.active { background-color: var(--adm-accent); color: white; }
    </style>
</head>
<body>

<jsp:include page="/views/common/admin-header.jsp" />

<div class="p-4">
    <h3 class="mb-4 fw-bold" style="color: var(--adm-primary);">
        <i class="bi bi-bar-chart-line-fill me-2"></i> BÁO CÁO & THỐNG KÊ
    </h3>

    <div class="card border-0 shadow-sm rounded-3">
        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
            <ul class="nav nav-pills card-header-pills">
                <li class="nav-item">
                    <a class="nav-link ${tab == 'favorite-users' ? 'active' : ''}"
                       href="<c:url value='/admin/reports?tab=favorite-users'/>">
                        <i class="bi bi-people-fill"></i> Người thích
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${tab == 'shared-friends' ? 'active' : ''}"
                       href="<c:url value='/admin/reports?tab=shared-friends'/>">
                        <i class="bi bi-send-fill"></i> Lượt chia sẻ
                    </a>
                </li>
            </ul>
        </div>

        <div class="card-body px-4 pb-4">

            <c:if test="${tab == 'shared-friends'}">
                <form action="<c:url value='/admin/reports'/>" method="get" class="row g-3 align-items-center mb-4 bg-light p-3 rounded">
                    <input type="hidden" name="tab" value="shared-friends">
                    <div class="col-auto">
                        <label class="col-form-label fw-bold text-secondary">Chọn Video:</label>
                    </div>
                    <div class="col-md-6">
                        <select name="id" class="form-select border-0 shadow-sm" onchange="this.form.submit()">
                            <c:forEach items="${vidList}" var="vid">
                                <option value="${vid.id}" ${vid.id == vidSelected ? 'selected' : ''}>
                                        ${vid.title}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </form>

                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="text-white text-center" style="background-color: var(--adm-primary);">
                        <tr>
                            <th>Người gửi (Sender)</th>
                            <th>Email người gửi</th>
                            <th>Email người nhận</th>
                            <th>Ngày gửi</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td class="fw-bold">${item[0]}</td>
                                <td>${item[1]}</td>
                                <td class="text-primary fw-bold">${item[2]}</td>
                                <td class="text-center">
                                    <fmt:formatDate value="${item[3]}" pattern="dd/MM/yyyy" />
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty items}">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">
                                    Chưa có lượt chia sẻ nào cho video này.
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${tab == 'favorite-users'}">
                <form action="<c:url value='/admin/reports'/>" method="get" class="row g-3 align-items-center mb-4 bg-light p-3 rounded">
                    <input type="hidden" name="tab" value="favorite-users">
                    <div class="col-auto">
                        <label class="col-form-label fw-bold text-secondary">Chọn Video:</label>
                    </div>
                    <div class="col-md-6">
                        <select name="id" class="form-select border-0 shadow-sm" onchange="this.form.submit()">
                            <c:forEach items="${vidList}" var="vid">
                                <option value="${vid.id}" ${vid.id == vidSelected ? 'selected' : ''}>${vid.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>

                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="text-white text-center" style="background-color: var(--adm-primary);">
                        <tr>
                            <th>Username</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Ngày thích</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td class="fw-bold">${item[0]}</td>
                                <td>${item[1]}</td>
                                <td>${item[2]}</td>
                                <td class="text-center"><fmt:formatDate value="${item[3]}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty items}">
                            <tr><td colspan="4" class="text-center text-muted py-4">Chưa có lượt thích nào.</td></tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </c:if>

        </div>
    </div>
</div>

<jsp:include page="/views/common/admin-footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>