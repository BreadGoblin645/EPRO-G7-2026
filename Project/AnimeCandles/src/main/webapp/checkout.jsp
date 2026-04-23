<%@page import="com.animeCandles.entities.Message"%>
<%@page import="com.animeCandles.dao.ProductDao"%>
<%@page import="com.animeCandles.dao.CartDao"%>
<%@page import="com.animeCandles.dao.FeesDao"%>
<%@page import="com.animeCandles.helper.ConnectionProvider"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_exception.jsp"%>

<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
    Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("login.jsp");
    return;
}

String from = (String) session.getAttribute("from");
if (from == null) {
    from = "cart"; // fallback por si acaso
}

// Traer fees actuales desde DB
FeesDao feesDao = new FeesDao(ConnectionProvider.getConnection());
float[] fees = feesDao.getFees();
float shippingFee = fees[0];
float packagingFee = fees[1];
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout</title>
<%@include file="Components/common_css_js.jsp"%>
</head>

<body>

    <%@include file="Components/navbar.jsp"%>

    <div class="container mt-5" style="font-size: 17px;">
        <div class="row">

            <!-- left column -->
            <div class="col-md-8">
                <div class="card">
                    <div class="container px-3 py-3">
                        <div class="card">
                            <div class="container-fluid text-white" style="background-color: #389aeb;">
                                <h4>Delivery Address</h4>
                            </div>
                        </div>

                        <div class="mt-3 mb-3">
                            <h5><%=activeUser.getUserName()%> &nbsp; <%=activeUser.getUserPhone()%></h5>
                            <%
                            StringBuilder str = new StringBuilder();
                            str.append(activeUser.getUserAddress()).append(", ");
                            str.append(activeUser.getUserCity()).append(", ");
                            str.append(activeUser.getUserState()).append(", ");
                            str.append(activeUser.getUserZipcode());
                            out.println(str);
                            %>
                            <br>

                            <div class="text-end">
                                <button type="button" class="btn btn-outline-primary"
                                    data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    Change Address
                                </button>
                            </div>
                        </div>

                        <hr>

                        <div class="card">
                            <div class="container-fluid text-white" style="background-color: #389aeb;">
                                <h4>Payment Options</h4>
                            </div>
                        </div>

                        <form action="OrderOperationServlet" method="post">
                            <div class="form-check mt-2">
                                <!-- PAGO CON TARGETA 
                                <input class="form-check-input" type="radio" name="payementMode" value="Card Payment" required>
                                <label class="form-check-label">Credit /Debit /ATM card</label><br>
                                    <div class="mb-3">
                                        <input class="form-control mt-3" type="number" placeholder="Enter card number" name="cardno">
                                        <div class="row gx-5">
                                            <div class="col mt-3">
                                                <input class="form-control" type="number" placeholder="Enter CVV" name="cvv">
                                            </div>
                                            <div class="col mt-3">
                                                <input class="form-control" type="text" placeholder="Valid through i.e '07/23'">
                                            </div>
                                        </div>
                                        <input class="form-control mt-3" type="text" placeholder="Enter card holder name" name="name">
                                    </div>
                                -->
                                <!-- PAGO DELIVERY -->    
                                <div>
                                    <input class="form-check-input" type="radio" name="payementMode" value="Cash on Delivery" checked>
                                    <label class="form-check-label">Cash on Delivery</label><br><br><br>
                                </div>

                                <!-- PAGO PICKUP 
                                <div>
                                    <input class="form-check-input" type="radio" name="payementMode" value="Cash on Pick Up">
                                    <label class="form-check-label">Cash on Pick Up</label><br>
                                </div>
                                -->  
                                
                                <div class="text-end">
                                    <button type="submit" class="btn btn-lg btn-outline-primary mt-3">
                                        Place Order
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- end of column -->

            <!-- right column -->
            <div class="col-md-4">
                <div class="card">
                    <div class="container px-3 py-3">
                        <h4>Price Details</h4>
                        <hr>

                        <%
                        if (from.trim().equals("cart")) {
                            CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                            int totalProduct = cartDao.getCartCountByUserId(activeUser.getUserId());

                            // OJO: sigue viniendo de session, pero al menos fees ya son dinámicos.
                            // Recomendación futura: recalcular total del carrito desde DB.
                            float totalPrice = 0f;
                            Object tp = session.getAttribute("totalPrice");
                            if (tp != null) {
                                totalPrice = (float) tp;
                            }

                            float amountPayable = totalPrice + shippingFee + packagingFee;
                        %>

                        <table class="table table-borderless">
                            <tr>
                                <td>Total Item</td>
                                <td><%=totalProduct%></td>
                            </tr>
                            <tr>
                                <td>Total Price</td>
                                <td>$ <%=totalPrice%></td>
                            </tr>
                            <tr>
                                <td>Delivery Charges</td>
                                <td>$ <%=shippingFee%></td>
                            </tr>
                            <tr>
                                <td>Packaging Charges</td>
                                <td>$ <%=packagingFee%></td>
                            </tr>
                            <tr>
                                <td><h5>Amount Payable :</h5></td>
                                <td><h5>$ <%=amountPayable%></h5></td>
                            </tr>
                        </table>

                        <%
                        } else {
                            ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                            int pid = (int) session.getAttribute("pid");
                            float price = productDao.getProductPriceById(pid);

                            float amountPayable = price + shippingFee + packagingFee;
                        %>

                        <table class="table table-borderless">
                            <tr>
                                <td>Total Item</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>Total Price</td>
                                <td>$ <%=price%></td>
                            </tr>
                            <tr>
                                <td>Delivery Charges</td>
                                <td>$ <%=shippingFee%>></td>
                            </tr>
                            <tr>
                                <td>Packaging Charges</td>
                                <td>$ <%=packagingFee%></td>
                            </tr>
                            <tr>
                                <td><h5>Amount Payable :</h5></td>
                                <td><h5>$ <%=amountPayable%></h5></td>
                            </tr>
                        </table>

                        <%
                        }
                        %>

                    </div>
                </div>
            </div>
            <!-- end of column -->
        </div>
    </div>

    <!--Change Address -->
    <div class="modal fade" id="exampleModal" tabindex="-1"
        aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Change Address</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                </div>

                <form action="UpdateUserServlet" method="post">
                    <input type="hidden" name="operation" value="changeAddress">
                    <div class="modal-body mx-3">

                        <div class="mt-2">
                            <label class="form-label fw-bold">Address</label>
                            <textarea name="user_address" rows="3"
                                placeholder="Enter Address(Area and Street))"
                                class="form-control" required></textarea>
                        </div>

                        <div class="mt-2">
                            <label class="form-label fw-bold">City</label>
                            <input class="form-control" type="text" name="city"
                                placeholder="City/District/Town" required>
                        </div>

                        <div class="mt-2">
                            <label class="form-label fw-bold">Zip Code</label>
                            <input class="form-control" type="number" name="zipcode"
                                placeholder="Zip Code" maxlength="6" required>
                        </div>

                        <div class="mt-2">
                            <label class="form-label fw-bold">State</label>
                            <select name="state" class="form-select">
                                <option selected>--Select State--</option>
                                <option value="Ahuachapan">Ahuachapan</option>
                                <option value="Cabanas">Cabanas</option>
                                <option value="Chalatenango">Chalatenango</option>
                                <option value="Cuscatlan">Cuscatlan</option>
                                <option value="La Libertad">La Libertad</option>
                                <option value="La Paz">La Paz</option>
                                <option value="La Union">La Union</option>
                                <option value="Morazan">Morazan</option>
                                <option value="San Miguel">San Miguel</option>
                                <option value="San Salvador">San Salvador</option>
                                <option value="San Vicente">San Vicente</option>
                                <option value="Santa Ana">Santa Ana</option>
                                <option value="Sonsonate">Sonsonate</option>
                                <option value="Usulutan">Usulutan</option>
                            </select>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>

            </div>
        </div>
    </div>


    <!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->

</body>
</html>