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
    Message message = new Message("No has iniciado sesion! Inicia sesion primero.", "error", "alert-danger");
    session.setAttribute("message", message);
    response.sendRedirect("login.jsp");
    return;
}

String from = (String) session.getAttribute("from");
if (from == null) {
    from = "cart"; // fallback por si acaso
}

// Trae fees actuales desde DB
FeesDao feesDao = new FeesDao(ConnectionProvider.getConnection());
float[] fees = feesDao.getFees();
float shippingFee = fees[0];
float packagingFee = fees[1];
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pago</title>
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
                                <h4>Direccion de entrega</h4>
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
                                    Cambiar Direccion
                                </button>
                            </div>
                        </div>

                        <hr>

                        <div class="card">
                            <div class="container-fluid text-white" style="background-color: #389aeb;">
                                <h4>Metodo de pago</h4>
                            </div>
                        </div>

                        <form action="OrderOperationServlet" method="post">
                            <div class="form-check mt-2">
                                <!-- PAGO CON TARGETA
                                <input class="form-check-input" type="radio" name="payementMode" value="Card Payment" required>
                                <label class="form-check-label">Tarjeta de credito/debito/ATM</label><br>
                                    <div class="mb-3">
                                        <input class="form-control mt-3" type="number" placeholder="Ingresar numero de tarjeta" name="cardno">
                                        <div class="row gx-5">
                                            <div class="col mt-3">
                                                <input class="form-control" type="number" placeholder="Ingresar CVV" name="cvv">
                                            </div>
                                            <div class="col mt-3">
                                                <input class="form-control" type="text" placeholder="Valida hasta, ej. '07/23'">
                                            </div>
                                        </div>
                                        <input class="form-control mt-3" type="text" placeholder="Ingresar nombre del titular" name="name">
                                    </div>
                                -->
                                <!-- PAGO DELIVERY -->
                                <div>
                                    <input class="form-check-input" type="radio" name="payementMode" value="Cash on Delivery" checked>
                                    <label class="form-check-label">Efectivo al momento de entrega</label><br><br><br>
                                </div>

                                <!-- PAGO PICKUP
                                <div>
                                    <input class="form-check-input" type="radio" name="payementMode" value="Cash on Pick Up">
                                    <label class="form-check-label">Efectivo al recoger</label><br>
                                </div>
                                -->

                                <div class="text-end">
                                    <button type="submit" class="btn btn-lg btn-outline-primary mt-3">
                                        Ordenar
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
                        <h4>Detalles de la orden</h4>
                        <hr>

                        <%
                        if (from.trim().equals("cart")) {
                            CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                            int totalProduct = cartDao.getCartCountByUserId(activeUser.getUserId());

                            float totalPrice = 0f;

                            Object tp = session.getAttribute("totalPrice");
                            if (tp != null) {
                                totalPrice = (float) tp;
                            }

                            float amountPayable = totalPrice + shippingFee + packagingFee;
                        %>

                        <table class="table table-borderless">
                            <tr>
                                <td>Cantidad de productos :</td>
                                <td><%=totalProduct%></td>
                            </tr>
                            <tr>
                                <td>Precio Total :</td>
                                <td>$ <%=totalPrice%></td>
                            </tr>
                            <tr>
                                <td>Envio :</td>
                                <td>$ <%=shippingFee%></td>
                            </tr>
                            <tr>
                                <td>Empaquetado :</td>
                                <td>$ <%=packagingFee%></td>
                            </tr>
                            <tr>
                                <td><h5>Total a pagar :</h5></td>
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
	                                <td>Total de productos</td>
                                <td>1</td>
                            </tr>
                            <tr>
	                                <td>Precio Total</td>
                                <td>$ <%=price%></td>
                            </tr>
                            <tr>
	                                <td>Envio</td>
                                <td>$ <%=shippingFee%>></td>
                            </tr>
                            <tr>
	                                <td>Empaquetado</td>
                                <td>$ <%=packagingFee%></td>
                            </tr>
                            <tr>
	                                <td><h5>Total a pagar :</h5></td>
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
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Cambiar direccion</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Cerrar"></button>
                </div>

                <form action="UpdateUserServlet" method="post">
                    <input type="hidden" name="operation" value="changeAddress">
                    <div class="modal-body mx-3">

                        <div class="mt-2">
                            <label class="form-label fw-bold">Direccion</label>
                            <textarea name="user_address" rows="3"
                                placeholder="Ingresar direccion"
                                class="form-control" required></textarea>
                        </div>

                        <div class="mt-2">
                            <label class="form-label fw-bold">Ciudad</label>
                            <input class="form-control" type="text" name="city"
                                placeholder="Ciudad" required>
                        </div>

                        <div class="mt-2">
	                        <label class="form-label fw-bold">Codigo postal</label>
                            <input class="form-control" type="number" name="zipcode"
                                placeholder="Codigo Postal" maxlength="6" required>
                        </div>

                        <div class="mt-2">
                            <label class="form-label fw-bold">Departamento</label>
                            <select name="state" class="form-select">
                                <option selected>- - Seleccionar - -</option>
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
                            data-bs-dismiss="modal">Cerrar</button>
                        <button type="submit" class="btn btn-primary">Guardar</button>
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
