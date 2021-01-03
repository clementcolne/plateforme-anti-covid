package servlets;

import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "ModifierActiviteServlet")
public class ModifierActiviteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idActivity = Integer.parseInt(request.getParameter("id_activity"));
        int idUser = Integer.parseInt(request.getParameter("created_by"));
        String name = request.getParameter("name");
        Date date = Date.valueOf(request.getParameter("date"));
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        int idPlace = Integer.parseInt(request.getParameter("id_place"));

        if(name == "" || date == null || startTime == "" || endTime == "") {
            // un paramètre est manquant
            response.sendRedirect("modifier-activite.jsp?activityToUpdate=" + idActivity + "&error=Tous les champs doivent etre remplis.");
        }else{
            // on vérifie que heureDebut <= heureFin
            // on split les strings
            String[] startSplitted = startTime.split(":");
            String[] endSplitted = endTime.split(":");
            // on compare les heures
            if(Integer.parseInt(startSplitted[0]) > Integer.parseInt(endSplitted[0])) {
                // heure début > heure fin, c'est interdit
                response.sendRedirect("modifier-activite.jsp?activityToUpdate=" + idActivity + "&error=L'heure de debut ne peut pas etre superieure a l'heure de fin.");
            }else if(Integer.parseInt(startSplitted[0]) == Integer.parseInt(endSplitted[0])) {
                // les heures sont égales, on compare les minutes
                if(Integer.parseInt(startSplitted[1]) > Integer.parseInt(endSplitted[1])) {
                    // les minutes de début > minutes de fin, c'est interdit
                    response.sendRedirect("modifier-activite.jsp?activityToUpdate=" + idActivity + "&error=L'heure de debut ne peut pas etre superieure a l'heure de fin.");
                }else{
                    Sql sql = new Sql();
                    sql.updateActivity(idActivity, name, date, startTime, endTime, idPlace, idUser);
                    response.sendRedirect("admin-pannel.jsp?success=Activite modifiee avec succes.");
                }
            }else {
                Sql sql = new Sql();
                sql.updateActivity(idActivity, name, date, startTime, endTime, idPlace, idUser);
                response.sendRedirect("admin-pannel.jsp?success=L'actvite a ete modifiee avec succes.");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
