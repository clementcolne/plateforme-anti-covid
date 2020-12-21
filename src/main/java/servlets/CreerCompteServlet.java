package servlets;

import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CreerCompteServlet")
public class CreerCompteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // récupération des champs utilisateur
        String email = request.getParameter("email");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String password = request.getParameter("password");
        String passwordConfirmed = request.getParameter("password-confirmed");
        String naissance = request.getParameter("naissance");

        if(password != passwordConfirmed) {
            // les mots de passe ne concordent pas
            response.sendRedirect("/creer-compte.jsp?error=Les mots de passes sont differents");
        }else {
            Sql sql = new Sql();
            sql.addUser(nom, prenom, email, password, passwordConfirmed, naissance);
            response.sendRedirect("/creer-compte.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
