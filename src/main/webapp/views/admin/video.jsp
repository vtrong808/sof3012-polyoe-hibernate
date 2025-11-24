<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Video</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* Override style riêng cho trang này */
        .nav-tabs .nav-link {
            color: var(--adm-primary);
            font-weight: bold;
        }
        .nav-tabs .nav-link.active {
            color: var(--adm-accent);
            border-bottom: 3px solid var(--adm-accent);
        }
        .form-label {
            color: var(--adm-primary);
            font-weight: 600;
        }
        .btn-adm-primary {
            background-color: var(--adm-accent);
            color: white;
            border: none;
        }
        .btn-adm-primary:hover {
            background-color: var(--adm-highlight);
            color: white;
        }
    </style>
</head>
<body>

<jsp:include page="/views/common/admin-header.jsp" />

<div class="p-4">
    <h3 class="mb-4 fw-bold" style="color: var(--adm-primary);">
        <i class="bi bi-collection-play me-2"></i> QUẢN LÝ VIDEO
    </h3>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card border-0 shadow-sm rounded-3">
        <div class="card-body">
            <ul class="nav nav-tabs mb-4" id="videoTabs" role="tablist">
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

            <div class="tab-content" id="videoTabsContent">

                <div class="tab-pane fade show active" id="edit" role="tabpanel">
                    <form action="<c:url value='/admin/video'/>" method="post">
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <div class="border rounded p-2 mb-3" style="background: #f8f9fa;">
                                    <img src="${video.poster != null ? video.poster : 'https://placehold.co/300x450?text=Poster'}"
                                         class="img-fluid rounded shadow-sm" style="max-height: 300px;"
                                         onerror="this.src='https://placehold.co/300x450?text=No+Image'">
                                </div>
                                <small class="text-muted">Poster Preview</small>
                            </div>

                            <div class="col-md-8">
                                <div class="mb-3">
                                    <label class="form-label">Mã Video (Youtube ID)</label>
                                    <input type="text" name="id" class="form-control" value="${video.id}" placeholder="Ví dụ: dQw4w9WgXcQ" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tiêu đề Video</label>
                                    <input type="text" name="title" class="form-control" value="${video.title}" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Đường dẫn Poster (Link ảnh)</label>
                                    <input type="text" name="poster" class="form-control" value="${video.poster}">
                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Lượt xem</label>
                                        <input type="number" name="views" class="form-control" value="${video.views}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Trạng thái</label>
                                        <div class="d-flex gap-3 mt-2">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="active" value="true" ${video.active ? 'checked' : ''}>
                                                <label class="form-check-label">Hoạt động</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="active" value="false" ${!video.active ? 'checked' : ''}>
                                                <label class="form-check-label">Ngừng chiếu</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-4">
                                    <label class="form-label">Mô tả</label>
                                    <textarea name="description" class="form-control" rows="4">${video.description}</textarea>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" formaction="<c:url value='/admin/video/create'/>" class="btn btn-adm-primary px-4">
                                        <i class="bi bi-plus-lg"></i> Thêm mới
                                    </button>
                                    <button type="submit" formaction="<c:url value='/admin/video/update'/>" class="btn btn-success px-4">
                                        <i class="bi bi-save"></i> Cập nhật
                                    </button>
                                    <button type="submit" formaction="<c:url value='/admin/video/delete'/>" class="btn btn-danger px-4">
                                        <i class="bi bi-trash"></i> Xóa
                                    </button>
                                    <button type="submit" formaction="<c:url value='/admin/video/reset'/>" class="btn btn-secondary px-4">
                                        <i class="bi bi-arrow-counterclockwise"></i> Làm mới
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="tab-pane fade" id="list" role="tabpanel">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle">
                            <thead class="text-white text-center" style="background-color: var(--adm-primary);">
                            <tr>
                                <th>Mã Video</th>
                                <th>Tiêu đề</th>
                                <th>Lượt xem</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${items}" var="item">
                                <tr>
                                    <td class="text-center fw-bold">${item.id}</td>
                                    <td>${item.title}</td>
                                    <td class="text-center">${item.views}</td>
                                    <td class="text-center">
                                                <span class="badge ${item.active ? 'bg-success' : 'bg-secondary'} rounded-pill">
                                                        ${item.active ? 'Active' : 'Inactive'}
                                                </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="<c:url value='/admin/video/edit/${item.id}'/>" class="btn btn-outline-primary btn-sm">
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