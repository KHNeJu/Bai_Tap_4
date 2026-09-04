<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ</title>
</head>
<body>
    <h1 class="display-6 fw-semibold mb-3">Chào mừng đến với trang chủ!</h1>
    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <p class="lead">Xin chào, <strong>${sessionScope.account.fullName}</strong>!</p>
            <p><a class="btn btn-primary" href="<c:url value='/profile'/>">Xem và cập nhật hồ sơ cá nhân</a></p>
        </c:when>
        <c:otherwise>
            <p><a class="btn btn-primary" href="<c:url value='/login'/>">Đăng nhập</a> để sử dụng đầy đủ tính năng.</p>
        </c:otherwise>
    </c:choose>
</body>
</html>