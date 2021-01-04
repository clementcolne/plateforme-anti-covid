package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ModifierProfilUtilisateurrServlet")
public class ModifierProfilUtilisateurServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String oldMail = request.getParameter("old_mail");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String naissance = request.getParameter("naissance");
        if(email.equals("") || prenom.equals("") || nom.equals("") || naissance.equals("")) {
            response.sendRedirect("/update-user.jsp?error=Aucun champ de modification de compte ne peut etre vide.");
        }else{
            Sql sql = new Sql();
            User u = sql.updateAccount(nom, prenom, email, null, naissance, oldMail);
            if(u == null) {
                // un utilisateur avec ce mail existe déjà
                response.sendRedirect("/update-user.jsp?error=Ce mail est deja utilise.");
            }else {
                // ajout de l'utilisateur dans la session
                request.getSession().setAttribute("userToUpdate", email);
                response.sendRedirect("/update-user.jsp?success=Le compte a bien ete mis a jour.");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
