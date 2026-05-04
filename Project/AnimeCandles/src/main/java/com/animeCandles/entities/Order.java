package com.animeCandles.entities;

import java.sql.Timestamp;

public class Order {
	
	private int id;
	private String orderId;
	private String status;
	private Timestamp date;
	private String payementType;
	private int userId;
	private boolean suspicious;
	private String suspiciousReason;
	private String reviewedBy;
	private Timestamp reviewDate;
	
	public Order() {
		super();
	}

	public Order(String orderId, String status, Timestamp date, String payementType, int userId) {
		super();
		this.orderId = orderId;
		this.status = status;
		this.date = date;
		this.payementType = payementType;
		this.userId = userId;
	}

	public Order(String orderId, String status, String payementType, int userId) {
		super();
		this.orderId = orderId;
		this.status = status;
		this.payementType = payementType;
		this.userId = userId;
	}

	public Order(String orderId, String status, Timestamp date, String payementType, int userId, boolean suspicious,
			String suspiciousReason, String reviewedBy, Timestamp reviewDate) {
		super();
		this.orderId = orderId;
		this.status = status;
		this.date = date;
		this.payementType = payementType;
		this.userId = userId;
		this.suspicious = suspicious;
		this.suspiciousReason = suspiciousReason;
		this.reviewedBy = reviewedBy;
		this.reviewDate = reviewDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getPayementType() {
		return payementType;
	}

	public void setPayementType(String payementType) {
		this.payementType = payementType;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public boolean isSuspicious() {
		return suspicious;
	}

	public void setSuspicious(boolean suspicious) {
		this.suspicious = suspicious;
	}

	public String getSuspiciousReason() {
		return suspiciousReason;
	}

	public void setSuspiciousReason(String suspiciousReason) {
		this.suspiciousReason = suspiciousReason;
	}

	public String getReviewedBy() {
		return reviewedBy;
	}

	public void setReviewedBy(String reviewedBy) {
		this.reviewedBy = reviewedBy;
	}

	public Timestamp getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Timestamp reviewDate) {
		this.reviewDate = reviewDate;
	}

	
}
