<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PolyOE - Trang chủ</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<jsp:include page="/views/common/header.jsp" />

<div class="hero-banner text-center mb-4 shadow-sm">
    <div class="container py-4">
        <h1 class="display-5 fw-bold text-white">
            PHIM HAY <span class="text-cli-primary">MỖI NGÀY</span>
        </h1>
        <p class="lead text-white-50">Tuyển tập các tiểu phẩm hài đặc sắc nhất FPT Polytechnic</p>
    </div>
</div>

<div class="container mb-5">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold border-start border-4 border-warning ps-3 text-uppercase" style="color: var(--cli-dark);">
            Video Bạn Yêu Thích
        </h4>
    </div>

    <div class="row g-4">
        <c:forEach items="${favorites}" var="item">
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card movie-card h-100 shadow-sm">
                    <div class="position-relative">
                        <a href="<c:url value='/video/detail?id=${item.video.id}'/>">
                            <img src="${item.video.poster}"
                                 class="card-img-top"
                                 alt="${item.video.title}"
                                 onerror="this.src='https://placehold.co/600x400?text=No+Image'">
                        </a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title fw-bold text-truncate video-title">
                            <a href="<c:url value='/video/detail?id=${item.video.id}'/>" class="text-decoration-none">
                                    ${item.video.title}
                            </a>
                        </h5>
                    </div>
                    <div class="card-footer card-footer-custom bg-white d-flex justify-content-between align-items-center py-3">
                        <a href="<c:url value='/video/like?id=${item.video.id}'/>" class="btn btn-danger btn-sm px-4 rounded-pill shadow-sm">
                            <i class="bi bi-hand-thumbs-down-fill"></i> Bỏ thích
                        </a>

                        <button type="button"
                                class="btn btn-outline-secondary btn-sm px-4 rounded-pill shadow-sm"
                                data-bs-toggle="modal"
                                data-bs-target="#shareModal"
                                onclick="setShareId('${item.id}')">
                            <i class="bi bi-share-fill"></i> Share
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty items}">
            <div class="col-12 text-center py-5">
                <p class="text-muted">Chưa có video nào được yêu thích cả bạn nhỉ?.</p>
            </div>
        </c:if>
    </div>

    <nav aria-label="Page navigation" class="mt-5">
        <ul class="pagination justify-content-center">
            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/home?page=1'/>">
                    <i class="bi bi-skip-start-fill"></i>
                </a>
            </li>

            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/home?page=${currentPage - 1}'/>">
                    <i class="bi bi-chevron-double-left"></i>
                </a>
            </li>

            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>

            <li class="page-item">
                <a class="page-link" href="<c:url value='/home?page=${currentPage + 1}'/>">
                    <i class="bi bi-chevron-double-right"></i>
                </a>
            </li>

            <li class="page-item">
                <a class="page-link" href="<c:url value='/home?page=max'/>">
                    <i class="bi bi-skip-end-fill"></i>
                </a>
            </li>
        </ul>
    </nav>
</div>

<div class="modal fade" id="shareModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-cli-dark text-white">
                <h5 class="modal-title fw-bold">
                    <i class="bi bi-envelope-paper-heart text-cli-primary"></i> Chia sẻ với bạn bè
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<c:url value='/video/share'/>" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="videoId" id="shareVideoIdHome">

                    <div class="mb-3">
                        <label class="form-label fw-bold text-secondary">Email người nhận:</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-envelope"></i></span>
                            <input type="email" name="email" class="form-control" placeholder="nhapemail@example.com" required>
                        </div>
                        <div class="form-text mt-2">PolyOE sẽ gửi đường dẫn video này ngay lập tức.</div>
                    </div>
                </div>
                <div class="modal-footer border-top-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-cli-primary px-4 fw-bold">Gửi ngay</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>

<script>
    function setShareId(id) {
        document.getElementById('shareVideoId').value = id;
    }
</script>
</body>
</html>