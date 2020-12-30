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
        Sql sql = new Sql();
        if(request.getParameter("id_activite") != null) {
            int idActivite = Integer.parseInt(request.getParameter("id_activite"));
            sql.deleteActivity(idActivite);
            response.sendRedirect("/activites.jsp?success=L'activite a ete supprimee avec succes.");
        }else{
            int idActivite = Integer.parseInt(request.getParameter("id_activite_admin"));
            sql.deleteActivity(idActivite);
            response.sendRedirect("/admin-pannel.jsp?success=L'activite a ete supprimee avec succes.");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
