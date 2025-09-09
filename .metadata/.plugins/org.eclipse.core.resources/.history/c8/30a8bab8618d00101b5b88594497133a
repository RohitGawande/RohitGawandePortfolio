package com.rohitgawande.dao;

import java.sql.*;
import com.rohitgawande.model.Admin;

public class AdminDAO {
    public Admin validateAdmin(String username, String password) throws SQLException {
        String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
        Admin admin = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
        return admin;
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
            
            ps.setString(1, newPassword);
            ps.setInt(2, adminId);
            return ps.executeUpdate() > 0;
        }
    }
}