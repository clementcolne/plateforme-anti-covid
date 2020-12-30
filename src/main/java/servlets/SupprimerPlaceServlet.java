package servlets;

import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeletePlaceServlet")
public class SupprimerPlaceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idPlace = Integer.parseInt(request.getParameter("id_place"));
        Sql sql = new Sql();
        sql.deletePlace(idPlace);
        response.sendRedirect("/admin-pannel.jsp?success=Le lieu a ete supprime avec succes.");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
