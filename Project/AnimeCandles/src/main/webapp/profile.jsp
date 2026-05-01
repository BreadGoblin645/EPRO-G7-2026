<%@page import="com.animeCandles.entities.Message"%>
<%@page import="com.animeCandles.entities.User"%>
<%@page errorPage="error_exception.jsp"%>
<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
	Message message = new Message("No has iniciado sesion! Inicia sesion primero.", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;
}
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Mi Perfil</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
.cus-active {
	background-color: #e6eefa !important;
	width: 100%;
}

.list-btn {
	font-size: 20px !important;
}

.list-btn:hover {
	color: #2874f0 !important;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container-fluid px-3 py-5">
		<div class="row">
			<div class="col-md-3">
				<div class="card">
					<div class="row mt-2 mb-2">
						<div class="col-md-4">
							<div class="container text-center">
								<img src="Images/profile.png" style="max-width: 60px;"
									class="img-fluid">
							</div>
						</div>
						<div class="col-md-8">
							Hola, <br>
							<h5><%=activeUser.getUserName()%></h5>
						</div>
					</div>  
				</div>

				<div class="card mt-3">
					<div class="list-group">
						<button type="button" id="profile-btn"
							class="list-group-item list-group-item-action cus-active list-btn"
								aria-current="true">Informacion del perfil</button>
						<button type="button" id="wishlist-btn"
							class="list-group-item list-group-item-action list-btn">Mi lista de deseos</button>
						<button type="button" id="order-btn"
							class="list-group-item list-group-item-action list-btn">Mis pedidos</button>
						<button type="button" id="change-password-btn"
							class="list-group-item list-group-item-action list-btn">Cambiar contrasena</button>
						<button type="button" id="logout-btn"
							class="list-group-item list-group-item-action list-btn"
							onclick="window.open('LogoutServlet?user=user', '_self')">Cerrar sesion</button>
					</div>
				</div>
			</div>
			<div class="col-md-9">
				<div class="card">
					<div id="profile">
						<%@include file="Components/alert_message.jsp"%>
						<%@include file="personalInfo.jsp"%>
					</div>
					<div id="wishlist" style="display: none;">
						<%@include file="wishlist.jsp"%>  
					</div>
					<div id="order" style="display: none;">
						<%@include file="order.jsp"%>    
					</div>
					<div id="change-password" style="display: none;">
						<%@include file="change_password_form.jsp"%>
					</div>
				</div>
			</div>  
		</div>
	</div>

	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!--End Footer-->

	<script>
		$(document).ready(function() {
			$('#profile-btn').click(function() {
				$('#profile').show();
				$('#wishlist').hide();
				$('#order').hide();
				$('#change-password').hide();

				$(this).addClass('cus-active');
				$('#wishlist-btn').removeClass('cus-active');
				$('#order-btn').removeClass('cus-active');
				$('#change-password-btn').removeClass('cus-active');
			});

			$('#wishlist-btn').click(function() {
				$('#wishlist').show();
				$('#profile').hide();
				$('#order').hide();
				$('#change-password').hide();

				$(this).addClass('cus-active');
				$('#profile-btn').removeClass('cus-active');
				$('#order-btn').removeClass('cus-active');
				$('#change-password-btn').removeClass('cus-active');
			});

			$('#order-btn').click(function() {
				$('#order').show();
				$('#profile').hide();
				$('#wishlist').hide();
				$('#change-password').hide();

				$(this).addClass('cus-active');
				$('#profile-btn').removeClass('cus-active');
				$('#wishlist-btn').removeClass('cus-active');
				$('#change-password-btn').removeClass('cus-active');
			});

			$('#change-password-btn').click(function() {
				$('#change-password').show();
				$('#profile').hide();
				$('#wishlist').hide();
				$('#order').hide();

				$(this).addClass('cus-active');
				$('#profile-btn').removeClass('cus-active');
				$('#wishlist-btn').removeClass('cus-active');
				$('#order-btn').removeClass('cus-active');
			});
		});
	</script>
</body>
</html>
