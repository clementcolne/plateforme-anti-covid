package beans;

/**
 * @author Clément Colné
 */
public class User {

    private String mail;
    private String password;
    private String nom;
    private String prenom;
    private String birthday;
    private boolean isAdmin;
    private boolean isInfected;
    private int id;

    public User() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getMail() {
        return mail;
    }

    public String getPassword() {
        return password;
    }

    public String getBirthday() {
        return birthday;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public boolean isInfected() {
        return isInfected;
    }

    public void setAdmin(int admin) {
        if (admin == 1) isAdmin = true;
        else isAdmin = false;
    }

    public void setInfected(int infected) {
        if (infected == 1) isInfected = true;
        else isInfected = false;
    }
}
