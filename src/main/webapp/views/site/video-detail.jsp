<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${video.title} | PolyOE</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<jsp:include page="/views/common/header.jsp" />

<div class="container my-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 mb-4">
                <div class="ratio ratio-16x9">
                    <iframe src="https://www.youtube.com/embed/${video.id}?rel=0&autoplay=1"
                            title="YouTube video player"
                            allowfullscreen
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture">
                    </iframe>
                </div>
                <div class="card-body">
                    <h3 class="fw-bold" style="color: var(--cli-dark);">${video.title}</h3>
                    <div class="d-flex align-items-center text-muted small mb-3">
                        <span class="me-3"><i class="bi bi-eye-fill"></i> ${video.views} lượt xem</span>
                        <span><i class="bi bi-calendar3"></i> 2024</span>
                    </div>
                    <p class="card-text">${video.description}</p>

                    <hr>

                    <div class="d-flex gap-2">
                        <a href="<c:url value='/video/like?id=${video.id}'/>" class="btn btn-cli-primary rounded-pill px-4">
                            <i class="bi bi-hand-thumbs-up-fill"></i> Thích
                        </a>

                        <button type="button" class="btn btn-outline-secondary rounded-pill px-4"
                                data-bs-toggle="modal"
                                data-bs-target="#shareModalDetail">
                            <i class="bi bi-share-fill"></i> Chia sẻ
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <h5 class="fw-bold mb-3 border-start border-4 border-warning ps-2 text-uppercase" style="color: var(--cli-dark);">
                Có thể bạn thích
            </h5>

            <div class="list-group shadow-sm">
                <c:forEach items="${items}" var="item" end="4"> <a href="<c:url value='/video/detail?id=${item.id}'/>" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
                    <img src="https://img.youtube.com/vi/${item.id}/hqdefault.jpg"
                         alt="${item.title}" width="100" height="60"
                         class="rounded flex-shrink-0 object-fit-cover">
                    <div class="d-flex gap-2 w-100 justify-content-between">
                        <div>
                            <h6 class="mb-0 fw-bold text-truncate" style="max-width: 150px;">${item.title}</h6>
                            <small class="opacity-50 text-nowrap"><i class="bi bi-eye"></i> ${item.views}</small>
                        </div>
                    </div>
                </a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="shareModalDetail" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <div class="modal-header bg-cli-dark text-white">
                <h5 class="modal-title fw-bold">
                    <i class="bi bi-envelope-paper-heart text-cli-primary"></i> Chia sẻ video này
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<c:url value='/video/share'/>" method="post">
                <div class="modal-body p-4">
                    <input type="hidden" name="videoId" value="${video.id}">

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
</body>
</html>