<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html><head><title>Xác minh tài khoản</title></head><body>
<h1>Xác minh tài khoản</h1>
<p>Mã OTP đã được gửi đến email đăng ký.</p>
<% if (request.getAttribute("alert") != null) { %><p style="color:red"><%= request.getAttribute("alert") %></p><% } %>
<form action="${pageContext.request.contextPath}/register/verify" method="post">
    <label>Mã OTP</label><input name="otp" required pattern="[0-9]{6}" maxlength="6">
    <button type="submit">Kích hoạt tài khoản</button>
</form>
<button type="button" onclick="window.history.back()">← Quay lại</button>
</body></html>
