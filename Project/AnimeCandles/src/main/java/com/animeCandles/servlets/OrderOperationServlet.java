package com.animeCandles.servlets;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.animeCandles.dao.CartDao;
import com.animeCandles.dao.OrderDao;
import com.animeCandles.dao.OrderedProductDao;
import com.animeCandles.dao.ProductDao;
import com.animeCandles.entities.Cart;
import com.animeCandles.entities.Order;
import com.animeCandles.entities.OrderedProduct;
import com.animeCandles.entities.Product;
import com.animeCandles.entities.User;
import com.animeCandles.helper.ConnectionProvider;
import com.animeCandles.helper.FraudDetectionHelper;
import com.animeCandles.helper.FraudDetectionHelper.FraudContext;
import com.animeCandles.helper.FraudDetectionHelper.FraudResult;
import com.animeCandles.helper.MailMessenger;
import com.animeCandles.helper.OrderIdGenerator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class OrderOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Crea una orden desde carrito o compra directa y aplica revision antifraude.
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		HttpSession session = request.getSession();
		String from = (String) session.getAttribute("from");
		String paymentType = request.getParameter("payementMode");
		User user = (User) session.getAttribute("activeUser");
		String orderId = OrderIdGenerator.getOrderId();

		if (from.trim().equals("cart")) {
			try {

				CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
				List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
				OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
				ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
				OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
				int totalQuantity = 0;
				float totalAmount = 0;
				boolean completeStockPurchase = false;
				int maxProductQuantity = 0;

				for (Cart item : listOfCart) {
					Product prod = productDao.getProductsByProductId(item.getProductId());
					int availableStock = productDao.getProductQuantityById(item.getProductId());
					int originalStock = availableStock + item.getQuantity();
					totalQuantity += item.getQuantity();
					totalAmount += prod.getProductPriceAfterDiscount() * item.getQuantity();
					if (item.getQuantity() > maxProductQuantity) {
						maxProductQuantity = item.getQuantity();
					}
					if (originalStock > 0 && item.getQuantity() >= originalStock) {
						completeStockPurchase = true;
					}
				}

				FraudResult fraudResult = FraudDetectionHelper.analyze(new FraudContext(user, paymentType, totalQuantity,
						totalAmount, completeStockPurchase, orderDao.hasRecentOrderByUserId(user.getUserId(), 30),
						maxProductQuantity, orderDao.countOrdersByUserIdWithinHours(user.getUserId(), 24),
						orderDao.countCancelledOrdersByUserId(user.getUserId())));
				Order order = createOrder(orderId, paymentType, user.getUserId(), fraudResult);
				int id = orderDao.insertOrder(order);

				for (Cart item : listOfCart) {

					Product prod = productDao.getProductsByProductId(item.getProductId());
					String prodName = prod.getProductName();
					int prodQty = item.getQuantity();
					float price = prod.getProductPriceAfterDiscount();
					String image = prod.getProductImages();

					OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id,
							item.getProductId());
					orderedProductDao.insertOrderedProduct(orderedProduct);
				}
				session.removeAttribute("from");
				session.removeAttribute("totalPrice");

				//removing all product from cart after successful order
				cartDao.removeAllProduct();

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (from.trim().equals("buy")) {

			try {

				int pid = (int) session.getAttribute("pid");
				OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
				OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
				ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());

				Product prod = productDao.getProductsByProductId(pid);
				String prodName = prod.getProductName();
				int prodQty = 1;
				float price = prod.getProductPriceAfterDiscount();
				String image = prod.getProductImages();
				int availableStock = productDao.getProductQuantityById(pid);
				boolean completeStockPurchase = availableStock > 0 && prodQty >= availableStock;
				FraudResult fraudResult = FraudDetectionHelper.analyze(new FraudContext(user, paymentType, prodQty,
						price, completeStockPurchase, orderDao.hasRecentOrderByUserId(user.getUserId(), 30), prodQty,
						orderDao.countOrdersByUserIdWithinHours(user.getUserId(), 24),
						orderDao.countCancelledOrdersByUserId(user.getUserId())));
				Order order = createOrder(orderId, paymentType, user.getUserId(), fraudResult);
				int id = orderDao.insertOrder(order);

				OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id, pid);
				orderedProductDao.insertOrderedProduct(orderedProduct);

				//updating(decreasing) quantity of product in database
				productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);

				session.removeAttribute("from");
				session.removeAttribute("pid");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	    session.setAttribute("order", "success");
	    MailMessenger.successfullyOrderPlaced(user.getUserName(), user.getUserEmail(), orderId, new Date().toString());
        response.sendRedirect("index.jsp");
	}

	// Reutiliza el flujo de creacion cuando la peticion llega por GET.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	// Construye la orden con estado normal o FLAGGED segun el resultado antifraude.
	private Order createOrder(String orderId, String paymentType, int userId, FraudResult fraudResult) {
		String status = fraudResult.isSuspicious() ? "FLAGGED" : "Order Placed";
		Order order = new Order(orderId, status, paymentType, userId);
		order.setSuspicious(fraudResult.isSuspicious());
		order.setSuspiciousReason(fraudResult.getReason());
		return order;
	}

}
