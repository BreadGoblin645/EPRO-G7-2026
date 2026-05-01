<%@page import="com.animeCandles.dao.WishlistDao"%>
<%@page import="com.animeCandles.dao.ProductDao"%>
<%@page import="com.animeCandles.entities.Product"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%
int productId = Integer.parseInt(request.getParameter("pid"));
ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
Product product = (Product) productDao.getProductsByProductId(productId);

List<Product> prodList = null;
List<Product> topDeals = productDao.getDiscountedProducts();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ver Producto</title>
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
	font-size: 26px !important;
	font-weight: 600;
}

.product-price {
	font-size: 18px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 16px !important;
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
							<!-- <h6><%=c.getCategoryName()%></h6> -->
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


	<div class="container mt-5">
			<%@include file="Components/alert_message.jsp"%>
		<div class="row border border-3">
			<div class="col-md-6">
				<div class="container-fluid text-end my-3">
					<img src="Product_imgs\<%=product.getProductImages()%>"
						class="card-img-top"
						style="max-width: 100%; max-height: 500px; width: auto;">
				</div>
			</div>


			<div class="col-md-6">
				<div class="container-fluid my-5">
					<h4><%=product.getProductName()%></h4>
					<span class="fs-5"><b>Descripcion</b></span><br> <span><%=product.getProductDescription()%></span><br>

					<% if (product.getProductDiscount() > 0) { %>
						<span class="real-price">$<%=product.getProductPriceAfterDiscount()%></span>&ensp;
						<span class="product-price"><del>$<%=product.getProductPrice()%></del></span>&ensp;
							<span class="product-discount"><%=product.getProductDiscount()%>&#37; descuento</span><br>
					<% } else { %>
						<span class="real-price">$<%=product.getProductPrice()%></span><br>
					<% } %>
					
					<span class="fs-5"><b>Estado : </b></span>
					<span id="availability">
						<%
						if (product.getProductQunatity() > 0) {
							out.println("Disponible");
						} else {
							out.println("Sin Inventario");
						}
						%>
					</span><br>
					<span class="fs-5"><b>Categoria : </b></span> <span><%=catDao.getCategoryName(product.getCategoryId())%></span>
					<form method="post">
						<div class="container-fluid text-center mt-3">
							<%
							if (user == null) {
							%>
							<button type="button" onclick="window.open('login.jsp', '_self')"
								class="btn btn-primary text-white btn-lg">Agregar Carrito</button>
							&emsp;
							<button type="button" onclick="window.open('login.jsp', '_self')"
								class="btn btn-info text-white btn-lg">Comprar Ahora</button>
							<%
							} else {
							%>
							<button type="submit"
								formaction="./AddToCartServlet?uid=<%=user.getUserId()%>&pid=<%=product.getProductId()%>"
								class="btn btn-primary text-white btn-lg">Agregar Carrito</button>
							&emsp; <a
								href="checkout.jsp" id="buy-btn"
								class="btn btn-info text-white btn-lg" role="button"
								aria-disabled="true">Comprar Ahora</a> 
							<%
							}
							%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- product with heavy deals -->
	<div class="container-fluid py-3 px-3" style="background: #f0fffe;">
		<h3 class="text-center">Productos en DESCUENTO!</h3>
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<%
			for (int i = 0; i < Math.min(4, topDeals.size()); i++) {
			%>
			<div class="col">
				<a href="viewProduct.jsp?pid=<%=topDeals.get(i).getProductId()%>"
					style="text-decoration: none;">
					<div class="card h-100">
						<div class="container text-center">
							<img src="Product_imgs\<%=topDeals.get(i).getProductImages()%>"
								class="card-img-top m-2"
								style="max-width: 100%; max-height: 200px; width: auto;">
						</div>
						<div class="card-body">
							<h5 class="card-title text-center"><%=topDeals.get(i).getProductName()%></h5>

							<div class="container text-center">
								<% if (topDeals.get(i).getProductDiscount() > 0) { %>
									<span class="real-price">$<%=topDeals.get(i).getProductPriceAfterDiscount()%></span>&ensp;
									<span class="product-price"><del>$<%=topDeals.get(i).getProductPrice()%></del></span>&ensp;
								<span class="product-discount"><%=topDeals.get(i).getProductDiscount()%>&#37; descuento</span>
								<% } else { %>
									<span class="real-price">$<%=topDeals.get(i).getProductPrice()%></span>
								<% } %>
							</div>
						</div>
					</div>
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<!-- end -->

	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->

	<script>
		$(document).ready(function() {
			if ($('#availability').text().trim() == "Sin Inventario") {
				$('#availability').css('color', 'red');
				$('.btn').addClass('disabled');
			}
			$('#buy-btn').click(function(){
				<%
				session.setAttribute("pid", productId);
				session.setAttribute("from", "buy");
				%>
				});
		});
	</script>
</body>
</html>
