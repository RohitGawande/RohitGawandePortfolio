package com.rohitgawande.dao;

import java.sql.*;
import java.util.*;
import com.rohitgawande.model.Message;

public class MessageDAO {
    public boolean saveMessage(Message message) throws SQLException {
        String query = "INSERT INTO messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, message.getName());
            ps.setString(2, message.getEmail());
            ps.setString(3, message.getSubject());
            ps.setString(4, message.getMessage());
            
            return ps.executeUpdate() > 0;
        }
    }

    public List<Message> getAllMessages() throws SQLException {
        List<Message> messages = new ArrayList<>();
        String query = "SELECT * FROM messages ORDER BY timestamp DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt("id"));
                message.setName(rs.getString("name"));
                message.setEmail(rs.getString("email"));
                message.setSubject(rs.getString("subject"));
                message.setMessage(rs.getString("message"));
                message.setTimestamp(rs.getTimestamp("timestamp"));
                message.setIsRead(rs.getBoolean("is_read"));
                messages.add(message);
            }
        }
        return messages;
    }

    public Message getMessageById(int id) throws SQLException {
        String query = "SELECT * FROM messages WHERE id = ?";
        Message message = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    message = new Message();
                    message.setId(rs.getInt("id"));
                    message.setName(rs.getString("name"));
                    message.setEmail(rs.getString("email"));
                    message.setSubject(rs.getString("subject"));
                    message.setMessage(rs.getString("message"));
                    message.setTimestamp(rs.getTimestamp("timestamp"));
                    message.setIsRead(rs.getBoolean("is_read"));
                }
            }
        }
        return message;
    }

    public boolean markAsRead(int id) throws SQLException {
        String query = "UPDATE messages SET is_read = true WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteMessage(int id) throws SQLException {
        String query = "DELETE FROM messages WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}