package sql;

import java.sql.*;

/**
 * @author Clément Colné
 */
public class Sql {

    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:8889/jee_database";
    static final String USER = "root";
    // adapter la constante à l'OS utilisé
    static final String PASS = Constants.password;

    public Connection connect() {
        Connection connection = null;

        try{
            Class.forName(JDBC_DRIVER);
        }catch (ClassNotFoundException e) {
            System.out.println("Erreur, impossible de se connecter à la base de donnée.");
            e.printStackTrace();
            System.exit(99);
        }

        try{
            System.out.println("Connexion à la base de données ...");
            connection = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Conexion réussie !");
        } catch (SQLException throwables) {
            System.out.println("Erreur, impossible de se connecter à la base de donnée.");
            throwables.printStackTrace();
            System.exit(99);
        }

        return connection;
    }

    /*public UserBean addUser(String m, String pwd, String fn, String ln) {
        Connection con = connect();

        String rqString = "Insert into User VALUES(?, ?, ?, ?);";

        try{
            PreparedStatement preparedStmt = con.prepareStatement(rqString);
            preparedStmt.setString(1, m);
            preparedStmt.setString(2, pwd);
            preparedStmt.setString(3, fn);
            preparedStmt.setString(4, ln);
            preparedStmt.execute();

            con.close();
        } catch (SQLException e){
            if(con != null){
                try {
                    con.close();
                } catch (SQLException ignored) {
                }
            }
            e.printStackTrace();
        }

        return getUser(m);
    }

    public UserBean getUser(String m) {
        UserBean user = null;

        String rqString = "Select * from user where mail ='" + m + "'";
        ResultSet res = doRequest(rqString);

        try{
            user = new UserBean();
            while (res.next()){
                user.setMail(res.getString("mail"));
                user.setPassword(res.getString("passord"));
                user.setFirstName(res.getString("first_name"));
                user.setLastName(res.getString("last_name"));
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        return user;
    }*/

    public ResultSet doRequest(String sql_string){
        ResultSet results = null;
        Connection con = connect();
        try {
            Statement stmt = con.createStatement();
            results = stmt.executeQuery(sql_string);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return results;
    }

}
