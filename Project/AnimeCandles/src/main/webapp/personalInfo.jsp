<%@page import="com.animeCandles.entities.Message" %>
<%@page import="com.animeCandles.entities.User" %>

<% 
User user1=(User) session.getAttribute("activeUser"); 
if (user1==null) { 
    Message message=new Message("No has iniciado sesion! Inicia sesion primero.", "error" , "alert-danger" ); 
    session.setAttribute("message", message);
    response.sendRedirect("login.jsp"); 
    return; 
} 
String userState = user1.getUserState() != null ? user1.getUserState().trim() : "";
%>

            <style>
                label {
                    font-weight: bold;
                }
            </style>
            <div class="container px-3 py-3">
                <h3>Informacion Personal</h3>
                <form id="update-user" action="UpdateUserServlet" method="post">
                    <input type="hidden" name="operation" value="updateUser">
                    <div class="row">
                        <div class="col-md-6 mt-2">
                            <label class="form-label">Nombre completo</label> 
                            <input type="text" name="name" class="form-control" placeholder="Nombre y apellido" value="<%=user1.getUserName()%>" required>
                        </div>
                        <div class="col-md-6 mt-2">
                            <label class="form-label">Correo</label> 
                            <input type="email" name="email" placeholder="Correo electronico" class="form-control" value="<%=user1.getUserEmail()%>" required>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mt-2">
                          <label class="form-label">Numero de telefono</label> 
<input type="text" name="mobile_no" placeholder="Ej: 77778888" class="form-control" 
       value="<%=user1.getUserPhone()%>" required pattern="[0-9]{8}" 
       title="El numero de telefono debe tener exactamente 8 digitos numericos.">
                        </div>
                        <div class="col-md-6 mt-5">
                            <label class="form-label pe-3">Genero</label>
                            <% String gender=user1.getUserGender(); if (gender != null && gender.trim().equals("Male")) { %>
                                <input class="form-check-input" type="radio" name="gender" value="Male" checked> <span class="form-check-label pe-3 ps-1"> Masculino </span> 
                                <input class="form-check-input" type="radio" name="gender" value="Female"> <span class="form-check-label ps-1"> Femenino </span>
                            <% } else { %>
                                <input class="form-check-input" type="radio" name="gender" value="Male"> <span class="form-check-label pe-3 ps-1"> Masculino </span> 
                                <input class="form-check-input" type="radio" name="gender" value="Female" checked> <span class="form-check-label ps-1"> Femenino </span>
                            <% } %>
                        </div>
                    </div>
                    <div class="mt-2">
                        <label class="form-label">Direccion</label> 
                        <input type="text" name="address" placeholder="Ingresar direccion, zona y calle" class="form-control" value="<%=user1.getUserAddress()%>" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mt-2">
                            <label class="form-label">Ciudad</label> 
                            <input class="form-control" type="text" name="city" placeholder="Ciudad, distrito o municipio" value="<%=user1.getUserCity()%>" required>
                        </div>
                        <div class="col-md-6 mt-2">
                            <label class="form-label">Codigo postal</label> 
                            <input class="form-control" type="number" name="zipcode" placeholder="Codigo postal" value="<%=user1.getUserZipcode()%>" required>
                        </div>
                    </div>
                    
                    <div class="row mt-2">
                        <div class="col-md-12 mt-2">
                            <label class="form-label">Departamento</label>
                            <select name="state" id="state-list" class="form-select" required>
                                <option value="" disabled <%= userState.isEmpty() ? "selected" : "" %> hidden>--Seleccionar departamento--</option>
                                <option value="Ahuachapan" <%= userState.equals("Ahuachapan") ? "selected" : "" %>>Ahuachapan</option>
                                <option value="Cabanas" <%= userState.equals("Cabanas") ? "selected" : "" %>>Cabanas</option>
                                <option value="Chalatenango" <%= userState.equals("Chalatenango") ? "selected" : "" %>>Chalatenango</option>
                                <option value="Cuscatlan" <%= userState.equals("Cuscatlan") ? "selected" : "" %>>Cuscatlan</option>
                                <option value="La Libertad" <%= userState.equals("La Libertad") ? "selected" : "" %>>La Libertad</option>
                                <option value="La Paz" <%= userState.equals("La Paz") ? "selected" : "" %>>La Paz</option>
                                <option value="La Union" <%= userState.equals("La Union") ? "selected" : "" %>>La Union</option>
                                <option value="Morazan" <%= userState.equals("Morazan") ? "selected" : "" %>>Morazan</option>
                                <option value="San Miguel" <%= userState.equals("San Miguel") ? "selected" : "" %>>San Miguel</option>
                                <option value="San Salvador" <%= userState.equals("San Salvador") ? "selected" : "" %>>San Salvador</option>
                                <option value="San Vicente" <%= userState.equals("San Vicente") ? "selected" : "" %>>San Vicente</option>
                                <option value="Santa Ana" <%= userState.equals("Santa Ana") ? "selected" : "" %>>Santa Ana</option>
                                <option value="Sonsonate" <%= userState.equals("Sonsonate") ? "selected" : "" %>>Sonsonate</option>
                                <option value="Usulutan" <%= userState.equals("Usulutan") ? "selected" : "" %>>Usulutan</option>
                            </select>
                        </div>
                    </div>
                    <div id="submit-btn" class="container text-center mt-3">
                        <button type="submit" class="btn btn-outline-primary me-3">Actualizar</button>
                        <button type="reset" class="btn btn-outline-primary">Limpiar</button>
                    </div>
                </form>
            </div>
