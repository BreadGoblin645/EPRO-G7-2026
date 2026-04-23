<%@page import="com.animeCandles.entities.Message"%>
<%@page import="com.animeCandles.dao.FeesDao"%>
<%@page import="com.animeCandles.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_exception.jsp"%>

<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
    Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("adminlogin.jsp");
    return;
}

FeesDao feesDao = new FeesDao(ConnectionProvider.getConnection());
float[] fees = feesDao.getFees();
float shippingFee = fees[0];
float packagingFee = fees[1];
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Fees</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>

<%@include file="Components/navbar.jsp"%>

<div class="container mt-4">
  <%@include file="Components/alert_message.jsp"%>

  <div class="card">
    <div class="card-header text-white" style="background-color:#389aeb;">
      <h4 class="mb-0">Edit Checkout Fees</h4>
    </div>

    <div class="card-body">
      <form action="AdminFeesServlet" method="post">
        <input type="hidden" name="operation" value="updateFees">

        <div class="mb-3">
          <label class="form-label fw-bold">Shipping Fee</label>
          <input class="form-control" type="number" step="0.01" min="0"
                 name="shipping_fee" value="<%=shippingFee%>" required>
        </div>

        <div class="mb-3">
          <label class="form-label fw-bold">Packaging Fee</label>
          <input class="form-control" type="number" step="0.01" min="0"
                 name="packaging_fee" value="<%=packagingFee%>" required>
        </div>

        <button class="btn btn-primary" type="submit">Save</button>
        <a class="btn btn-outline-secondary ms-2" href="admin.jsp">Back</a>
      </form>
    </div>
  </div>
</div>

<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->
   
</body>
</html>
