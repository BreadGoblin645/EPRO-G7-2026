package com.animeCandles.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.animeCandles.dao.OrderDao;
import com.animeCandles.dao.OrderedProductDao;
import com.animeCandles.dao.ProductDao;
import com.animeCandles.dao.UserDao;
import com.animeCandles.entities.Admin;
import com.animeCandles.entities.Order;
import com.animeCandles.entities.OrderedProduct;
import com.animeCandles.helper.ConnectionProvider;
import com.animeCandles.helper.MailMessenger;

public class UpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Actualiza estados de ordenes, revisa sospechosas y restaura stock al cancelar.
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int oid = Integer.parseInt(request.getParameter("oid"));
		String status = request.getParameter("status");
		String redirect = request.getParameter("redirect");
		if (redirect == null || redirect.trim().isEmpty()) {
			redirect = "display_orders.jsp";
		}
		if (status == null || status.trim().isEmpty()) {
			response.sendRedirect(redirect);
			return;
		}
		status = status.trim();

		OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
		Order currentOrder = orderDao.getOrderById(oid);
		boolean shouldRestoreStock = status.equals("Order Cancelled")
				&& !"Order Cancelled".equals(currentOrder.getStatus());

		if (status.equals("FLAGGED")) {
			orderDao.markOrderAsSuspicious(oid, "Marcada manualmente para revision");
		} else if (status.equals("Order Cancelled")) {
			Admin activeAdmin = (Admin) request.getSession().getAttribute("activeAdmin");
			String reviewedBy = activeAdmin != null ? activeAdmin.getName() : "Administrador";
			String suspiciousReason = currentOrder.getSuspiciousReason();
			if (suspiciousReason == null || suspiciousReason.trim().isEmpty()) {
				suspiciousReason = "Cancelada manualmente por administrador";
			}
			orderDao.cancelOrder(oid, currentOrder.isSuspicious(), reviewedBy, suspiciousReason);
		} else if ("FLAGGED".equals(currentOrder.getStatus()) && currentOrder.isSuspicious()
				&& status.equals("Order Confirmed")) {
			Admin activeAdmin = (Admin) request.getSession().getAttribute("activeAdmin");
			String reviewedBy = activeAdmin != null ? activeAdmin.getName() : "Administrador";
			orderDao.reviewSuspiciousOrder(oid, status, false, reviewedBy);
		} else {
			orderDao.updateOrderStatus(oid, status);
		}

		if (shouldRestoreStock) {
			restoreOrderStock(oid);
		}

		if (status.equals("Shipped") || status.equals("Out For Delivery")) {
			Order order = orderDao.getOrderById(oid);
			UserDao userDao = new UserDao(ConnectionProvider.getConnection());
			MailMessenger.orderShipped(userDao.getUserName(order.getUserId()), userDao.getUserEmail(order.getUserId()),
					order.getOrderId(), order.getDate().toString());
		}
		response.sendRedirect(redirect);
	}

	// Permite actualizar ordenes tambien cuando la accion llega por GET.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	// Devuelve al inventario las unidades asociadas a una orden cancelada.
	private void restoreOrderStock(int oid) {
		OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
		ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
		List<OrderedProduct> orderedProducts = orderedProductDao.getAllOrderedProduct(oid);

		for (OrderedProduct orderedProduct : orderedProducts) {
			if (orderedProduct.getProductId() > 0) {
				productDao.increaseQuantity(orderedProduct.getProductId(), orderedProduct.getQuantity());
			}
		}
	}

}
