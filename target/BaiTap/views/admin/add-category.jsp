<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm danh mục</title>
</head>
<body>
    <h1>Thêm Danh Mục Mới</h1>
    <c:if test="${alert != null}">
        <h3 style="color: red;">${alert}</h3>
    </c:if>
    <form role="form" action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
        <div>
            <label>Tên danh mục:</label>
            <input class="form-control" type="text" name="categoryName" required minlength="1" maxlength="50" placeholder="Nhập tên danh mục">
        </div>
        <br>
        <div>
            <label>Link ảnh (nếu có):</label>
            <input class="form-control" type="url" name="images" maxlength="500" placeholder="https://example.com/image.jpg">
        </div>
        <br>
        <div>
            <label>Ảnh đại diện:</label>
            <input class="form-control" type="file" name="icon" accept="image/*">
        </div>
        <br>
        <div>
            <label>Trạng thái:</label>
            <label><input type="radio" name="status" value="1" checked> Hoạt động</label>
            <label><input type="radio" name="status" value="0"> Khóa</label>
        </div>
        <br>
        <button class="btn btn-primary" type="submit">Thêm</button>
        <button class="btn btn-outline-secondary" type="reset">Hủy</button>
    </form>
    <br>
    <a href="<c:url value='/admin/category/list'/>">Trở về danh sách</a>
</body>
</html>
