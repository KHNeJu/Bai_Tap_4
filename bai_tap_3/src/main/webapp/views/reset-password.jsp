<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html><head><title>Đặt lại mật khẩu</title></head><body>
<h1>Đặt lại mật khẩu</h1>
<% if (request.getAttribute("alert") != null) { %><p style="color:red"><%= request.getAttribute("alert") %></p><% } %>
<form action="${pageContext.request.contextPath}/forgot-password/verify" method="post">
    <label>OTP</label><input name="otp" required pattern="[0-9]{6}" maxlength="6">
    <label>Mật khẩu mới</label><input type="password" name="password" required minlength="6" maxlength="255">
    <button type="submit">Đổi mật khẩu</button>
</form>
<button type="button" onclick="window.history.back()">← Quay lại</button>
</body></html>
