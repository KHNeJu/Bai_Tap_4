<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ cá nhân</title>
</head>
<body>
    <h1>Hồ sơ cá nhân</h1>

    <c:if test="${alert != null}">
        <p style="color: red;">${alert}</p>
    </c:if>
    <c:if test="${success != null}">
        <p style="color: green;">${success}</p>
    </c:if>

    <form action="<c:url value='/profile/update'/>" method="post" enctype="multipart/form-data">
        <div>
            <label>Tên đăng nhập:</label>
            <input type="text" value="${user.userName}" disabled>
        </div>
        <br>
        <div>
            <label>Email:</label>
            <input type="email" value="${user.email}" disabled>
        </div>
        <br>
        <div>
            <label for="fullName">Họ và tên:</label>
            <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
        </div>
        <br>
        <div>
            <label for="phone">Số điện thoại:</label>
            <input type="text" id="phone" name="phone" value="${user.phone}" maxlength="20">
        </div>
        <br>
        <div>
            <c:if test="${not empty user.avatar}">
                <c:choose>
                    <c:when test="${user.avatar.startsWith('http://') or user.avatar.startsWith('https://')}">
                        <c:set var="imgUrl" value="${user.avatar}" />
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${user.avatar}" var="imgUrl" />
                    </c:otherwise>
                </c:choose>
                <img width="120" height="120" src="${imgUrl}" alt="Ảnh đại diện hiện tại">
                <br>
            </c:if>
            <label for="avatarUrl">Link ảnh đại diện:</label>
            <input type="url" id="avatarUrl" name="avatarUrl" value="${user.avatar}" placeholder="https://example.com/avatar.jpg">
            <br><br>
            <label for="avatar">Hoặc tải ảnh lên (multipart):</label>
            <input type="file" id="avatar" name="avatar" accept="image/*">
        </div>
        <br>
        <button type="submit">Cập nhật hồ sơ</button>
        <a href="<c:url value='/home'/>">Trang chủ</a>
    </form>
</body>
</html>
