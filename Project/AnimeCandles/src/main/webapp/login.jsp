<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Iniciar sesion</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
label{
	font-weight: bold;
}
</style>
</head>
<body >  

	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container-fluid">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body px-5">

						<div class="container text-center">
							<img src="Images/login.png" style="max-width: 100px;"
								class="img-fluid">
						</div>
						<h3 class="text-center">Iniciar sesion</h3>
						<%@include file="Components/alert_message.jsp" %>
						
						<!--login-form-->
						<form id="login-form" action="LoginServlet" method="post">
							<input type="hidden" name="login" value="user"> 
							<div class="mb-3">
								<label class="form-label">Correo</label> <input
									type="email" name="user_email" placeholder="Correo electronico"
									class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Contrasena</label>
								<input type="password" name="user_password"
									placeholder="Ingresa tu contrasena" class="form-control" required>
							</div>
							<div id="login-btn" class="container text-center">
								<button type="submit" class="btn btn-outline-primary me-3">Iniciar sesion</button>
							</div>
						</form>
						<div class="mt-3 text-center">
							<h6><a href="forgot_password.jsp" style="text-decoration: none">Olvidaste tu contrasena?</a></h6>
							<h6>
								No tienes una cuenta?<a href="register.jsp"
									style="text-decoration: none"> Registrate</a>
							</h6>
						</div>
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
