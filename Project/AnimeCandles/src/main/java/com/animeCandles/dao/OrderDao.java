package com.animeCandles.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.animeCandles.entities.Order;

public class OrderDao {
	
	private Connection con;
	public OrderDao(Connection con) {
		super();
		this.con = con;
	}
	
	public int insertOrder(Order order) {
		int id = 0;
		try {
			String query = "insert into `order`(orderid, status, paymentType, userId, is_suspicious, suspicious_reason, reviewed_by, review_date) values(?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			
			psmt.setString(1, order.getOrderId());
			psmt.setString(2, order.getStatus());
			psmt.setString(3, order.getPayementType());
			psmt.setInt(4, order.getUserId());
			psmt.setBoolean(5, order.isSuspicious());
			psmt.setString(6, order.getSuspiciousReason());
			psmt.setString(7, order.getReviewedBy());
			psmt.setTimestamp(8, order.getReviewDate());
			
			int affectedRows = psmt.executeUpdate();

	        if (affectedRows == 0) {
	            throw new SQLException("Insertion failed, no rows affected.");
	        }
	        try (ResultSet generatedKeys = psmt.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                id = generatedKeys.getInt(1);
	            }
	            else {
	                throw new SQLException("Insertion failed, no ID obtained.");
	            }
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	public List<Order> getAllOrderByUserId(int uid){
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select * from `order` where userId = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Order order = mapOrder(rs);

				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public Order getOrderById(int id){
		Order order = new Order();
		try {
			String query = "select * from `order` where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, id);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				order = mapOrder(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return order;
	}
	public Timestamp getLastOrderDateByUserId(int uid){
		Timestamp date = null;
		try {
			String query = "select date from `order` where userId = ? order by date desc limit 1";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				date = rs.getTimestamp("date");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}
	public boolean hasRecentOrderByUserId(int uid, int minutes){
		boolean hasRecentOrder = false;
		try {
			String query = "select count(*) from `order` where userId = ? and date >= (now() - interval ? minute)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			psmt.setInt(2, minutes);
			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				hasRecentOrder = rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return hasRecentOrder;
	}
	public int countOrdersByUserIdWithinHours(int uid, int hours){
		int count = 0;
		try {
			String query = "select count(*) from `order` where userId = ? and date >= (now() - interval ? hour)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			psmt.setInt(2, hours);
			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	public int countCancelledOrdersByUserId(int uid){
		int count = 0;
		try {
			String query = "select count(*) from `order` where userId = ? and status = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setInt(1, uid);
			psmt.setString(2, "Order Cancelled");
			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	public List<Order> getAllOrder(){
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select * from `order`";
			Statement statement = this.con.createStatement();
			ResultSet rs = statement.executeQuery(query);
			while (rs.next()) {
				Order order = mapOrder(rs);
				
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<Order> getNormalOrders(){
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select * from `order` where status <> ? and status <> ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, "FLAGGED");
			psmt.setString(2, "Order Cancelled");
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Order order = mapOrder(rs);

				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<Order> getSuspiciousOrders(){
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select * from `order` where status = ? and is_suspicious = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, "FLAGGED");
			psmt.setBoolean(2, true);
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Order order = mapOrder(rs);

				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<Order> getCancelledOrders(){
		List<Order> list = new ArrayList<Order>();
		try {
			String query = "select * from `order` where status = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, "Order Cancelled");
			ResultSet rs = psmt.executeQuery();
			while (rs.next()) {
				Order order = mapOrder(rs);

				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public void updateOrderStatus(int oid, String status) {
		try {
			String query = "update `order` set status = ? where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, status);
			psmt.setInt(2, oid);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void markOrderAsSuspicious(int oid, String suspiciousReason) {
		try {
			String query = "update `order` set status = ?, is_suspicious = ?, suspicious_reason = ?, reviewed_by = null, review_date = null where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, "FLAGGED");
			psmt.setBoolean(2, true);
			psmt.setString(3, suspiciousReason);
			psmt.setInt(4, oid);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void reviewSuspiciousOrder(int oid, String status, boolean suspicious, String reviewedBy) {
		try {
			String query = "update `order` set status = ?, is_suspicious = ?, reviewed_by = ?, review_date = ? where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, status);
			psmt.setBoolean(2, suspicious);
			psmt.setString(3, reviewedBy);
			psmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			psmt.setInt(5, oid);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void cancelOrder(int oid, boolean suspicious, String reviewedBy) {
		try {
			String query = "update `order` set status = ?, is_suspicious = ?, reviewed_by = ?, review_date = ? where id = ?";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, "Order Cancelled");
			psmt.setBoolean(2, suspicious);
			psmt.setString(3, reviewedBy);
			psmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			psmt.setInt(5, oid);

			psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	private Order mapOrder(ResultSet rs) throws SQLException {
		Order order = new Order();
		order.setId(rs.getInt("id"));
		order.setOrderId(rs.getString("orderid"));
		order.setStatus(rs.getString("status"));
		order.setDate(rs.getTimestamp("date"));
		order.setPayementType(rs.getString("paymentType"));
		order.setUserId(rs.getInt("userId"));
		order.setSuspicious(rs.getBoolean("is_suspicious"));
		order.setSuspiciousReason(rs.getString("suspicious_reason"));
		order.setReviewedBy(rs.getString("reviewed_by"));
		order.setReviewDate(rs.getTimestamp("review_date"));
		return order;
	}
}
