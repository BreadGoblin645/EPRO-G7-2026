<%@page import="com.animeCandles.entities.Message" %>
<%@page import="com.animeCandles.entities.User" %>

<% 
User user1=(User) session.getAttribute("activeUser"); 
if (user1==null) { 
	Message message=new Message("No has iniciado sesion! Inicia sesion primero.", "error" , "alert-danger" ); 
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp"); 
	return; 
} 
%>

			<style>
				label {
					font-weight: bold;
				}
			</style>
			<div class="container px-3 py-3">
				<h3>Informacion Personal</h3>
				<form id="update-user" action="UpdateUserServlet" method="post">
					<input type="hidden" name="operation" value="updateUser">
					<div class="row">
						<div class="col-md-6 mt-2">
							<label class="form-label">Nombre completo</label> <input type="text" name="name"
								class="form-control" placeholder="Nombre y apellido" value="<%=user1.getUserName()%>">
						</div>
						<div class="col-md-6 mt-2">
							<label class="form-label">Correo</label> <input type="email" name="email"
								placeholder="Correo electronico" class="form-control" value="<%=user1.getUserEmail()%>">
						</div>
					</div>
					<div class="row">
						<div class="col-md-6 mt-2">
							<label class="form-label">Numero de telefono</label> <input type="number" name="mobile_no"
								placeholder="Numero de telefono" class="form-control" value="<%=user1.getUserPhone()%>">
						</div>
						<div class="col-md-6 mt-5">
							<label class="form-label pe-3">Genero</label>
							<% String gender=user1.getUserGender(); if (gender.trim().equals("Male")) { %>
								<input class="form-check-input" type="radio" name="gender" value="Male" checked> <span
									class="form-check-label pe-3 ps-1"> Masculino </span> <input class="form-check-input"
									type="radio" name="gender" value="Female">
								<span class="form-check-label ps-1"> Femenino </span>

								<% } else { %>
									<input class="form-check-input" type="radio" name="gender" value="Male"> <span
										class="form-check-label pe-3 ps-1">
										Masculino </span> <input class="form-check-input" type="radio" name="gender"
										value="Female" checked> <span class="form-check-label ps-1">
										Femenino </span>
									<% } %>

						</div>
					</div>
					<div class="mt-2">
						<label class="form-label">Direccion</label> <input type="text" name="address"
							placeholder="Ingresar direccion, zona y calle" class="form-control"
							value="<%=user1.getUserAddress()%>">
					</div>
					<div class="row">
						<div class="col-md-6 mt-2">
							<label class="form-label">Ciudad</label> <input class="form-control" type="text" name="city"
								placeholder="Ciudad, distrito o municipio" value="<%=user1.getUserCity()%>">
						</div>
						<div class="col-md-6 mt-2">
							<label class="form-label">Codigo postal</label> <input class="form-control" type="number"
								name="zipcode" placeholder="Codigo postal" maxlength="6" value="<%=user1.getUserZipcode()%>">
						</div>
					</div>
					<div class="row mt-2">
						<label class="form-label">Departamento</label>
						<div class="input-group mb-3">
							<input class="form-control" type="text" value="<%=user1.getUserState()%>">
							<select name="state" id="state-list" class="form-select">
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
					</div>
					<div id="submit-btn" class="container text-center mt-3">
						<button type="submit" class="btn btn-outline-primary me-3">Actualizar</button>
						<button type="reset" class="btn btn-outline-primary">Limpiar</button>
					</div>
				</form>
			</div>
