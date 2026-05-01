package com.animeCandles.servlets;

import java.io.IOException;

import com.animeCandles.dao.FeesDao;
import com.animeCandles.entities.Message;
import com.animeCandles.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminFeesServlet")
public class AdminFeesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String operation = request.getParameter("operation");
        if (operation == null || !operation.equals("updateFees")) {
            Message msg = new Message("Operacion invalida!", "error", "alert-danger");
            session.setAttribute("message", msg);
            response.sendRedirect("edit_fees.jsp");
            return;
        }

        try {
            float shipping = Float.parseFloat(request.getParameter("shipping_fee"));
            float packaging = Float.parseFloat(request.getParameter("packaging_fee"));

            if (shipping < 0 || packaging < 0) {
                Message msg = new Message("Las tarifas no pueden ser negativas!", "error", "alert-danger");
                session.setAttribute("message", msg);
                response.sendRedirect("edit_fees.jsp");
                return;
            }

            FeesDao feesDao = new FeesDao(ConnectionProvider.getConnection());
            boolean ok = feesDao.updateFees(shipping, packaging);

            if (ok) {
                Message msg = new Message("Tarifas actualizadas exitosamente!", "success", "alert-success");
                session.setAttribute("message", msg);
            } else {
                Message msg = new Message("No se pudieron actualizar las tarifas!", "error", "alert-danger");
                session.setAttribute("message", msg);
            }

            response.sendRedirect("edit_fees.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            Message msg = new Message("Valores invalidos para las tarifas!", "error", "alert-danger");
            session.setAttribute("message", msg);
            response.sendRedirect("edit_fees.jsp");
        }
    }
}
