<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Người dùng</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        .nav-tabs .nav-link { color: var(--adm-primary); font-weight: bold; }
        .nav-tabs .nav-link.active { color: var(--adm-accent); border-bottom: 3px solid var(--adm-accent); }
        .form-label { color: var(--adm-primary); font-weight: 600; }
        .btn-adm-primary { background-color: var(--adm-accent); color: white; border: none; }
        .btn-adm-primary:hover { background-color: var(--adm-highlight); color: white; }
    </style>
</head>
<body>

<jsp:include page="/views/common/admin-header.jsp" />

<div class="p-4">
    <h3 class="mb-4 fw-bold" style="color: var(--adm-primary);">
        <i class="bi bi-people-fill me-2"></i> QUẢN LÝ NGƯỜI DÙNG
    </h3>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="bi bi-check-circle-fill me-2"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card border-0 shadow-sm rounded-3">
        <div class="card-body">
            <ul class="nav nav-tabs mb-4" id="userTabs" role="tablist">
                <li class="nav-item">
                    <button class="nav-link active" id="edit-tab" data-bs-toggle="tab" data-bs-target="#edit" type="button">
                        <i class="bi bi-pencil-square"></i> CẬP NHẬT
                    </button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" id="list-tab" data-bs-toggle="tab" data-bs-target="#list" type="button">
                        <i class="bi bi-list-ul"></i> DANH SÁCH
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="userTabsContent">

                <div class="tab-pane fade show active" id="edit" role="tabpanel">
                    <form action="<c:url value='/admin/user'/>" method="post">
                        <div class="row justify-content-center">
                            <div class="col-md-8">
                                <div class="card border-light bg-light">
                                    <div class="card-body p-4">
                                        <div class="mb-3">
                                            <label class="form-label">Tên đăng nhập (Username)</label>
                                            <input type="text" name="id" class="form-control" value="${form.id}" placeholder="Nhập username..." required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu</label>
                                            <input type="password" name="password" class="form-control" value="${form.password}" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Họ và tên</label>
                                            <input type="text" name="fullname" class="form-control" value="${form.fullname}" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Địa chỉ Email</label>
                                            <input type="email" name="email" class="form-control" value="${form.email}" required>
                                        </div>

                                        <div class="mb-4">
                                            <label class="form-label">Vai trò</label>
                                            <div class="d-flex gap-4 p-2 border rounded bg-white">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="admin" value="false" ${!form.admin ? 'checked' : ''}>
                                                    <label class="form-check-label">Người dùng (User)</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="admin" value="true" ${form.admin ? 'checked' : ''}>
                                                    <label class="form-check-label text-danger fw-bold">Quản trị viên (Admin)</label>
                                                </div>
                                            </div>
                                        </div>

                                        <hr>

                                        <div class="d-flex gap-2 justify-content-end">
                                            <button type="submit" formaction="<c:url value='/admin/user/create'/>" class="btn btn-adm-primary px-4">
                                                <i class="bi bi-plus-lg"></i> Thêm
                                            </button>
                                            <button type="submit" formaction="<c:url value='/admin/user/update'/>" class="btn btn-success px-4">
                                                <i class="bi bi-save"></i> Lưu
                                            </button>
                                            <button type="submit" formaction="<c:url value='/admin/user/delete'/>" class="btn btn-danger px-4">
                                                <i class="bi bi-trash"></i> Xóa
                                            </button>
                                            <button type="submit" formaction="<c:url value='/admin/user/reset'/>" class="btn btn-secondary px-4">
                                                <i class="bi bi-arrow-counterclockwise"></i> Mới
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="tab-pane fade" id="list" role="tabpanel">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle bg-white">
                            <thead class="text-white text-center" style="background-color: var(--adm-primary);">
                            <tr>
                                <th>Username</th>
                                <th>Họ và tên</th>
                                <th>Email</th>
                                <th>Vai trò</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${items}" var="item">
                                <tr>
                                    <td class="fw-bold">${item.id}</td>
                                    <td>${item.fullname}</td>
                                    <td>${item.email}</td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${item.admin}">
                                                <span class="badge bg-danger rounded-pill">Admin</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary rounded-pill">User</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="<c:url value='/admin/user/edit/${item.id}'/>" class="btn btn-outline-primary btn-sm">
                                            <i class="bi bi-pencil-fill"></i> Sửa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/admin-footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>