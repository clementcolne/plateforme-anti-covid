package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UpdatePlaceServlet")
public class UpdatePlaceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String adress = request.getParameter("adress");
        int idPlace = Integer.parseInt(request.getParameter("id_place"));
        if(name == null || adress == null) {
            // un paramètre est manquant
            response.sendRedirect("update-place.jsp?placeToUpdate=" + idPlace + "&error=Tous les champs doivent etre remplis.");
        }else{
            Sql sql = new Sql();
            sql.updatePlace(idPlace, name, adress);
            response.sendRedirect("admin-pannel.jsp?success=Le lieu a ete modifie avec succes.");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
