<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký</title>
</head>
<body>
    <h1>Đăng Ký Tài Khoản</h1>
    <c:if test="${alert != null}">
        <h3 style="color: red;">${alert}</h3>
    </c:if>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <div>
            <label>Username:</label>
            <input type="text" name="username" required>
        </div>
        <br>
        <div>
            <label>Password:</label>
            <input type="password" name="password" required>
        </div>
        <br>
        <div>
            <label>Email:</label>
            <input type="email" name="email" required>
        </div>
        <br>
        <div>
            <label>Full Name:</label>
            <input type="text" name="fullname" required>
        </div>
        <br>
        <div>
            <label>Phone:</label>
            <input type="text" name="phone">
        </div>
        <br>
        <button type="submit">Đăng ký</button>
    </form>
    <br>
    <a href="${pageContext.request.contextPath}/login">Đã có tài khoản? Đăng nhập</a>
</body>
</html>
