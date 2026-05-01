<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registro</title>
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

	<div class="container-fluid mt-4">
		<div class="row g-0">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body px-5">

						<div class="container text-center">
							<img src="Images/signUp.png" style="max-width: 80px;"
								class="img-fluid">
						</div>
						<h3 class="text-center">Crear Cuenta</h3>
						<%@include file="Components/alert_message.jsp"%>

						<!--registration-form-->
						<form id="register-form" action="RegisterServlet" method="post">
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Nombre completo</label> <input type="text"
										name="user_name" class="form-control"
										placeholder="Nombre y apellido" required>
								</div>
								<div class="col-md-6 mt-2">
									<label class="form-label">Correo</label> <input type="email"
										name="user_email" placeholder="Correo electronico"
										class="form-control" required>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Numero de telefono</label> <input
										type="number" name="user_mobile_no"
										placeholder="Numero de telefono" class="form-control">
								</div>
								<div class="col-md-6 mt-5">
									<label class="form-label pe-3">Genero</label> <input
										class="form-check-input" type="radio" name="gender"
										value="Male"> <span class="form-check-label pe-3 ps-1">
										Masculino </span> <input class="form-check-input" type="radio"
										name="gender" value="Female"> <span
										class="form-check-label ps-1"> Femenino </span>
								</div>
							</div>
							<div class="mt-2">
								<label class="form-label">Direccion</label> <input type="text"
									name="user_address"
									placeholder="Ingresar direccion, zona y calle"
									class="form-control" required>
							</div>  
							<div class="row">
								<div class="col-md-6 mt-2">
										<label class="form-label">Ciudad</label> <input
											class="form-control" type="text" name="city"
											placeholder="Ciudad, distrito o municipio" required>
								</div>
								<div class="col-md-6 mt-2">
										<label class="form-label">Codigo postal</label> <input
											class="form-control" type="number" name="zipcode"
											placeholder="Codigo postal" maxlength="6" required>
								</div>  
							</div>
							<div class="row">
								<div class="col-md-6 mt-2">
										<label class="form-label">Departamento</label> <select name="state"
											class="form-select">
											<option selected>--Seleccionar departamento--</option>
										<option value="Ahuachapan">Ahuachapan</option>
										<option value="Cabanas">Cabanas</option>
										<option value="Chalatenango">Chalatenango</option>
										<option value="Cuscatlan">Cuscatlan</option>
										<option value="La Libertad">La Libertad</option>
										<option value="La Paz">La Paz</option>
										<option value="La Union">La Union</option>
										<option value="Morazan">Morazan</option>
										<option value="San Miguel">San Miguel</option>
										<option value="San Salvador">San Salvador</option>
										<option value="San Vicente">San Vicente</option>
										<option value="Santa Ana">Santa Ana</option>
										<option value="Sonsonate">Sonsonate</option>
										<option value="Usulutan">Usulutan</option>	
									</select>
								</div>
								<div class="col-md-6 mt-2">
									<label class="form-label">Contrasena</label> <input
										type="password" name="user_password"
										placeholder="Ingresar contrasena" class="form-control" required>
								</div>
							</div>

							<div id="submit-btn" class="container text-center mt-4">
								<button type="submit" class="btn btn-outline-primary me-3">Enviar</button>
								<button type="reset" class="btn btn-outline-primary">Limpiar</button>
							</div>
							<div class="mt-3 text-center">
								<h6>
									Ya tienes una cuenta?<a href="login.jsp"
										style="text-decoration: none"> Iniciar sesion</a>
								</h6>
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
