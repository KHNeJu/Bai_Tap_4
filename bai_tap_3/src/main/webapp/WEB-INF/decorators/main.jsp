<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <sitemesh:write property="head"/>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-semibold" href="<c:url value='/home'/>">Web</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav" aria-controls="mainNav" aria-expanded="false" aria-label="Mở menu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mainNav">
                <div class="navbar-nav me-auto">
                    <a class="nav-link" href="<c:url value='/home'/>">Trang chủ</a>
                    <a class="nav-link" href="<c:url value='/product'/>">Sản phẩm</a>
                    <c:if test="${not empty sessionScope.account}">
                        <a class="nav-link" href="<c:url value='/profile'/>">Hồ sơ</a>
                        <c:if test="${sessionScope.account.roleid == 1}">
                            <a class="nav-link" href="<c:url value='/admin/category/list'/>">Quản lý danh mục</a>
                            <a class="nav-link" href="<c:url value='/admin/product/list'/>">Quản lý sản phẩm</a>
                        </c:if>
                    </c:if>
                </div>
                <div class="navbar-nav">
                    <c:if test="${not empty sessionScope.account}">
                        <span class="navbar-text me-lg-3">Xin chào, ${sessionScope.account.userName}</span>
                        <a class="nav-link" href="<c:url value='/logout'/>">Đăng xuất</a>
                    </c:if>
                    <c:if test="${empty sessionScope.account}">
                        <a class="nav-link" href="<c:url value='/login'/>">Đăng nhập</a>
                        <a class="nav-link" href="<c:url value='/register'/>">Đăng ký</a>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>
    <main class="container py-4">
        <div class="bg-white rounded-3 shadow-sm p-3 p-md-4">
            <c:if test="${empty requestScope.hideBackButton}">
                <button type="button" class="btn btn-outline-secondary btn-sm mb-3" onclick="window.history.back()">← Quay lại</button>
            </c:if>
            <sitemesh:write property="body"/>
        </div>
    </main>
    <footer class="container text-center text-secondary py-4 small">&copy; 2026 BaiTap Servlet JSP</footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
