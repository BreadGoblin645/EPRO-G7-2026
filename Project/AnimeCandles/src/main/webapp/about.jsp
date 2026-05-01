<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>About - AnimeCandles</title>

<%@ include file="Components/common_css_js.jsp" %>

<style>
    .about-section {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        margin-top: 30px;
        margin-bottom: 30px;
    }

    .about-title {
        color: #0d6efd;
        font-weight: bold;
    }

    .about-subtitle {
        color: #444;
        font-weight: 600;
        margin-top: 25px;
    }

    .about-text {
        color: #555;
        line-height: 1.8;
        font-size: 16px;
    }
</style>

</head>

<body>

    <!-- Navbar -->
    <%@ include file="Components/navbar.jsp" %>

    <div class="container">
        <div class="about-section">
            <h1 class="about-title text-center">AnimeCandles</h1>
            <p class="about-text text-center mt-3">
                AnimeCandles es una tienda en linea desarrollada como proyecto academico,
                enfocada en la venta de velas tematicas inspiradas en el mundo del anime.
            </p>

            <hr>

            <h2 class="about-subtitle">Grupo N7 - Estandares de Programacion</h2>
            <p class="about-text">
                Este proyecto fue realizado para la clase de Estandares de Programacion,
                aplicando buenas practicas de desarrollo, organizacion del codigo,
                estructura en capas y dise&ntilde;o de una aplicacion web funcional.
            </p>

            <h2 class="about-subtitle">Objetivo del proyecto</h2>
            <p class="about-text">
                El objetivo de AnimeCandles es simular un sistema de comercio electronico
                donde los usuarios puedan explorar productos, registrarse, iniciar sesion
                y realizar compras, mientras se implementan mejoras y controles dentro del sistema.
            </p>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="Components/footer.jsp" %>

</body>
</html>