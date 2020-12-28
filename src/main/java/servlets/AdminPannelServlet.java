package servlets;

import beans.User;
import sql.Sql;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;

@WebServlet(name = "AdminPannelServlet")
public class AdminPannelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null) {
            // page demandée sans être connecté
            response.sendRedirect("/index.jsp");
        }else if(!user.isAdmin()) {
            // page demandée par un non admin
            response.sendRedirect("/index.jsp");
        }else {
            response.sendRedirect("/admin-pannel.jsp");
        }
    }
}
