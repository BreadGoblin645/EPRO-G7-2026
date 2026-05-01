package com.animeCandles.servlets;

import java.io.IOException;
import java.net.URI;

import com.animeCandles.dao.WishlistDao;
import com.animeCandles.entities.Wishlist;
import com.animeCandles.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class WishlistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		int pid = Integer.parseInt(request.getParameter("pid"));
		String op = request.getParameter("op");

		WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());
		if (op.trim().equals("add")) {
			Wishlist wishlist = new Wishlist(uid, pid);
			wishlistDao.addToWishlist(wishlist);
			response.sendRedirect(getRedirectUrl(request, "products.jsp"));
		} else if (op.trim().equals("remove")) {
			wishlistDao.deleteWishlist(uid, pid);
			response.sendRedirect(getRedirectUrl(request, "products.jsp"));
		}else if(op.trim().equals("delete")) {
			wishlistDao.deleteWishlist(uid, pid);
			response.sendRedirect("profile.jsp");
		}
	}

	private String getRedirectUrl(HttpServletRequest request, String fallback) {
		String referer = request.getHeader("referer");
		if (referer == null || referer.trim().isEmpty()) {
			return fallback;
		}

		try {
			URI refererUri = URI.create(referer);
			String path = refererUri.getPath();
			String contextPath = request.getContextPath();

			if (contextPath != null && !contextPath.isEmpty()) {
				if (!path.startsWith(contextPath + "/")) {
					return fallback;
				}
				path = path.substring(contextPath.length() + 1);
			} else if (path.startsWith("/")) {
				path = path.substring(1);
			}

			if (path.isEmpty()) {
				return fallback;
			}

			String query = refererUri.getRawQuery();
			return query == null ? path : path + "?" + query;
		} catch (IllegalArgumentException e) {
			return fallback;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
