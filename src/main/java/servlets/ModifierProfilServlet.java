package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ModifierProfilServlet")
public class ModifierProfilServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User)request.getSession().getAttribute("user");
        String old_mail = user.getMail();
        String email = request.getParameter("email");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String naissance = request.getParameter("naissance");
        String password = request.getParameter("password");
        String passwordConfirmed = request.getParameter("password-confirmed");
        if(email.equals("") || prenom.equals("") || nom.equals("") || naissance.equals("") || password.equals("")) {
            response.sendRedirect("/profil.jsp?error=Aucun champ de modification de compte ne peut etre vide.");
        }else if(!password.equals(passwordConfirmed)) {
            // les mots de passe ne concordent pas
            response.sendRedirect("/profil.jsp?error=Les mots de passes sont differents.");
        }else{
            Sql sql = new Sql();
            User u = sql.updateAccount(nom, prenom, email, password, naissance, old_mail);
            if(u == null) {
                // un utilisateur avec ce mail existe déjà
                response.sendRedirect("/profil.jsp?error=Ce mail est deja utilise.");
            }else {
                // ajout de l'utilisateur dans la session
                request.getSession().setAttribute("user", u);
                response.sendRedirect("/profil.jsp??success=Le compte a bien ete mis a jour.");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
