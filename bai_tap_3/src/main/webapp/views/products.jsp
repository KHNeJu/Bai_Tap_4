<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    .product-page-header {
        display: flex;
        align-items: end;
        justify-content: space-between;
        gap: 16px;
        margin-bottom: 18px;
    }

    .product-page-header h1 { margin: 0; font-size: 1.8rem; }
    .product-page-header p { margin: 5px 0 0; color: #68758a; }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(6, minmax(0, 1fr));
        gap: 12px;
    }

    .shop-card {
        position: relative;
        min-width: 0;
        overflow: hidden;
        border: 1px solid #e3e7ed;
        border-radius: 8px;
        background: #fff;
        box-shadow: 0 2px 8px rgba(31, 48, 74, .08);
        transition: transform .18s ease, box-shadow .18s ease;
    }

    .shop-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 9px 18px rgba(31, 48, 74, .14);
    }

    .shop-card-badge {
        position: absolute;
        z-index: 1;
        top: 8px;
        left: 8px;
        padding: 4px 7px;
        border-radius: 4px;
        color: #fff;
        background: #d70018;
        font-size: .7rem;
        font-weight: 700;
    }

    .shop-card-image {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 190px;
        padding: 8px;
        background: #f8f9fb;
    }

    .shop-card-image img {
        width: 100%;
        height: 100%;
        object-fit: contain;
    }

    .shop-card-body { padding: 11px; }

    .shop-card-title {
        display: -webkit-box;
        min-height: 43px;
        overflow: hidden;
        color: #172033;
        font-size: .95rem;
        font-weight: 600;
        line-height: 1.4;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
    }

    .shop-card-price {
        margin-top: 9px;
        color: #d70018;
        font-size: 1.05rem;
        font-weight: 700;
    }

    .shop-card-meta {
        min-height: 20px;
        margin-top: 7px;
        color: #68758a;
        font-size: .78rem;
    }

    .shop-card-link {
        display: block;
        margin-top: 10px;
        padding: 7px 4px;
        border: 1px solid #1769e0;
        border-radius: 5px;
        color: #1769e0;
        text-align: center;
        font-size: .86rem;
        font-weight: 600;
        text-decoration: none;
    }

    .shop-card-link:hover { color: #fff; background: #1769e0; }

    @media (max-width: 1200px) { .product-grid { grid-template-columns: repeat(4, minmax(0, 1fr)); } }
    @media (max-width: 800px) { .product-grid { grid-template-columns: repeat(3, minmax(0, 1fr)); } }
    @media (max-width: 560px) {
        .product-page-header { display: block; }
        .product-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 9px; }
        .shop-card-image { height: 160px; }
        .shop-card-body { padding: 9px; }
    }
</style>

<div class="product-page-header">
    <div><h1>Sản phẩm</h1><p>Khám phá các sản phẩm mới nhất</p></div>
    <span class="text-secondary">${totalPages} trang</span>
</div>

<div class="product-grid">
    <c:forEach var="product" items="${products}">
        <article class="shop-card">
            <span class="shop-card-badge">Mới</span>
            <div class="shop-card-image">
                <c:choose>
                    <c:when test="${not empty product.image}"><img src="${product.image}" alt="${product.name}"></c:when>
                    <c:otherwise><span class="text-muted">Chưa có ảnh</span></c:otherwise>
                </c:choose>
            </div>
            <div class="shop-card-body">
                <div class="shop-card-title">${product.name}</div>
                <div class="shop-card-price">${product.formattedPrice} đ</div>
                <div class="shop-card-meta">Còn ${product.quantity} sản phẩm</div>
                <a class="shop-card-link" href="<c:url value='/product/detail'><c:param name='id' value='${product.id}'/></c:url>">Xem chi tiết</a>
            </div>
        </article>
    </c:forEach>
</div>

<c:if test="${empty products}"><p>Chưa có sản phẩm.</p></c:if>
<c:if test="${totalPages > 1}"><nav class="mt-4"><ul class="pagination">
<c:forEach begin="1" end="${totalPages}" var="page"><li class="page-item ${page - 1 == currentPage ? 'active' : ''}"><a class="page-link" href="<c:url value='/product'><c:param name='page' value='${page}'/></c:url>">${page}</a></li></c:forEach>
</ul></nav></c:if>
