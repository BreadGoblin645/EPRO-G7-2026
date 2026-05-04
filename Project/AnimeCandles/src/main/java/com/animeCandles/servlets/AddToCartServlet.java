package com.animeCandles.servlets;

import java.io.IOException;

import com.animeCandles.dao.CartDao;
import com.animeCandles.dao.ProductDao;
import com.animeCandles.entities.Cart;
import com.animeCandles.entities.Message;
import com.animeCandles.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	// Agrega un producto al carrito y descuenta una unidad del inventario.
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int uid = Integer.parseInt(req.getParameter("uid"));
		int pid = Integer.parseInt(req.getParameter("pid"));

		CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
		int qty = cartDao.getQuantity(uid, pid);
		HttpSession session = req.getSession();
		Message message = null;

		if (qty == 0) {
			Cart cart = new Cart(uid, pid, qty + 1);
			cartDao.addToCart(cart);
			message = new Message("Producto agregado al carrito de compras!", "success", "alert-success");

		}else {
			int cid = cartDao.getIdByUserIdAndProductId(uid, pid);
			cartDao.updateQuantity(cid, qty+1);
			message = new Message("Otro producto agregado al carrito!", "success", "alert-success");
		}
		//updating quantity of product in database
		ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
		productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);
		session.setAttribute("message", message);
		resp.sendRedirect("viewProduct.jsp?pid="+pid);
	}

}
