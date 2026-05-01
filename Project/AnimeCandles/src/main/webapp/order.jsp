<%@page import="com.animeCandles.entities.Message"%>
<%@page import="com.animeCandles.entities.OrderedProduct"%>
<%@page import="com.animeCandles.entities.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.animeCandles.dao.OrderedProductDao"%>
<%@page import="com.animeCandles.dao.OrderDao"%>
<%@page import="com.animeCandles.helper.ConnectionProvider"%>
<%@page import="com.animeCandles.entities.User"%>
<%@page errorPage="error_exception.jsp"%>

<%
User u2 = (User) session.getAttribute("activeUser");
if (u2 == null) {
	Message message = new Message("No has iniciado sesion! Inicia sesion primero.", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
OrderedProductDao ordProdDao = new OrderedProductDao(ConnectionProvider.getConnection());

List<Order> orderList = orderDao.getAllOrderByUserId(u2.getUserId());
%>
<div class="container-fluid px-3 py-3">
	<%
	if (orderList == null || orderList.size() == 0) {
	%>
	<div class="container mt-5 mb-5 text-center">
		<img src="Images/empty-cart.png" style="max-width: 200px;"
			class="img-fluid">
		<h4 class="mt-3">No se encontraron pedidos</h4>
		Parece que aun no has realizado ningun pedido!
	</div>
	<%
	} else {
	%>
	<h4>Mis Pedidos</h4>
	<hr>
	<div class="container">
		<table class="table table-hover">
			<tr class="text-center table-secondary">
			  <th>Producto</th>
			  <th>ID de Pedido</th>
			  <th>Nombre</th>
			  <th>Cantidad</th>
			  <th>Precio Total</th>
			  <th>Fecha y Hora</th>
			  <th>Tipo de Pago</th>
			  <th>Estado</th>
			</tr>
			<%
			for (Order order : orderList) {
				List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
				for (OrderedProduct orderProduct : ordProdList) {
			%>
			<tr class="text-center">
				<td><img src="Product_imgs\<%=orderProduct.getImage()%>"
					style="width: 40px; height: 40px; width: auto;"></td>
				<td class="text-start"><%=order.getOrderId()%></td>
				<td class="text-start"><%=orderProduct.getName()%></td>
				<td><%=orderProduct.getQuantity()%></td>
				<td><%=orderProduct.getPrice() * orderProduct.getQuantity()%></td>
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
				<td class="fw-semibold" style="color: green;"><%
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
