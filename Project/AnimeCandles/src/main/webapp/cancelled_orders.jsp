<%@page import="com.animeCandles.entities.Admin"%>
<%@page import="com.animeCandles.entities.Message"%>
<%@page import="com.animeCandles.entities.OrderedProduct"%>
<%@page import="com.animeCandles.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.animeCandles.dao.OrderedProductDao"%>
<%@page import="com.animeCandles.dao.OrderDao"%>
<%@page import="com.animeCandles.helper.ConnectionProvider"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("No has iniciado sesion! Inicia sesion primero.", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
OrderedProductDao ordProdDao = new OrderedProductDao(ConnectionProvider.getConnection());
List<Order> orderList = orderDao.getCancelledOrders();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ordenes Canceladas</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="Components/navbar.jsp"%>

	<div class="container-fluid px-3 py-3">
		<div class="mb-3">
			<a href="display_orders.jsp" class="btn btn-outline-primary btn-sm">Ordenes normales</a>
			<a href="sus_activity.jsp" class="btn btn-outline-warning btn-sm">Ordenes sospechosas</a>
			<a href="cancelled_orders.jsp" class="btn btn-danger btn-sm">Ordenes canceladas</a>
		</div>
		<%
		if (orderList == null || orderList.size() == 0) {
		%>
		<div class="container mt-5 mb-5 text-center">
			<img src="Images/no-results.png" style="max-width: 200px;"
				class="img-fluid">
			<h4 class="mt-3">No se encontraron ordenes canceladas</h4>
		</div>
		<%
		} else {
		%>
		<div class="container-fluid">
			<table class="table table-hover">
				<tr class="table-danger" style="font-size: 18px;">
					<th class="text-center">Producto</th>
					<th>ID Pedido</th>
					<th>Detalles</th>
					<th>Razon sospechosa</th>
					<th>Revisado Por</th>
					<th>Fecha creacion</th>
					<th>Fecha revision</th>
					<th>Estado</th>
				</tr>
				<%
				for (Order order : orderList) {
					List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
					for (OrderedProduct orderProduct : ordProdList) {
				%>
				<tr>
					<td class="text-center"><img
						src="Product_imgs\<%=orderProduct.getImage()%>"
						style="width: 50px; height: 50px; width: auto;"></td>
					<td><%=order.getOrderId()%></td>
					<td><%=orderProduct.getName()%><br>Cantidad: <%=orderProduct.getQuantity()%><br>Precio
						Total: $<%=orderProduct.getPrice() * orderProduct.getQuantity()%></td>
					<td><%=order.getSuspiciousReason() != null ? order.getSuspiciousReason() : "Sin razon registrada"%></td>
					<td><%=order.getReviewedBy() != null ? order.getReviewedBy() : "No registrado"%></td>
					<td><%=order.getDate()%></td>
					<td><%=order.getReviewDate() != null ? order.getReviewDate() : "No registrada"%></td>
					<td><%=order.getStatus()%></td>
				</tr>
				<%
					}
				}
				%>
			</table>
		</div>
		<%
		}
		%>
	</div>

	<%@ include file="Components/footer.jsp" %>
</body>
</html>
