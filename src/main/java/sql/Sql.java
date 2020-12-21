package sql;

import beans.User;

import java.sql.*;

/**
 * @author Clément Colné
 */
public class Sql {

    static final String JDBC_DRIVER = Constants.DRIVER;
    static final String DB_URL = Constants.PATH;
    static final String USER = "root";
    static final String PASS = Constants.PASSWORD;

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

    public void addUser(String nom, String prenom, String mail, String password,String passwordConfirmed, String naissance) {
        Connection con = connect();

        String rqString = "INSERT INTO User(login, password, last_name, first_name, birthday, is_admin, is_infected) VALUES(?, ?, ?, ?, ?, ?, ?);";


        try {
            PreparedStatement preparedStmt = con.prepareStatement(rqString);
            preparedStmt.setString(1, mail);
            preparedStmt.setString(2, password);
            preparedStmt.setString(3, nom);
            preparedStmt.setString(4, prenom);
            preparedStmt.setString(5, naissance);
            // par défaut, un utilisateur n'est ni un admin, ni infecté
            preparedStmt.setInt(6, 0);
            preparedStmt.setInt(7, 0);
            preparedStmt.execute();

            con.close();
        }catch (SQLException e) {
            if(con != null){
                try {
                    con.close();
                } catch (SQLException ignored) {
                }
            }
            e.printStackTrace();
        }

        //return getUser(mail);
    }

    /**
     * Retourne l'utilisateur correspondant au login donné en paramètre
     * @param mail login de l'utilisateur
     * @return un utilisateur
     */
    public User getUser(String mail) {
        User user = null;

        String rqString = "Select * from user where login ='" + mail + "'";
        ResultSet res = doRequest(rqString);

        try{
            user = new User();
            while (res.next()){
                user.setMail(res.getString("mail"));
                user.setPassword(res.getString("passord"));
                user.setNom(res.getString("first_name"));
                user.setPrenom(res.getString("last_name"));
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        return user;
    }

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
