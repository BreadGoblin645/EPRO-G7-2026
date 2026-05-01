<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Algo salio mal</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>

	<div class="container p-5 text-center">
		<img src="Images\no-results.png" class="img-fluid" style="max-width: 400px;">
		<h1>Lo sentimos! Algo salio mal...</h1>
		<p><%=exception%></p>
		<a href="index.jsp" class="btn btn-outline-primary btn-lg mt-3">Pagina
			Principal</a>
	</div>

	<!-- Footer -->
    <%@ include file="Components/footer.jsp" %>
	<!-- end -->
</body>
</html>
