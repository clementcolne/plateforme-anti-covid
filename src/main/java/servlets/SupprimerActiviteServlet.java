package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SupprimerActiviteServlet")
public class SupprimerActiviteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idActivite = Integer.parseInt(request.getParameter("id_activite"));
        System.out.println(idActivite);
        Sql sql = new Sql();
        sql.deleteActivity(idActivite);
        response.sendRedirect("/activites.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
