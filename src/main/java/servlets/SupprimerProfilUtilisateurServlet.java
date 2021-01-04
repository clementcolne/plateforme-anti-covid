package servlets;

import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ModifierProfilUtilisateurServlet")
public class SupprimerProfilUtilisateurServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUser = Integer.parseInt(request.getParameter("id_user"));
        Sql sql = new Sql();
        sql.deleteUser(idUser);
        response.sendRedirect("/admin-pannel.jsp?success=L'utilisateur a bien ete supprime.");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
