<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ</title>
    <style>
        .latest-products {
            display: grid;
            grid-template-columns: repeat(5, minmax(190px, 1fr));
            gap: 16px;
        }

        .latest-product-card {
            min-width: 0;
            overflow: hidden;
            border: 1px solid #e3e7ed;
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 2px 8px rgba(25, 45, 75, .08);
        }

        .latest-product-image {
            height: 210px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 12px;
            background: #f7f9fb;
        }

        .latest-product-image img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .latest-product-content {
            padding: 14px;
        }

        .latest-product-name {
            min-height: 48px;
            margin-bottom: 10px;
            display: -webkit-box;
            overflow: hidden;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
            font-size: 1rem;
            font-weight: 600;
            line-height: 1.5;
        }

        .latest-product-price {
            margin-bottom: 12px;
            color: #d70018;
            font-size: 1.15rem;
            font-weight: 700;
        }

        .latest-product-link {
            display: block;
            width: 100%;
            text-align: center;
        }

        @media (max-width: 1100px) {
            .latest-products {
                grid-template-columns: repeat(3, minmax(190px, 1fr));
            }
        }

        @media (max-width: 700px) {
            .latest-products {
                display: flex;
                overflow-x: auto;
                padding-bottom: 10px;
                scroll-snap-type: x mandatory;
            }

            .latest-product-card {
                flex: 0 0 220px;
                scroll-snap-align: start;
            }
        }
    </style>
</head>
<body>
    <h1 class="display-6 fw-semibold mb-3">Chào mừng đến với trang chủ!</h1>
    <c:choose>
        <c:when test="${not empty sessionScope.account}">
            <p class="lead">Xin chào, <strong>${sessionScope.account.fullName}</strong>!</p>
            <p><a class="btn btn-primary" href="<c:url value='/profile'/>">Xem và cập nhật hồ sơ cá nhân</a></p>
        </c:when>
        <c:otherwise>
            <p><a class="btn btn-primary" href="<c:url value='/login'/>">Đăng nhập</a> để sử dụng đầy đủ tính năng.</p>
        </c:otherwise>
    </c:choose>
    <div class="d-flex justify-content-between align-items-center mt-5 mb-3">
        <h2>Sản phẩm mới nhất</h2>
        <a href="<c:url value='/product'/>">Xem tất cả</a>
    </div>
    <div class="latest-products">
        <c:forEach var="product" items="${products}">
            <div class="latest-product-card">
                <div class="latest-product-image">
                    <c:choose>
                        <c:when test="${not empty product.image}">
                            <img src="${product.image}" alt="${product.name}">
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">Chưa có hình ảnh</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="latest-product-content">
                    <div class="latest-product-name">${product.name}</div>
                    <div class="latest-product-price">${product.formattedPrice} đ</div>
                    <a class="btn btn-outline-primary latest-product-link" href="<c:url value='/product/detail'><c:param name='id' value='${product.id}'/></c:url>">Chi tiết</a>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>