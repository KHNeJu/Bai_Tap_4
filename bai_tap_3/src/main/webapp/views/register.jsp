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
            <input type="text" name="username" required minlength="3" maxlength="50" pattern="[A-Za-z0-9_]+" title="Username chỉ gồm chữ cái, số và dấu gạch dưới; dài từ 3 đến 50 ký tự">
        </div>
        <br>
        <div>
            <label>Password:</label>
            <input type="password" name="password" required minlength="6" maxlength="255">
        </div>
        <br>
        <div>
            <label>Email:</label>
            <input type="email" name="email" required maxlength="255">
        </div>
        <br>
        <div>
            <label>Full Name:</label>
            <input type="text" name="fullname" required minlength="2" maxlength="255">
        </div>
        <br>
        <div>
            <label>Phone:</label>
            <input type="tel" name="phone" maxlength="20" pattern="[0-9+() .-]{7,20}" title="Số điện thoại không hợp lệ">
        </div>
        <br>
        <button type="submit">Đăng ký</button>
    </form>
    <br>
    <a href="${pageContext.request.contextPath}/login">Đã có tài khoản? Đăng nhập</a>
    <br><button type="button" onclick="window.history.back()">← Quay lại</button>
</body>
</html>
