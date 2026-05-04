package com.animeCandles.helper;

public class MailMessenger {

	// Prepara y envia el correo de bienvenida despues del registro.
	public static void successfullyRegister(String userName, String userEmail) {

		String subject = "Bienvenido a animeCandles - Registro exitoso";
		String body = "Hola " + userName
				+ ",<p>¡Felicidades y bienvenido a animeCandles! Nos alegra tenerte como parte de nuestra comunidad. Gracias por elegirnos para tus compras en línea.</p>"
				+ "<p>Tu registro se completó exitosamente. Ahora formas parte de nuestra plataforma, donde podrás encontrar una variedad de productos y ofertas pensadas para tus gustos e intereses.</p>"
				+ "<p>Una vez más, ¡bienvenido! Esperamos brindarte una experiencia de compra agradable y satisfactoria.</p>"
				+ "<p>¡Felices compras!</p>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Prepara y envia la confirmacion cuando una orden queda creada.
	public static void successfullyOrderPlaced(String userName, String userEmail, String orderId, String OrderDate) {
		String subject = "Confirmación de pedido - Tu producto está en camino";
		String body = "Hola " + userName
				+ ",<p>Nos alegra informarte que tu pedido fue realizado exitosamente y ahora está siendo procesado. ¡Gracias por elegir animeCandles para tus compras!</p>"
				+ "<p>Detalles del pedido: <br>" + "Número de pedido: " + orderId + "<br>Fecha del pedido: " + OrderDate + "</p>"
				+ "<p>Tu pedido está siendo preparado para su envío. Nuestro equipo está trabajando para empacar tus productos de forma segura y despacharlos lo antes posible.</p>"
				+ "<p>Cuando tu pedido sea enviado, recibirás otro correo con los detalles de seguimiento para que puedas monitorear su recorrido hasta llegar a tu dirección.</p>"
				+ "<p>¡Gracias por comprar con nosotros! Tu confianza en <b>animeCandles</b> significa mucho para nosotros, y esperamos brindarte una excelente experiencia de compra.</p>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Prepara y envia el aviso cuando la orden cambia a envio o reparto.
	public static void orderShipped(String userName, String userEmail, String orderId, String OrderDate) {
		String subject = "Tu pedido está en camino";
		String body = "Hola " + userName
				+ ",<p>¡Saludos de <b>animeCandles</b>! Te informamos que tu pedido ya está en camino. Tu paquete ha sido enviado y pronto llegará a tu dirección.</p>"
				+ "<p>Detalles del pedido: <br>" + "Número de pedido: " + orderId + "<br>Fecha del pedido: " + OrderDate + "</p>"
				+ "<p>Nuestro equipo ha procesado y empacado cuidadosamente tu pedido para asegurar que llegue en buenas condiciones. Nuestro servicio de entrega trabajará para llevar tu paquete lo antes posible.</p>"
				+ "<p>Una vez más, agradecemos tu confianza en <b>animeCandles</b>. Nuestro objetivo es brindarte una experiencia de compra satisfactoria.</p>"
				+ "<p>¡Gracias por elegirnos!</p>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Envia el codigo OTP usado para recuperar o cambiar contrasena.
	public static void sendOtp(String userEmail, int code) {
		String subject = "Código de verificación para cambio de contraseña";
		String body = "Hola, "
				+ "<p>Por favor utiliza el siguiente código de verificación para restablecer tu contraseña:</p>"
				+ "<h3>" + code + "</h3>";
		try {
			Mail.sendMail(userEmail, subject, body);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
