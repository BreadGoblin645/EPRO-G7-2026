package com.animeCandles.helper;

import java.io.InputStream;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class Mail {

	// Envia un correo HTML usando la configuracion definida en mail.properties.
	public static void sendMail(String recipientMailId, String subject, String body) {

		try {
			Properties mailProps = new Properties();

			InputStream input = Mail.class.getClassLoader().getResourceAsStream("mail.properties");

			if (input == null) {
				System.out.println("No se encontró mail.properties en src/main/resources");
				return;
			}

			mailProps.load(input);

			String emailId = mailProps.getProperty("mail.email");
			String password = mailProps.getProperty("mail.password");

			if (emailId == null || emailId.trim().isEmpty()) {
				System.out.println("mail.email está vacío o no existe en mail.properties");
				return;
			}

			if (password == null || password.trim().isEmpty()) {
				System.out.println("mail.password está vacío o no existe en mail.properties");
				return;
			}

			Properties properties = new Properties();
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.transport.protocol", "smtp");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.port", "587");

			Session session = Session.getInstance(properties, new Authenticator() {
				@Override
				// Entrega las credenciales SMTP al cliente de correo.
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(emailId, password);
				}
			});

			Message message = new MimeMessage(session);

			message.setFrom(new InternetAddress(emailId));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientMailId));
			message.setSubject(subject);
			message.setContent(body, "text/html; charset=utf-8");

			System.out.println("Intentando enviar correo a: " + recipientMailId);
			System.out.println("Correo emisor: " + emailId);

			Transport.send(message);

			System.out.println("Correo enviado correctamente a: " + recipientMailId);

		} catch (Exception e) {
			System.out.println("ERROR AL ENVIAR CORREO:");
			e.printStackTrace();
		}
	}
}
