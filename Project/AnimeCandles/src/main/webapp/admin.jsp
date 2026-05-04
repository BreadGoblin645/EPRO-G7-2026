<%@page import="com.animeCandles.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_exception.jsp"%>
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
<title>Panel de Administrador</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.cus-active {
	background-color: #e6eefa !important;
	width: 100%;
}

.list-btn {
	font-size: 18px !important;
}

.list-btn:hover {
	color: #2874f0 !important;
}

.no-border {
	border: 0;
	box-shadow: none;
}

a {
	text-decoration: none;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!--admin dashboard -->
	<div class="container-fluid py-4 px-3">
		<%@include file="Components/alert_message.jsp"%>
		<div class="row">
			<div class="container text-center" id="details">
				<img src="Images/admin.png" style="max-width: 180px;"
					class="img-fluid">
				<h3>
					Bienvenido "<%=activeAdmin.getName()%>"
				</h3>
			</div>
		</div>
		<!-- PRIMER CONTENEDOR CON 3 OPCIONES-->
		<div class="container">
			<div class="row px-3 py-3">
				<div class="col-md-4">
					<a href="display_category.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/categories.png" style="max-width: 80px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Categorias</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="display_products.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/products.png" style="max-width: 80px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Productos</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="display_orders.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/order.png" style="max-width: 80px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Pedidos</h4>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>

		<!-- SEGUNDO CONTENEDOR CON 3 OPCIONES-->
		<div class="container">
			<div class="row px-3 py-3">
				<div class="col-md-4">
					<a href="edit_fees.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/fees.png" style="max-width: 80px;" class="img-fluid">
									<h4 class="card-title mt-3">Editar Tarifas</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="display_users.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/users.png" style="max-width: 80px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Usuarios</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="display_admin.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/add-admin.png" style="max-width: 80px;"
									class="img-fluid">
								<h4 class="card-title mt-3">Administradores</h4>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!--end-->

	
		<!-- TERCER CONTENEDOR CON 2 OPCION-->
		<div class="container">
			<div class="row px-3 py-3">
				<div class="col-md-4">
					<a href="sus_activity.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/danger.png" style="max-width: 80px;" class="img-fluid">
									<h4 class="card-title mt-3">Ordenes Sospechosas</h4>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="cancelled_orders.jsp">
						<div class="card text-bg-light mb-3 text-center">
							<div class="card-body">
								<img src="Images/cancelled_orders.png" style="max-width: 80px;" class="img-fluid">
									<h4 class="card-title mt-3">Ordenes Canceladas</h4>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<!--end-->

	<!-- add category modal-->
	<div class="modal fade" id="add-category" tabindex="-1"
		aria-labelledby="addCategoryModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
						<h1 class="modal-title fs-5" id="addCategoryModalLabel">Agregar
							Categoria</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Cerrar"></button>
				</div>
				<form action="AddOperationServlet" method="post"
					enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="operation" value="addCategory">

						<div class="mb-3">
							<label class="form-label"><b>Nombre de Categoria</b></label> <input
								type="text" name="category_name"
								placeholder="Ingresar categoria" class="form-control" required>
						</div>
						<div class="mb-3">
							<label for="formFile" class="form-label"><b>Imagen de
									Categoria</b></label> <input class="form-control" type="file"
								name="category_img" id="formFile">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cerrar</button>
						<button type="submit" class="btn btn-primary me-3">Agregar
							Categoria</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end of modal -->

	<!-- add product modal-->
	<div class="modal fade" id="add-product" tabindex="-1"
		aria-labelledby="addProductModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
						<h1 class="modal-title fs-5" id="addProductModalLabel">Agregar
							Producto</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Cerrar"></button>
				</div>
				<form action="AddOperationServlet" method="post"
					name="addProductForm" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="operation" value="addProduct">
						<div>
							<label class="form-label"><b>Nombre del Producto</b></label> <input
								type="text" name="name" placeholder="Ingresar nombre del producto"
								class="form-control" required>
						</div>
						<div class="mb-2">
							<label class="form-label"><b>Descripcion del Producto</b></label>
							<textarea class="form-control" name="description" rows="4"
								placeholder="Ingresar descripcion del producto"></textarea>
						</div>
						<div class="row">
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Precio Unitario</b></label> <input
									type="number" name="price" placeholder="Ingresar precio"
									class="form-control" required>
							</div>
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Porcentaje de Descuento</b></label> <input
									type="number" name="discount" onblur="validate()"
									placeholder="Ingresar descuento si aplica" class="form-control">
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Cantidad del Producto</b></label> <input
									type="number" name="quantity"
									placeholder="Ingresar cantidad del producto" class="form-control">
							</div>
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Seleccionar Categoria</b></label> <select
									name="categoryType" class="form-control">
									<option value="0">--Seleccionar Categoria--</option>
									<%
									for (Category c : categoryList) {
									%>
									<option value="<%=c.getCategoryId()%>">
										<%=c.getCategoryName()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>
						<div class="mb-2">
							<label class="form-label"><b>Imagen del Producto</b></label> <input
								type="file" name="photo" class="form-control" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cerrar</button>
						<button type="submit" class="btn btn-primary me-3">Agregar
							Producto</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end of modal -->

	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->

	<script type="text/javascript">
		function validate() {
			var dis = document.addProductForm.discount.value;
			if (dis > 100 || dis < 0) {
				alert("El descuento debe estar entre 0 y 100!");
				//document.addProductForm.discount.focus();
				return false;
			}
		}
	</script>
</body>
</html>
