package servlets;

import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ModifierActiviteServlet")
public class ModifierActiviteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idActivity = Integer.parseInt(request.getParameter("id_activity"));
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        int idPlace = Integer.parseInt(request.getParameter("id_place"));

        if(name == null || date == null || startTime == null || endTime == null) {
            // un paramètre est manquant
            response.sendRedirect("update-activity.jsp?activityToUpdate=" + idActivity + "&error=Tous les champs doivent etre remplis.");
        }else{
            Sql sql = new Sql();
            sql.updateActivity(idActivity, name, date, startTime, endTime, idPlace);
            response.sendRedirect("admin-pannel.jsp?success=L'actvite a ete modifiee avec succes.");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
