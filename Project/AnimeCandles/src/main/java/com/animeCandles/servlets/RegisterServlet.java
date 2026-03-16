package com.animeCandles.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.animeCandles.dao.UserDao;
import com.animeCandles.entities.Message;
import com.animeCandles.entities.User;
import com.animeCandles.helper.ConnectionProvider;
import com.animeCandles.helper.MailMessenger;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_mobile_no");
			String userGender = request.getParameter("gender");
			String userAddress = request.getParameter("user_address");
			String userCity = request.getParameter("city");
			String userZipcode = request.getParameter("zipcode");
			String userState = request.getParameter("state");

			User user = new User(userName, userEmail, userPassword, userPhone, userGender, userAddress, userCity, userZipcode, userState);
			UserDao userDao = new UserDao(ConnectionProvider.getConnection());
			boolean flag = userDao.saveUser(user);

			HttpSession session = request.getSession();
			Message message;
			if (flag) {
				message = new Message("Registration Successful !!", "success", "alert-success");
				MailMessenger.successfullyRegister(userName, userEmail);
			} else {
				message = new Message("Something went wrong! Try again!!", "error", "alert-danger");
			}
			session.setAttribute("message", message);
			response.sendRedirect("register.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
