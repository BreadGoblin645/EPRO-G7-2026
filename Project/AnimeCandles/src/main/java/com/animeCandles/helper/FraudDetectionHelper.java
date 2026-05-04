package com.animeCandles.helper;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.animeCandles.entities.User;

public class FraudDetectionHelper {

	private static final List<FraudRule> RULES = new ArrayList<FraudRule>();

	static {
		// Reglas activas para decidir si una orden debe ir a revision.
		RULES.add(context -> context.hasCompleteStockPurchase()
				? Optional.of("Compra del stock completo de un producto")
				: Optional.empty());
		RULES.add(context -> context.getTotalAmount() > 300
				? Optional.of("Total combinado de compra superior a $300")
				: Optional.empty());
		RULES.add(context -> context.hasRecentOrder()
				? Optional.of("Nueva compra del usuario en menos de 30 minutos")
				: Optional.empty());
		RULES.add(context -> context.getMaxProductQuantity() >= 5
				? Optional.of("Compra de 5 o mas unidades de un mismo producto")
				: Optional.empty());
		RULES.add(context -> context.getOrdersLast24Hours() >= 2
				? Optional.of("Usuario con 3 o mas ordenes en las ultimas 24 horas")
				: Optional.empty());
		RULES.add(context -> context.isNewUser(3) && context.getTotalAmount() > 200
				? Optional.of("Usuario nuevo con compra superior a $200")
				: Optional.empty());
		RULES.add(context -> context.hasIncompleteAddress()
				? Optional.of("Direccion de entrega incompleta o sospechosa")
				: Optional.empty());
		RULES.add(context -> context.getCancelledOrders() >= 2
				? Optional.of("Usuario con 2 o mas ordenes canceladas previamente")
				: Optional.empty());
	}

	// Ejecuta todas las reglas antifraude y acumula las razones detectadas.
	public static FraudResult analyze(FraudContext context) {
		List<String> reasons = new ArrayList<String>();
		for (FraudRule rule : RULES) {
			Optional<String> reason = rule.check(context);
			if (reason.isPresent()) {
				reasons.add(reason.get());
			}
		}
		if (!reasons.isEmpty()) {
			return FraudResult.suspicious(String.join("; ", reasons));
		}
		return FraudResult.safe();
	}

	@FunctionalInterface
	private interface FraudRule {
		// Devuelve una razon si la regla detecta actividad sospechosa.
		Optional<String> check(FraudContext context);
	}

	public static class FraudContext {
		private User user;
		private String paymentType;
		private int totalQuantity;
		private float totalAmount;
		private boolean completeStockPurchase;
		private boolean recentOrder;
		private int maxProductQuantity;
		private int ordersLast24Hours;
		private int cancelledOrders;

		public FraudContext(User user, String paymentType, int totalQuantity, float totalAmount,
				boolean completeStockPurchase, boolean recentOrder, int maxProductQuantity, int ordersLast24Hours,
				int cancelledOrders) {
			super();
			this.user = user;
			this.paymentType = paymentType;
			this.totalQuantity = totalQuantity;
			this.totalAmount = totalAmount;
			this.completeStockPurchase = completeStockPurchase;
			this.recentOrder = recentOrder;
			this.maxProductQuantity = maxProductQuantity;
			this.ordersLast24Hours = ordersLast24Hours;
			this.cancelledOrders = cancelledOrders;
		}

		public User getUser() {
			return user;
		}

		public String getPaymentType() {
			return paymentType;
		}

		public int getTotalQuantity() {
			return totalQuantity;
		}

		public float getTotalAmount() {
			return totalAmount;
		}

		public boolean hasCompleteStockPurchase() {
			return completeStockPurchase;
		}

		public boolean hasRecentOrder() {
			return recentOrder;
		}

		public int getMaxProductQuantity() {
			return maxProductQuantity;
		}

		public int getOrdersLast24Hours() {
			return ordersLast24Hours;
		}

		public int getCancelledOrders() {
			return cancelledOrders;
		}

		// Indica si el usuario fue registrado dentro del rango de dias indicado.
		public boolean isNewUser(int days) {
			if (user == null || user.getDateTime() == null) {
				return false;
			}
			long difference = System.currentTimeMillis() - user.getDateTime().getTime();
			return difference >= 0 && difference < days * 24L * 60L * 60L * 1000L;
		}

		// Valida campos minimos de direccion para detectar datos incompletos.
		public boolean hasIncompleteAddress() {
			if (user == null) {
				return true;
			}
			return isBlankOrShort(user.getUserAddress(), 8) || isBlankOrShort(user.getUserCity(), 3)
					|| isBlankOrShort(user.getUserState(), 2) || isBlankOrShort(user.getUserZipcode(), 4);
		}

		// Revisa si un texto esta vacio o no alcanza la longitud minima esperada.
		private boolean isBlankOrShort(String value, int minLength) {
			return value == null || value.trim().length() < minLength;
		}
	}

	public static class FraudResult {
		private boolean suspicious;
		private String reason;

		private FraudResult(boolean suspicious, String reason) {
			super();
			this.suspicious = suspicious;
			this.reason = reason;
		}

		// Crea un resultado marcado como sospechoso.
		public static FraudResult suspicious(String reason) {
			return new FraudResult(true, reason);
		}

		// Crea un resultado limpio cuando ninguna regla se activa.
		public static FraudResult safe() {
			return new FraudResult(false, null);
		}

		public boolean isSuspicious() {
			return suspicious;
		}

		public String getReason() {
			return reason;
		}
	}
}
