package com.rohitgawande.dao;

import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import com.rohitgawande.model.Admin;

public class AdminDAO {
    public Admin validateAdmin(String username, String password) throws SQLException {
        String query = "SELECT * FROM admins WHERE username = ?";
        Admin admin = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    // In a real application, use proper password hashing like BCrypt
                    // For demo purposes, we're using simple comparison
                    if (storedPassword.equals(hashPassword(password))) {
                        admin = new Admin();
                        admin.setId(rs.getInt("id"));
                        admin.setUsername(rs.getString("username"));
                        admin.setPassword(rs.getString("password"));
                        admin.setEmail(rs.getString("email"));
                        admin.setLastLogin(rs.getTimestamp("last_login"));
                        
                        // Update last login time
                        updateLastLogin(admin.getId());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return admin;
    }
    
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    
    private void updateLastLogin(int adminId) throws SQLException {
        String query = "UPDATE admins SET last_login = NOW() WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, adminId);
            ps.executeUpdate();
        }
    }
    
    public boolean changePassword(int adminId, String newPassword) throws SQLException {
        String query = "UPDATE admins SET password = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, hashPassword(newPassword));
            ps.setInt(2, adminId);
            return ps.executeUpdate() > 0;
        }
    }
}