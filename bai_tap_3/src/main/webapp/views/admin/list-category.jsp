<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý danh mục</title>
</head>
<body>
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
        <h1 class="h3 mb-0">Danh sách danh mục</h1>
        <a class="btn btn-primary" href="<c:url value='/admin/category/add'/>">Thêm danh mục mới</a>
    </div>
    <div class="table-responsive">
    <table class="table table-hover align-middle">
        <thead class="table-light"><tr>
            <th>STT</th>
            <th>Hình ảnh</th>
            <th>Tên danh mục</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr></thead>
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
                        <img class="img-thumbnail" height="100" width="140" src="${imgUrl}" alt="${cate.categoryName}" />
                    </c:if>
                </td>
                <td>${cate.categoryName}</td>
                <td>${cate.status == 1 ? 'Hoạt động' : 'Khóa'}</td>
                <td>
                    <a class="btn btn-sm btn-outline-primary" href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>">Sửa</a>
                    <a class="btn btn-sm btn-outline-danger" href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>" onclick="return confirm('Bạn có chắc muốn xoá?');">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    </div>
</body>
</html>
