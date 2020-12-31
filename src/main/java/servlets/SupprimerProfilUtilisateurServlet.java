package servlets;

import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "ModifierProfilUtilisateurServlet")
public class SupprimerProfilUtilisateurServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mail = request.getParameter("login");
        Sql sql = new Sql();
        ResultSet res = sql.doRequest("DELECT * FROM user WHERE login = " + mail);
        try{
            while(res.next()) {
               int idUser = res.getInt("id_user");
               sql.deleteUser(idUser);
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        response.sendRedirect("/admin-pannel.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
