<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Olvide mi contrasena</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
label {
	font-weight: bold;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container-fluid ">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body px-5">

						<div class="container text-center">
							<img src="Images/forgot-password.png" style="max-width: 100px;"
								class="img-fluid">
						</div>
						<h3 class="text-center mt-3">Cambiar Contrasena</h3>
						<%@include file="Components/alert_message.jsp"%>

						<!--change password-->
						<form action="ChangePasswordServlet" method="post">
							<div class="mb-3">
							<label class="form-label">Correo</label> <input type="email"
								name="email" placeholder="Ingresar correo electronico" class="form-control"
								required>
							</div>
							<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary me-3">Enviar</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->
</body>
</html>
