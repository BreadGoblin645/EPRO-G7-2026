<div class="container-fluid">
	<div class="row mt-5">
		<div class="col-md-4 offset-md-4">
			<div class="card">
				<div class="card-body px-5">

					<div class="container text-center">
						<img src="Images/forgot-password.png" style="max-width: 100px;"
							class="img-fluid">
					</div>
					<h3 class="text-center mt-3">Actualizar Contrasena</h3>

					<form action="ChangePasswordServlet" method="post">
						<div class="mb-3 mt-3">
							<label class="form-label">Nueva contrasena</label>
							<input type="password" name="password" id="profile_password"
								placeholder="Ingresar nueva contrasena" class="form-control" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Confirmar contrasena</label>
							<input type="password" id="profile_confirm_password"
								placeholder="Confirmar contrasena" class="form-control" required>
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

<script type="text/javascript">
	var password = document.getElementById("profile_password");
	var confirm_password = document.getElementById("profile_confirm_password");

	function validatePassword() {
		if (password.value != confirm_password.value) {
			confirm_password.setCustomValidity("Las contrasenas no coinciden");
		} else {
			confirm_password.setCustomValidity('');
		}
	}
	password.onchange = validatePassword;
	confirm_password.onkeyup = validatePassword;
</script>
