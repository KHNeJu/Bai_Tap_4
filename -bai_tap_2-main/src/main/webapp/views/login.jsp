<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập</title>
</head>
<body>
    <h1>Trang Đăng Nhập</h1>
    <c:if test="${alert != null}">
        <h3 style="color: red;">${alert}</h3>
    </c:if>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <br>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <br>
        <div>
            <input type="checkbox" id="remember" name="remember" value="on">
            <label for="remember">Nhớ đăng nhập</label>
        </div>
        <br>
        <button type="submit">Đăng nhập</button>
    </form>
    <br>
    <a href="${pageContext.request.contextPath}/register">Chưa có tài khoản? Đăng ký ngay</a>
</body>
</html>
