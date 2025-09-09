package com.rohitgawande.model;

import java.sql.Timestamp;

public class Admin {
    private int id;
    private String username;
    private String password;
    private String email;
    private Timestamp lastLogin;  // Changed from Date to Timestamp

    // Constructors
    public Admin() {}

    public Admin(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.lastLogin = new Timestamp(System.currentTimeMillis());
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Timestamp getLastLogin() { return lastLogin; }
    public void setLastLogin(Timestamp lastLogin) { this.lastLogin = lastLogin; }
}
