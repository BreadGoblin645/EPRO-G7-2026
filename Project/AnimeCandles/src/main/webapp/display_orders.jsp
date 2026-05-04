<%@page import="com.animeCandles.entities.Message"%>
<%@page import="com.animeCandles.dao.UserDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.animeCandles.entities.OrderedProduct"%>
<%@page import="com.animeCandles.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.animeCandles.dao.OrderedProductDao"%>
<%@page import="com.animeCandles.dao.OrderDao"%>
<%@page import="com.animeCandles.helper.ConnectionProvider"%>

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
List<Order> orderList = orderDao.getAllOrder();
UserDao userDao = new UserDao(ConnectionProvider.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ver Pedidos</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!-- order details -->

	<div class="container-fluid px-3 py-3">
		<%
		if (orderList == null || orderList.size() == 0) {
		%>
		<div class="container mt-5 mb-5 text-center">
			<img src="Images/empty-cart.png" style="max-width: 200px;"
				class="img-fluid">
			<h4 class="mt-3">No se encontraron pedidos</h4>
		</div>
		<%
		} else {
		%>
		<div class="container-fluid">
			<table class="table table-hover">
				<tr class="table-primary" style="font-size: 18px;">
					<th class="text-center">Producto</th>
					<th>ID de Pedido</th>
					<th>Detalles del Producto</th>
					<th>Direccion de Entrega</th>
					<th>Fecha y Hora</th>
					<th>Tipo de Pago</th>
					<th>Estado</th>
					<th colspan="2" class="text-center">Accion</th>
				</tr>
				<%
				for (Order order : orderList) {
					List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
					for (OrderedProduct orderProduct : ordProdList) {
				%>
				<form action="UpdateOrderServlet?oid=<%=order.getId()%>"
					method="post">
				<tr>
					<td class="text-center"><img
						src="Product_imgs\<%=orderProduct.getImage()%>"
						style="width: 50px; height: 50px; width: auto;"></td>
					<td><%=order.getOrderId()%></td>
					<td><%=orderProduct.getName()%><br>Cantidad: <%=orderProduct.getQuantity()%><br>Precio
						Total: $<%=orderProduct.getPrice() * orderProduct.getQuantity()%></td>
					<td><%=userDao.getUserName(order.getUserId())%><br>Telefono: <%=userDao.getUserPhone(order.getUserId())%><br><%=userDao.getUserAddress(order.getUserId())%></td>
					<td><%=order.getDate()%></td>
					<td><%
					String paymentType = order.getPayementType();
					if ("Cash on Delivery".equals(paymentType)) {
						out.print("Efectivo al momento de entrega");
					} else if ("Cash on Pick Up".equals(paymentType)) {
						out.print("Efectivo al recoger");
					} else if ("Card Payment".equals(paymentType)) {
						out.print("Pago con tarjeta");
					} else {
						out.print(paymentType);
					}
					%></td>
					<td><%
					String status = order.getStatus();
					if ("Order Confirmed".equals(status)) {
						out.print("Pedido Confirmado");
					} else if ("Shipped".equals(status)) {
						out.print("Enviado");
					} else if ("Out For Delivery".equals(status)) {
						out.print("En Reparto");
					} else if ("Delivered".equals(status)) {
						out.print("Entregado");
					} else {
						out.print(status);
					}
					%></td>
					<td><select id="operation" name="status" class="form-select">
							<option disabled selected>--Seleccionar Operacion--</option>
							<option value="Order Confirmed">Pedido Confirmado</option>
							<option value="Shipped">Enviado</option>
							<option value="Out For Delivery">En Reparto</option>
							<option value="Delivered">Entregado</option>
					</select></td>
					<td>
						<%
						if (order.getStatus().equals("Delivered")) {
						%>
						<button type="submit" class="btn btn-success disabled">Actualizar</button>
						<%
						} else {
						%>
					<button type="submit" class="btn btn-secondary">Actualizar</button> 
						<%
						 }
						 %>
					</td>
				</tr>
				</form>
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
	
	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->
</body>
</html>
