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

public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Actualiza direccion, perfil o elimina usuarios segun la operacion recibida.
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("operation");
		HttpSession session = request.getSession();
		User oldUser = (User) session.getAttribute("activeUser");
		UserDao userDao = new UserDao(ConnectionProvider.getConnection());

		if (op.trim().equals("changeAddress")) {
			try {
				String userAddress = request.getParameter("user_address");
				String userCity = request.getParameter("city");
				String userZipcode = request.getParameter("zipcode");
				String userState = request.getParameter("state");

				User user = new User();
				user.setUserId(oldUser.getUserId());
				user.setUserName(oldUser.getUserName());
				user.setUserEmail(oldUser.getUserEmail());
				user.setUserPassword(oldUser.getUserPassword());
				user.setUserPhone(oldUser.getUserPhone());
				user.setUserGender(oldUser.getUserGender());
				user.setDateTime(oldUser.getDateTime());
				user.setUserAddress(userAddress);
				user.setUserCity(userCity);
				user.setUserZipcode(userZipcode);
				user.setUserState(userState);

				userDao.updateUserAddresss(user);
				session.setAttribute("activeUser", user);
				response.sendRedirect("checkout.jsp");

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (op.trim().equals("updateUser")) {
			try {
				String userName = request.getParameter("name");
				String userEmail = request.getParameter("email");
				String userPhone = request.getParameter("mobile_no");
				String userGender = request.getParameter("gender");
				String userAddress = request.getParameter("address");
				String userCity = request.getParameter("city");
				String userZipcode = request.getParameter("zipcode");
				String userState = request.getParameter("state");

				User user = new User(userName, userEmail, userPhone, userGender, userAddress, userCity, userZipcode,
						userState);
				user.setUserId(oldUser.getUserId());
				user.setUserPassword(oldUser.getUserPassword());
				user.setDateTime(oldUser.getDateTime());

				userDao.updateUser(user);
				session.setAttribute("activeUser", user);
				Message message = new Message("Informacion del usuario actualizada exitosamente!!", "success", "alert-success");
				session.setAttribute("message", message);
				response.sendRedirect("profile.jsp");

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (op.trim().equals("deleteUser")) {
			int uid = Integer.parseInt(request.getParameter("uid"));
			userDao.deleteUser(uid);
			response.sendRedirect("display_users.jsp");
		}
	}

	@Override
	// Reutiliza la misma logica del POST cuando la accion llega por GET.
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

}
