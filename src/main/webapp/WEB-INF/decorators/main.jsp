<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:write property="title"/></title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: Arial, sans-serif; margin: 0; background: #f5f7fb; color: #222; }
        header { background: #1e3a8a; color: #fff; padding: 14px 24px; }
        header a { color: #fff; text-decoration: none; margin-right: 16px; }
        header a:hover { text-decoration: underline; }
        main { max-width: 960px; margin: 24px auto; background: #fff; padding: 24px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        footer { text-align: center; color: #666; padding: 16px; font-size: 14px; }
    </style>
    <sitemesh:write property="head"/>
</head>
<body>
    <header>
        <strong>BaiTap Web</strong>
        <nav style="display: inline-block; margin-left: 24px;">
            <a href="<c:url value='/home'/>">Trang chủ</a>
            <c:if test="${not empty sessionScope.account}">
                <a href="<c:url value='/profile'/>">Hồ sơ</a>
                <c:if test="${sessionScope.account.roleid == 1}">
                    <a href="<c:url value='/admin/category/list'/>">Quản lý danh mục</a>
                </c:if>
                <a href="<c:url value='/logout'/>">Đăng xuất (${sessionScope.account.userName})</a>
            </c:if>
            <c:if test="${empty sessionScope.account}">
                <a href="<c:url value='/login'/>">Đăng nhập</a>
                <a href="<c:url value='/register'/>">Đăng ký</a>
            </c:if>
        </nav>
    </header>
    <main>
        <sitemesh:write property="body"/>
    </main>
    <footer>&copy; 2026 BaiTap Servlet JSP</footer>
</body>
</html>
