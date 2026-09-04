<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hồ sơ cá nhân</title>
</head>
<body>
    <h1 class="h3 mb-4">Hồ sơ cá nhân</h1>

    <c:if test="${alert != null}">
        <p class="text-danger">${alert}</p>
    </c:if>
    <c:if test="${success != null}">
        <p class="text-success">${success}</p>
    </c:if>

    <form action="<c:url value='/profile/update'/>" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label>Tên đăng nhập:</label>
            <input class="form-control" type="text" value="${user.userName}" disabled>
        </div>
        <div class="mb-3">
            <label>Email:</label>
            <input class="form-control" type="email" value="${user.email}" disabled>
        </div>
        <div class="mb-3">
            <label for="fullName">Họ và tên:</label>
            <input class="form-control" type="text" id="fullName" name="fullName" value="${user.fullName}" required minlength="2" maxlength="255">
        </div>
        <div class="mb-3">
            <label for="phone">Số điện thoại:</label>
            <input class="form-control" type="tel" id="phone" name="phone" value="${user.phone}" maxlength="20" pattern="[0-9+() .-]{7,20}" title="Số điện thoại không hợp lệ">
        </div>
        <div class="mb-3">
            <c:if test="${not empty user.avatar}">
                <c:choose>
                    <c:when test="${user.avatar.startsWith('http://') or user.avatar.startsWith('https://')}">
                        <c:set var="imgUrl" value="${user.avatar}" />
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${user.avatar}" var="imgUrl" />
                    </c:otherwise>
                </c:choose>
                <img class="img-thumbnail mb-2" width="120" height="120" src="${imgUrl}" alt="Ảnh đại diện hiện tại">
            </c:if>
            <label for="avatarUrl">Link ảnh đại diện:</label>
            <input class="form-control" type="url" id="avatarUrl" name="avatarUrl" value="${user.avatar}" maxlength="255" placeholder="https://example.com/avatar.jpg">
            <label class="mt-3" for="avatar">Hoặc tải ảnh lên:</label>
            <input class="form-control" type="file" id="avatar" name="avatar" accept="image/*">
        </div>
        <button class="btn btn-primary" type="submit">Cập nhật hồ sơ</button>
        <a class="btn btn-outline-secondary" href="<c:url value='/home'/>">Trang chủ</a>
    </form>
</body>
</html>
