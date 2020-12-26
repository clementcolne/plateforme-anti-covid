package sql;

import beans.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;

/**
 * @author Clément Colné
 */
public class Sql {

    static final String JDBC_DRIVER = Constants.DRIVER;
    static final String DB_URL = Constants.PATH;
    static final String USER = "root";
    static final String PASS = Constants.PASSWORD;

    /**
     * Effectue une connexion à la base de données
     * @return une connexion à la base de données
     */
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

    /**
     * Ajoute un utilisateur dans la base de données si celui-ci n'existe pas
     * @param nom nom de l'utilisateur
     * @param prenom prénom de l'utilisateur
     * @param mail mail de l'utilisateur (unique)
     * @param password mot de passe de l'utilisateur en clair
     * @param naissance date de laissance JJ/MM/YYYY de l'utilisateur
     * @return User l'utilisateur
     */
    public User addUser(String nom, String prenom, String mail, String password, String naissance) {
        Connection con = connect();

        // on vérifie si un utilisateur n'a pas déjà ce mail
        User u = getUser(mail);
        if(u != null) {
            // l'utilisateur existe déjà
            return null;
        }

        String rqString = "INSERT INTO User(login, password, last_name, first_name, birthday, is_admin, is_infected) VALUES(?, ?, ?, ?, ?, ?, ?);";
        
        try {
            PreparedStatement preparedStmt = con.prepareStatement(rqString);
            preparedStmt.setString(1, mail);
            preparedStmt.setString(2, generateHashedPassword(password));
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

        u = new User();
        u.setBirthday(naissance);
        u.setMail(mail);
        u.setNom(nom);
        u.setPrenom(prenom);
        return u;
    }

    /**
     * Retourne l'utilisateur correspondant au mail donné en paramètre si il existe
     * @param mail login de l'utilisateur
     * @return User l'utilisateur correspondant au mail en paramètre si il existe, null sinon
     */
    public User getUser(String mail) {
        User user = null;

        String rqString = "SELECT * FROM user WHERE login ='" + mail + "'";
        ResultSet res = doRequest(rqString);

        try{
            while (res.next()){
                user = new User();
                user.setMail(res.getString("login"));
                user.setPassword(res.getString("password"));
                user.setNom(res.getString("first_name"));
                user.setPrenom(res.getString("last_name"));
                user.setBirthday(res.getString("birthday"));
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        return user;
    }

    /**
     * Retourne l'utilisateur qui match avec mail/password. Si l'utilisateur est inconnu, l'objet user avec tous les champs à null sont retournée.
     * Si l'utilisateur existe mais que les mots de passe ne concordent pas, alors seulement le champ mail de l'utilisateur est complété.
     * @param mail login de l'utilisateur
     * @param password mot de passe en clair de l'utilisateur
     * @return User l'utilisateur
     */
    public User connectUser(String mail, String password) {
        User user = null;

        String rqString = "Select * from user where login ='" + mail + "'";
        ResultSet res = doRequest(rqString);
        user = new User();

        try{
            while(res.next()) {
                if((res.getString("login") != null)) {
                    // l'utilisateur existe, on enregistre son login
                    user.setMail(res.getString("login"));
                    if(res.getString("password").equals(generateHashedPassword(password))) {
                        // l'utilisateur existe et les mots de passe concordent, on enregistre le reste des info de l'utilisateur
                        user.setPassword(res.getString("password"));
                        user.setNom(res.getString("first_name"));
                        user.setPrenom(res.getString("last_name"));
                        user.setBirthday(res.getString("birthday"));
                    }
                }
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return user;
    }

    /**
     * METHODE COPIE COLLE D'ANCIEN CODE NON TESTEE
     */
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

    /**
     * Génère le hash du mot de passe en SHA-512 en paramètre
     * @param password mot de passe à hasher
     * @return mot de passe hashé
     */
    public String generateHashedPassword(String password) {
        String generatedPassword = null;
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            // Add password bytes to digest
            md.update(password.getBytes());
            // Get the hash's bytes
            byte[] bytes = md.digest();
            // This bytes[] has bytes in decimal format;
            // Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++) {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            //Get complete hashed password in hex format
            generatedPassword = sb.toString();
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        return generatedPassword;
    }

    public User updateAccount(String nom, String prenom, String mail, String password, String naissance) {
        Connection con = connect();

        // on vérifie si un utilisateur n'a pas déjà ce mail
        User u = getUser(mail);
        if(u != null) {
            // l'utilisateur existe déjà
            return null;
        }

        String rqString = "UPDATE User SET login = ?, password = ?, last_name = ?, first_name = ?, birthday = ?, is_admin = ?, is_infected = ? WHERE login = ?;";

        try {
            PreparedStatement preparedStmt = con.prepareStatement(rqString);
            preparedStmt.setString(1, mail);
            preparedStmt.setString(2, generateHashedPassword(password));
            preparedStmt.setString(3, nom);
            preparedStmt.setString(4, prenom);
            preparedStmt.setString(5, naissance);
            // par défaut, un utilisateur n'est ni un admin, ni infecté
            preparedStmt.setInt(6, 0);
            preparedStmt.setInt(7, 0);
            preparedStmt.setString(8, mail);
            preparedStmt.executeUpdate();

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

        u = new User();
        u.setBirthday(naissance);
        u.setMail(mail);
        u.setNom(nom);
        u.setPrenom(prenom);
        return u;
    }

}
