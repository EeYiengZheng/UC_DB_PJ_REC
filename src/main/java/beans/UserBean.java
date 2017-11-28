package main.java.beans;

public class UserBean {
    private String username;
    private String password;
    private boolean loggedIn;
    private String type;
    public static final String LECTURER = "Lecturer";
    public static final String STUDENT = "Student";
    public static final String VIP = "VIP";


    public UserBean() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isLoggedIn() {
        return loggedIn;
    }

    public void setLoggedIn(boolean loggedIn) {
        this.loggedIn = loggedIn;
    }

    public void setType(String type) {
    	this.type = type;
    }

    public String getType() {
    	return type;
    }
}