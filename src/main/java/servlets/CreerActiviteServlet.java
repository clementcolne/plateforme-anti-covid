package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "CreerActiviteServlet")
public class CreerActiviteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        Date date = Date.valueOf(request.getParameter("date"));
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String idPlace = request.getParameter("id_place");

        if(name == "" || date == null || startTime == "" || endTime == "" || idPlace == "") {
            // il manque un paramètre
            response.sendRedirect("creer-activite.jsp?error=Tous les parametres doivent etre remplis.");
        }else {
            // on vérifie que heureDebut <= heureFin
            // on split les strings
            String[] startSplitted = startTime.split(":");
            String[] endSplitted = endTime.split(":");
            // on compare les heures
            if(Integer.parseInt(startSplitted[0]) > Integer.parseInt(endSplitted[0])) {
                // heure début > heure fin, c'est interdit
                response.sendRedirect("creer-activite.jsp?error=L'heure de debut ne peut pas etre superieure a l'heure de fin.");
            }else if(Integer.parseInt(startSplitted[0]) == Integer.parseInt(endSplitted[0])) {
                // les heures sont égales, on compare les minutes
                if(Integer.parseInt(startSplitted[1]) > Integer.parseInt(endSplitted[1])) {
                    // les minutes de début > minutes de fin, c'est interdit
                    response.sendRedirect("creer-activite.jsp?error=L'heure de debut ne peut pas etre superieure a l'heure de fin.");
                }else{
                    User user = (User) request.getSession().getAttribute("user");
                    Sql sql = new Sql();
                    sql.addActivity(user.getId(), name, date, startTime, endTime, Integer.parseInt(idPlace));
                    response.sendRedirect("activites.jsp?success=Activite creee avec succes.");
                }
            }else {
                User user = (User) request.getSession().getAttribute("user");
                Sql sql = new Sql();
                sql.addActivity(user.getId(), name, date, startTime, endTime, Integer.parseInt(idPlace));
                response.sendRedirect("activites.jsp?success=Activite creee avec succes.");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
