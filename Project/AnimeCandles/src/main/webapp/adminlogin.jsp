<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Inicio de Sesion Administrador</title>
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

	<div class="container-fluid">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-header px-5">
						<div class="container text-center">
							<img src="Images/admin.png" style="max-width: 100px;"
								class="img-fluid">
						</div>
						<h3 class="text-center">Iniciar Sesion</h3>
						<%@include file="Components/alert_message.jsp"%>
					</div>
					<div class="card-body px-5">
						<!--login-form-->
						<form id="login-form" action="LoginServlet" method="post">
							<input type="hidden" name="login" value="admin"> 
							
							<div class="mb-3">
								<label class="form-label">Correo</label> <input type="email"
									name="email" placeholder="Correo electronico" class="form-control"
									required>
							</div>
							<div class="mb-2">
								<label class="form-label">Contrasena</label> <input
									type="password" name="password"
									placeholder="Ingresa tu contrasena" class="form-control" required>
							</div>

							<div id="login-btn" class="container text-center mt-5">
								<button type="submit" class="btn btn-outline-primary me-3">Iniciar sesion</button>
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
