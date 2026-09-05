<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="editing" value="${not empty product}"/>
<h1>${editing ? 'Sửa sản phẩm' : 'Thêm sản phẩm'}</h1>
<c:if test="${not empty alert}"><p class="text-danger">${alert}</p></c:if>
<form method="post" action="<c:url value='${editing ? "/admin/product/update" : "/admin/product/insert"}'/>">
<c:if test="${editing}"><input type="hidden" name="id" value="${product.id}"></c:if>
<div class="mb-3"><label>Tên</label><input class="form-control" name="name" required maxlength="255" value="${product.name}"></div>
<div class="mb-3"><label>Mô tả</label><textarea class="form-control" name="description">${product.description}</textarea></div>
<div class="mb-3"><label>Giá</label><input class="form-control" type="text" inputmode="decimal" pattern="[0-9.,]+" name="price" required value="${product.price}" oninput="formatPrice(this)" onblur="formatPrice(this)"><small class="text-muted">Ví dụ: 9000000 sẽ hiển thị thành 9.000.000</small></div>
<div class="mb-3"><label>Số lượng</label><input class="form-control" type="number" min="0" name="quantity" required value="${product.quantity}"></div>
<div class="mb-3"><label>Ảnh URL</label><input class="form-control" name="image" maxlength="500" value="${product.image}"></div>
<div class="mb-3"><label>Danh mục</label><select class="form-select" name="categoryId" required><c:forEach var="category" items="${categories}"><option value="${category.categoryId}" ${product.category.categoryId == category.categoryId ? 'selected' : ''}>${category.categoryName}</option></c:forEach></select></div>
<button class="btn btn-primary" type="submit">Lưu</button> <a href="<c:url value='/admin/product/list'/>">Hủy</a>
</form>
<script>
	function formatPrice(input) {
		const digits = input.value.replace(/\D/g, '');
		input.value = digits ? digits.replace(/\B(?=(\d{3})+(?!\d))/g, '.') : '';
	}
</script>
