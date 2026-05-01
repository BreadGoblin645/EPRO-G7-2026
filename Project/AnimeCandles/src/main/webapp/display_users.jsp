<%@page import="com.animeCandles.entities.Message"%>
<%@page import="com.animeCandles.dao.UserDao"%>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ver Usuarios</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container-fluid px-5 py-3">
		<table class="table table-hover">
			<tr class="text-center table-primary" style="font-size: 18px;">
				<th>Nombre de Usuario</th>
				<th>Correo</th>
				<th>Telefono</th>
				<th>Genero</th>
				<th>Direccion</th>
				<th>Fecha de Registro</th>
				<th>Accion</th>
			</tr>
			<%
			UserDao userDao = new UserDao(ConnectionProvider.getConnection());
			List<User> userList = userDao.getAllUser();
			for (User u : userList) {
			%>
			<tr>
				<td><%=u.getUserName()%></td>
				<td><%=u.getUserEmail()%></td>
				<td><%=u.getUserPhone()%></td>
				<td><%
				String gender = u.getUserGender();
				if ("Male".equals(gender)) {
					out.print("Masculino");
				} else if ("Female".equals(gender)) {
					out.print("Femenino");
				} else {
					out.print(gender);
				}
				%></td>
				<td><%=userDao.getUserAddress(u.getUserId())%></td>
				<td><%=u.getDateTime()%></td>
				<td><a href="UpdateUserServlet?operation=deleteUser&uid=<%=u.getUserId()%>" role="button" class="btn btn-danger">Remover</a></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->

</body>
</html>
