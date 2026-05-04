package com.animeCandles.helper;

import java.text.SimpleDateFormat;
import java.util.Date;

public class OrderIdGenerator {

	// Genera un identificador visible para la orden usando fecha y hora actual.
	public static String getOrderId() {
		String orderId = "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		orderId = sdf.format(new Date());
		orderId = "ORD-" + orderId;

		return orderId;
	}
}
