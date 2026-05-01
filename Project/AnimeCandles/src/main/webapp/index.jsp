<%@page import="com.animeCandles.dao.ProductDao"%>
<%@page import="com.animeCandles.dao.WishlistDao"%>
<%@page import="com.animeCandles.entities.Product"%>
<%@page import="com.animeCandles.helper.ConnectionProvider"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
List<Product> productList = productDao.getAllLatestProducts();
List<Product> topDeals = productDao.getDiscountedProducts();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.cus-card {
	border-radius: 50%;
	border-color: transparent;
	max-height: 200px;
	max-width: 200px;
	max-height: 200px;
}

.real-price {
	font-size: 20px !important;
	font-weight: 600;
}

.product-price {
	font-size: 17px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 15px !important;
	color: #027a3e;
}

.wishlist-icon {
	cursor: pointer;
	position: absolute;
	right: 10px;
	top: 10px;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	border: 1px solid #f0f0f0;
	box-shadow: 0 1px 4px 0 rgba(0, 0, 0, .1);
	padding-right: 40px;
	background: #fff;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>
	<%
	WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());
	%>

	<!-- Category list -->
	<div class="container-fluid px-3 py-3"
		style="background-color: #e3f7fc;">
		<div class="row">
			<div class="card-group">
				<%
				for (Category c : categoryList) {
				%>
				<div class="col text-center">
					<a href="products.jsp?category=<%=c.getCategoryId()%>"
						style="text-decoration: none;">
						<div class="card cus-card h-100">
							<div class="container text-center">
								<img src="Product_imgs\<%=c.getCategoryImage()%>" class="mt-3 "
									style="max-width: 100%; max-height: 100px; width: auto; height: auto;">
							</div>
							<!-- <h6><%=c.getCategoryName()%></h6>> -->
						</div>
					</a>
				</div>

				<%
				}
				%>
			</div>
		</div>
	</div>
	<!-- end of list -->

	<!-- Carousel -->
	<div id="carouselAutoplaying"
		class="carousel slide carousel-dark mt-3 mb-3" data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="Images/scroll_img2.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="Images/scroll_img1.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="Images/scroll_img3.png" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselAutoplaying" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"
				style="color: black;"></span> <span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselAutoplaying" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<!-- end of carousel -->

	<!-- latest product listed -->
	<div class="container-fluid py-3 px-3" style="background: #f2f2f2;">
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<div class="col">
				<div class="container text-center px-5 py-5">
					<img src="Images\product.png" class="card-img-top"
						style="max-width: 100%; max-height: 400px; width: auto;">
				</div>
			</div>
			<%
			for (int i = 0; i < Math.min(7, productList.size()); i++) {
				Product latestProduct = productList.get(i);
			%>
			<div class="col">
				<div class="card h-100 position-relative">
					<div class="wishlist-icon">
						<%
						if (user != null) {
							if (wishlistDao.getWishlist(user.getUserId(), latestProduct.getProductId())) {
						%>
						<button
							onclick="event.stopPropagation(); window.open('WishlistServlet?uid=<%=user.getUserId()%>&pid=<%=latestProduct.getProductId()%>&op=remove', '_self')"
							class="btn btn-link" type="button">
							<i class="fa-sharp fa-solid fa-heart" style="color: #ff0303;"></i>
						</button>
						<%
							} else {
						%>
						<button
							onclick="event.stopPropagation(); window.open('WishlistServlet?uid=<%=user.getUserId()%>&pid=<%=latestProduct.getProductId()%>&op=add', '_self')"
							class="btn btn-link" type="button">
							<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
						</button>
						<%
							}
						} else {
						%>
						<button onclick="event.stopPropagation(); window.open('login.jsp', '_self')"
							class="btn btn-link" type="button">
							<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
						</button>
						<%
						}
						%>
					</div>
					<a href="viewProduct.jsp?pid=<%=latestProduct.getProductId()%>"
						style="text-decoration: none;">
						<div class="container text-center">
							<img
								src="Product_imgs\<%=latestProduct.getProductImages()%>"
								class="card-img-top m-2"
								style="max-width: 100%; max-height: 200px; width: auto;">
						</div>
						<div class="card-body">
							<h5 class="card-title text-center"><%=latestProduct.getProductName()%></h5>

							<div class="container text-center">
								<% if (latestProduct.getProductDiscount() > 0) { %>
									<span class="real-price">$<%=latestProduct.getProductPriceAfterDiscount()%></span>&ensp;
									<span class="product-price"><del>$<%=latestProduct.getProductPrice()%></del></span>&ensp;
									<span class="product-discount"><%=latestProduct.getProductDiscount()%>&#37; off</span>
								<% } else { %>
									<span class="real-price">$<%=latestProduct.getProductPrice()%></span>
								<% } %>
							</div>
						</div>
					</a>
				</div>
			</div>

			<%
			}
			%>
		</div>
	</div>
	<!-- end of list -->

	<!-- product with heavy deals -->
	<div class="container-fluid py-3 px-3" style="background: #f0fffe;">
		<h3 class="text-center">Productos en DESCUENTO!</h3>
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<%
			for (int i = 0; i < Math.min(4, topDeals.size()); i++) {
				Product dealProduct = topDeals.get(i);
			%>
			<div class="col">
				<div class="card h-100 position-relative">
					<div class="wishlist-icon">
						<%
						if (user != null) {
							if (wishlistDao.getWishlist(user.getUserId(), dealProduct.getProductId())) {
						%>
						<button
							onclick="event.stopPropagation(); window.open('WishlistServlet?uid=<%=user.getUserId()%>&pid=<%=dealProduct.getProductId()%>&op=remove', '_self')"
							class="btn btn-link" type="button">
							<i class="fa-sharp fa-solid fa-heart" style="color: #ff0303;"></i>
						</button>
						<%
							} else {
						%>
						<button
							onclick="event.stopPropagation(); window.open('WishlistServlet?uid=<%=user.getUserId()%>&pid=<%=dealProduct.getProductId()%>&op=add', '_self')"
							class="btn btn-link" type="button">
							<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
						</button>
						<%
							}
						} else {
						%>
						<button onclick="event.stopPropagation(); window.open('login.jsp', '_self')"
							class="btn btn-link" type="button">
							<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
						</button>
						<%
						}
						%>
					</div>
					<a href="viewProduct.jsp?pid=<%=dealProduct.getProductId()%>"
						style="text-decoration: none;">
						<div class="container text-center">
							<img src="Product_imgs\<%=dealProduct.getProductImages()%>"
								class="card-img-top m-2"
								style="max-width: 100%; max-height: 200px; width: auto;">
						</div>
						<div class="card-body">
							<h5 class="card-title text-center"><%=dealProduct.getProductName()%></h5>

							<div class="container text-center">
								<% if (dealProduct.getProductDiscount() > 0) { %>
									<span class="real-price">$<%=dealProduct.getProductPriceAfterDiscount()%></span>&ensp;
									<span class="product-price"><del>$<%=dealProduct.getProductPrice()%></del></span>&ensp;
									<span class="product-discount"><%=dealProduct.getProductDiscount()%>&#37; off</span>
								<% } else { %>
									<span class="real-price">$<%=dealProduct.getProductPrice()%></span>
								<% } %>
							</div>
						</div>
					</a>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<!-- end -->

	<!-- confirmation message for successful order -->
	<%
	String order = (String) session.getAttribute("order");
	if (order != null) {
	%>
	<script type="text/javascript">
		Swal.fire({
		  icon : 'success',
		  title: 'Pedido realizado, Gracias!',
		  text: 'La confirmacion sera enviada a <%=user.getUserEmail()%>',
		  width: 600,
		  padding: '3em',
		  showConfirmButton : false,
		  timer : 3500,
		  backdrop: `
		    rgba(0,0,123,0.4)
		  `
		});
	</script>
	<%
	}
	session.removeAttribute("order");
	%>
	<!-- end of message -->
	
	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!--End Footer-->

</body>
</html>
