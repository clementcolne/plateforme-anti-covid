package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ConnexionServlet")
public class ConnexionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mail = request.getParameter("email");
        String password = request.getParameter("password");

        Sql sql = new Sql();
        User u = sql.connectUser(mail, password);
        if(u.getMail() == null) {
            // utilisateur inconnu
            response.sendRedirect("/connexion.jsp?error=Utilisateur inconnu");
        }else if(u.getPassword() == null){
            // mot de passe faux
            response.sendRedirect("/connexion.jsp?error=Mot de passe eronne");
        }else{
            // la connexion a réussi
            request.getSession().setAttribute("user", u);
            response.sendRedirect("/index.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
