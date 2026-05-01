package com.animeCandles.servlets;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import com.animeCandles.dao.UserDao;
import com.animeCandles.entities.Message;
import com.animeCandles.entities.User;
import com.animeCandles.helper.ConnectionProvider;
import com.animeCandles.helper.MailMessenger;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String referrer = request.getHeader("referer");
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());
		HttpSession session = request.getSession();
		
		if(referrer.contains("forgot_password")) {
			String email = request.getParameter("email").trim();
			List<String> list = userDao.getAllEmail();
			if(list.contains(email)) {
				Random rand = new Random();
				int max = 99999, min = 10000;
				int otp = rand.nextInt(max - min + 1) + min;
				//System.out.println(otp);
				session.setAttribute("otp", otp);
				session.setAttribute("email", email);
				MailMessenger.sendOtp(email, otp);
				
				Message message = new Message("Hemos enviado un codigo para restablecer su contrasena a: "+email, " exitosamente", "alert-success");
				session.setAttribute("message", message);
				response.sendRedirect("otp_code.jsp");
			}else {
				Message message = new Message("Email no encontrado! Intenta con otro correo!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("forgot_password.jsp");
				return;
			}
		}else if(referrer.contains("otp_code")) {
			int code = Integer.parseInt(request.getParameter("code"));
			int otp = (int)session.getAttribute("otp");
			if(code == otp) {
				session.removeAttribute("otp");
				response.sendRedirect("change_password.jsp");
			}else {
				Message message = new Message("Codigo de verificacion incorrecto!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("otp_code.jsp");
				return;
			}
		}else if(referrer.contains("change_password") || referrer.contains("profile")) {
			String password = request.getParameter("password");
			String email = null;

			if(session.getAttribute("email") != null) {
				email = (String) session.getAttribute("email");
			} else if(session.getAttribute("activeUser") != null) {
				User activeUser = (User) session.getAttribute("activeUser");
				email = activeUser.getUserEmail();
			}

			if(email != null) {
				userDao.updateUserPasswordByEmail(password, email);

				if(session.getAttribute("email") != null) {
					session.removeAttribute("email");

					Message message = new Message("Contrasena actualizada exitosamente!", "success", "alert-success");
					session.setAttribute("message", message);
					response.sendRedirect("login.jsp");
				} else {
					Message message = new Message("Contrasena actualizada exitosamente!!", "success", "alert-success");
					session.setAttribute("message", message);
					response.sendRedirect("profile.jsp");
				}
			} else {
				Message message = new Message("Unable to update password!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("login.jsp");
			}
		}
	}
}
