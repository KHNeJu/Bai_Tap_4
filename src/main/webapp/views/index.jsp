<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ</title>
</head>
<body>
    <h1>Chào mừng đến với trang chủ!</h1>
    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <p>Xin chào, <strong>${sessionScope.account.fullName}</strong>!</p>
            <p><a href="<c:url value='/profile'/>">Xem và cập nhật hồ sơ cá nhân</a></p>
        </c:when>
        <c:otherwise>
            <p><a href="<c:url value='/login'/>">Đăng nhập</a> để sử dụng đầy đủ tính năng.</p>
        </c:otherwise>
    </c:choose>
</body>
</html>