<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa danh mục</title>
</head>
<body>
    <h1>Sửa Danh Mục</h1>
    <c:if test="${alert != null}">
        <h3 style="color: red;">${alert}</h3>
    </c:if>
    <form role="form" action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category.categoryId}">
        <div>
            <label>Tên danh mục:</label>
            <input class="form-control" type="text" name="categoryName" value="${category.categoryName}" required minlength="1" maxlength="50">
        </div>
        <br>
        <div>
            <c:if test="${not empty category.images}">
                <c:choose>
                    <c:when test="${category.images.startsWith('http://') or category.images.startsWith('https://')}">
                        <c:set var="imgUrl" value="${category.images}" />
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${category.images}" var="imgUrl" />
                    </c:otherwise>
                </c:choose>
                <img width="100px" src="${imgUrl}" alt="Ảnh hiện tại">
                <br>
            </c:if>
            <label>Link ảnh:</label>
            <input class="form-control" type="url" name="images" value="${category.images}" maxlength="500" placeholder="https://example.com/image.jpg">
            <br><br>
            <label>Thay đổi ảnh đại diện (để trống nếu không đổi):</label>
            <input class="form-control" type="file" name="icon" accept="image/*">
        </div>
        <br>
        <div>
            <label>Trạng thái:</label>
            <label><input type="radio" name="status" value="1" ${category.status == 1 ? 'checked' : ''}> Hoạt động</label>
            <label><input type="radio" name="status" value="0" ${category.status != 1 ? 'checked' : ''}> Khóa</label>
        </div>
        <br>
        <button class="btn btn-primary" type="submit">Cập nhật</button>
        <button class="btn btn-outline-secondary" type="reset">Hủy</button>
    </form>
    <br>
    <a href="<c:url value='/admin/category/list'/>">Trở về danh sách</a>
</body>
</html>
