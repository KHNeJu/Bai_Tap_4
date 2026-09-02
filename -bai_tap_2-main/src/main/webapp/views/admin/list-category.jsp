<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý danh mục</title>
</head>
<body>
    <h1>Danh sách danh mục</h1>
    <a href="<c:url value='/admin/category/add'/>">Thêm danh mục mới</a>
    <br><br>
    <table border="1" width="80%">
        <tr>
            <th>STT</th>
            <th>Hình ảnh</th>
            <th>Tên danh mục</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>
        <c:forEach items="${cateList}" var="cate" varStatus="STT">
            <tr>
                <td>${STT.index + 1}</td>
                <td>
                    <c:if test="${not empty cate.images}">
                        <c:choose>
                            <c:when test="${cate.images.startsWith('http://') or cate.images.startsWith('https://')}">
                                <c:set var="imgUrl" value="${cate.images}" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                            </c:otherwise>
                        </c:choose>
                        <img height="100" width="140" src="${imgUrl}" alt="${cate.categoryName}" />
                    </c:if>
                </td>
                <td>${cate.categoryName}</td>
                <td>${cate.status == 1 ? 'Hoạt động' : 'Khóa'}</td>
                <td>
                    <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>">Sửa</a> | 
                    <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" onclick="return confirm('Bạn có chắc muốn xoá?');">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <br>
    <a href="<c:url value='/logout'/>">Đăng xuất</a>
</body>
</html>
