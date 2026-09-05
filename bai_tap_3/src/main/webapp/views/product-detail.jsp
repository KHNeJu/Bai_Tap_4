<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
	.detail-page { color: #1d2939; }
	.detail-breadcrumb { margin-bottom: 18px; color: #667085; font-size: .9rem; }
	.detail-breadcrumb a { color: #1769e0; text-decoration: none; }
	.detail-layout {
		display: grid;
		grid-template-columns: minmax(320px, .9fr) minmax(380px, 1.1fr);
		gap: 34px;
		padding: 22px;
		border: 1px solid #e5e7eb;
		background: #fff;
	}
	.detail-gallery { min-width: 0; }
	.detail-main-image {
		display: flex;
		align-items: center;
		justify-content: center;
		height: 440px;
		padding: 18px;
		border: 1px solid #eef0f3;
		background: #f8f9fb;
	}
	.detail-main-image img { width: 100%; height: 100%; object-fit: contain; }
	.detail-thumbnails { display: flex; gap: 10px; margin-top: 12px; }
	.detail-thumbnail {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 64px;
		height: 64px;
		padding: 4px;
		border: 2px solid #1769e0;
		background: #fff;
	}
	.detail-thumbnail img { max-width: 100%; max-height: 100%; object-fit: contain; }
	.detail-info h1 { margin: 0 0 14px; font-size: clamp(1.45rem, 2.7vw, 2.1rem); line-height: 1.3; }
	.detail-price-box { margin: 16px 0 22px; padding: 18px; background: #fff4f3; }
	.detail-price { color: #d70018; font-size: 2rem; font-weight: 700; }
	.detail-label { display: inline-block; min-width: 92px; color: #667085; }
	.detail-option { display: flex; align-items: center; gap: 12px; margin: 20px 0; }
	.detail-quantity { width: 110px; height: 38px; padding: 0 10px; border: 1px solid #d0d5dd; text-align: center; }
	.detail-actions { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 24px; }
	.detail-actions a { min-width: 180px; padding: 12px 18px; text-align: center; text-decoration: none; }
	.detail-add { border: 1px solid #1769e0; color: #1769e0; background: #eff6ff; }
	.detail-buy { color: #fff; background: #d70018; }
	.detail-description { margin-top: 24px; padding: 24px; border: 1px solid #e5e7eb; background: #fff; }
	.detail-description h2 { margin: 0 0 16px; font-size: 1.3rem; }
	.detail-description p { margin: 0; color: #475467; line-height: 1.8; white-space: pre-line; }
	.detail-back { display: inline-block; margin-top: 20px; color: #1769e0; text-decoration: none; }
	@media (max-width: 800px) {
		.detail-layout { grid-template-columns: 1fr; padding: 14px; }
		.detail-main-image { height: 330px; }
	}
</style>

<c:choose>
	<c:when test="${not empty product}">
		<div class="detail-page">
			<div class="detail-breadcrumb"><a href="<c:url value='/home'/>">Trang chủ</a> / <a href="<c:url value='/product'/>">Sản phẩm</a> / Chi tiết</div>
			<div class="detail-layout">
				<section class="detail-gallery">
					<div class="detail-main-image">
						<c:choose>
							<c:when test="${not empty product.image}">
								<c:choose>
									<c:when test="${product.image.startsWith('http://') or product.image.startsWith('https://')}"><img src="${product.image}" alt="${product.name}"></c:when>
									<c:otherwise><c:url value="/image" var="productImage"><c:param name="fname" value="${product.image}"/></c:url><img src="${productImage}" alt="${product.name}"></c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise><span class="text-muted">Sản phẩm chưa có hình ảnh</span></c:otherwise>
						</c:choose>
					</div>
					<c:if test="${not empty product.image}">
						<div class="detail-thumbnails"><div class="detail-thumbnail">
							<c:choose><c:when test="${product.image.startsWith('http://') or product.image.startsWith('https://')}"><img src="${product.image}" alt="Ảnh nhỏ ${product.name}"></c:when><c:otherwise><c:url value="/image" var="productImage"><c:param name="fname" value="${product.image}"/></c:url><img src="${productImage}" alt="Ảnh nhỏ ${product.name}"></c:otherwise></c:choose>
						</div></div>
					</c:if>
				</section>

				<section class="detail-info">
					<h1>${product.name}</h1>
					<div class="detail-price-box"><span class="detail-price">${product.formattedPrice} đ</span></div>
					<div><span class="detail-label">Danh mục</span><strong>${product.category.categoryName}</strong></div>
					<div class="detail-option"><span class="detail-label">Số lượng</span><input class="detail-quantity" type="number" min="1" max="${product.quantity}" value="1"><span class="text-secondary">${product.quantity} sản phẩm có sẵn</span></div>
					<div class="detail-actions">
						<a class="detail-add" href="<c:url value='/product'/>">Tiếp tục xem sản phẩm</a>
						<c:if test="${empty sessionScope.account}">
							<a class="detail-buy" href="<c:url value='/login'/>">Đăng nhập để đặt hàng</a>
						</c:if>
					</div>
				</section>
			</div>
			<section class="detail-description">
				<h2>Mô tả sản phẩm</h2>
				<p><c:choose><c:when test="${not empty product.description}">${product.description}</c:when><c:otherwise>Chưa có mô tả cho sản phẩm này.</c:otherwise></c:choose></p>
			</section>
			<a class="detail-back" href="<c:url value='/home'/>">← Quay lại trang chủ</a>
		</div>
	</c:when>
	<c:otherwise>
		<h1>Không tìm thấy sản phẩm</h1><a href="<c:url value='/product'/>">Quay lại danh sách</a>
	</c:otherwise>
</c:choose>
