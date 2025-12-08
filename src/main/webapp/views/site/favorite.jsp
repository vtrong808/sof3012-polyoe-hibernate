<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Video Yêu Thích | PolyOE</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<jsp:include page="/views/common/header.jsp" />

<div class="container my-5">
    <div class="d-flex align-items-center mb-4 border-bottom border-2 border-warning pb-2">
        <h3 class="fw-bold text-uppercase mb-0" style="color: var(--cli-dark);">
            <i class="bi bi-heart-fill text-danger me-2"></i> Danh sách Yêu thích
        </h3>
        <span class="ms-3 badge bg-secondary rounded-pill">${favorites.size()} video</span>
    </div>

    <div class="row g-4">
        <c:forEach items="${favorites}" var="item">
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card movie-card h-100 shadow-sm">

                    <div class="position-relative">
                        <a href="<c:url value='/video/detail?id=${item.video.id}'/>">
                            <img src="https://img.youtube.com/vi/${item.video.id}/hqdefault.jpg"
                                 class="card-img-top"
                                 alt="${item.video.title}"
                                 style="height: 200px; object-fit: cover;">
                        </a>
                        <div class="position-absolute bottom-0 end-0 bg-dark text-white px-2 py-1 opacity-75 small">
                            <i class="bi bi-calendar3"></i> <fmt:formatDate value="${item.likeDate}" pattern="dd/MM/yyyy"/>
                        </div>
                    </div>

                    <div class="card-body">
                        <h5 class="card-title fw-bold text-truncate video-title">
                            <a href="<c:url value='/video/detail?id=${item.video.id}'/>" class="text-decoration-none">
                                    ${item.video.title}
                            </a>
                        </h5>
                        <p class="card-text text-muted small">
                            <i class="bi bi-eye-fill"></i> <fmt:formatNumber value="${item.video.views}" /> lượt xem
                        </p>
                    </div>

                    <div class="card-footer card-footer-custom bg-white d-flex justify-content-between align-items-center py-3">
                        <a href="<c:url value='/video/like?id=${item.video.id}'/>"
                           class="btn btn-danger btn-sm px-3 rounded-pill shadow-sm"
                           onclick="return confirm('Bạn có chắc muốn bỏ thích video này?')">
                            <i class="bi bi-heartbreak-fill"></i> Bỏ thích
                        </a>

                        <button type="button"
                                class="btn btn-outline-secondary btn-sm px-3 rounded-pill shadow-sm"
                                data-bs-toggle="modal"
                                data-bs-target="#shareModalFav"
                                onclick="setShareIdFav('${item.video.id}')">
                            <i class="bi bi-share-fill"></i> Share
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty favorites}">
            <div class="col-12 text-center py-5">
                <img src="https://cdni.iconscout.com/illustration/premium/thumb/empty-state-2130362-1800926.png"
                     width="200" alt="Empty">
                <p class="text-muted mt-3">Bạn chưa thích video nào cả. Hãy quay lại trang chủ và khám phá nhé!</p>
                <a href="<c:url value='/home'/>" class="btn btn-cli-primary fw-bold">Về trang chủ</a>
            </div>
        </c:if>
    </div>
</div>

<div class="modal fade" id="shareModalFav" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-cli-dark text-white">
                <h5 class="modal-title fw-bold">
                    <i class="bi bi-gift-fill text-cli-primary"></i> Chia sẻ video này
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="<c:url value='/video/share'/>" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="videoId" id="shareVideoIdFav">
                    <div class="mb-3">
                        <label class="form-label fw-bold text-secondary">Email người nhận:</label>
                        <input type="email" name="email" class="form-control" placeholder="friend@example.com" required>
                    </div>
                </div>
                <div class="modal-footer border-top-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-cli-primary px-4 fw-bold">Gửi đi</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/common/footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
<script>
    function setShareIdFav(id) {
        document.getElementById('shareVideoIdFav').value = id;
    }
</script>
</body>
</html>