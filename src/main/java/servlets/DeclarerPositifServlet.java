package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeclarerPositifServlet")
public class DeclarerPositifServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // on récupère l'utilisateur qui se déclare positif
        User u = (User) request.getSession().getAttribute("user");
        Sql sql = new Sql();

        sql.declarerPositif(u.getId());

        response.sendRedirect("index.jsp?success=Vous avez bien ete declare positif a la Covid-19. Les personnes ayant ete en contact avec vous dans les 10 derniers jours ont ete averties.");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
