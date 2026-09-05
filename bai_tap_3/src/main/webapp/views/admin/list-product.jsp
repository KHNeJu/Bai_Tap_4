<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<h1>Quản lý sản phẩm</h1>
<a class="btn btn-primary mb-3" href="<c:url value='/admin/product/add'/>">Thêm sản phẩm</a>
<table class="table table-bordered"><thead><tr><th>Tên</th><th>Giá</th><th>Số lượng</th><th>Danh mục</th><th>Thao tác</th></tr></thead><tbody>
<c:forEach var="product" items="${products}"><tr><td>${product.name}</td><td>${product.price}</td><td>${product.quantity}</td><td>${product.category.categoryName}</td><td>
<a class="btn btn-sm btn-warning" href="<c:url value='/admin/product/edit'><c:param name='id' value='${product.id}'/></c:url>">Sửa</a>
<form method="post" action="<c:url value='/admin/product/delete'/>" style="display:inline"><input type="hidden" name="id" value="${product.id}"><button class="btn btn-sm btn-danger" onclick="return confirm('Xóa sản phẩm này?')">Xóa</button></form>
</td></tr></c:forEach></tbody></table>
