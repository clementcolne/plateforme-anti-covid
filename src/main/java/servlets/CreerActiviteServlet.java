package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CreerActiviteServlet")
public class CreerActiviteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String idPlace = request.getParameter("id_place");

        if(name == "" || date == "" || startTime == "" || endTime == "" || idPlace == "") {
            // il manque un paramètre
            response.sendRedirect("creer-activite.jsp?error=Tous les parametres doivent etre remplis.");
        }else {
            User user = (User) request.getSession().getAttribute("user");
            Sql sql = new Sql();
            sql.addActivity(user.getId(), name, date, startTime, endTime, Integer.parseInt(idPlace));
            response.sendRedirect("activites.jsp?success=Activite creee avec succes.");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
