package beans;

import java.util.Date;

/**
 * @author Clément Colné
 */
public class User {

    private String mail;
    private String password;
    private String nom;
    private String prenom;
    private Date naissance;

    public User() {
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

    public void setNaissance(Date naissance) {
        this.naissance = naissance;
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

}
