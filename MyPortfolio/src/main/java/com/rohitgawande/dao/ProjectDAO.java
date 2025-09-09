package com.rohitgawande.dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import com.rohitgawande.model.Project;

public class ProjectDAO {

    private Project extractProject(ResultSet rs) throws SQLException {
        Project project = new Project();
        project.setId(rs.getInt("id"));
        project.setTitle(rs.getString("title"));
        project.setDescription(rs.getString("description"));
        project.setTechStack(rs.getString("tech_stack"));
        project.setImageUrl(rs.getString("image_url"));
        project.setProjectLink(rs.getString("project_link"));
        project.setGithubLink(rs.getString("github_link"));

        // Using LocalDateTime instead of java.sql.Date
        Timestamp timestamp = rs.getTimestamp("created_at");
        if (timestamp != null) {
            project.setCreatedAt(timestamp.toLocalDateTime());
        }

        return project;
    }

    public List<Project> getAllProjects() throws SQLException {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT * FROM projects ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setTitle(rs.getString("title"));
                project.setDescription(rs.getString("description"));
                project.setTechStack(rs.getString("tech_stack"));
                project.setImageUrl(rs.getString("image_url"));
                project.setProjectLink(rs.getString("project_link"));
                project.setGithubLink(rs.getString("github_link"));
                
                Timestamp timestamp = rs.getTimestamp("created_at");
                if (timestamp != null) {
                    project.setCreatedAt(timestamp.toLocalDateTime());
                }

                projects.add(project);
            }
        }
        return projects;
    }


   

    public boolean addProject(Project project) throws SQLException {
        String query = "INSERT INTO projects (title, description, tech_stack, image_url, project_link, github_link, created_at) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, project.getTitle());
            ps.setString(2, project.getDescription());
            ps.setString(3, project.getTechStack());
            ps.setString(4, project.getImageUrl());
            ps.setString(5, project.getProjectLink());
            ps.setString(6, project.getGithubLink());
            ps.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now())); // Auto set current timestamp

            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Update existing project
    public boolean updateProject(Project project) throws SQLException {
        String query = "UPDATE projects SET title = ?, description = ?, tech_stack = ?, image_url = ?, project_link = ?, github_link = ? " +
                       "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, project.getTitle());
            ps.setString(2, project.getDescription());
            ps.setString(3, project.getTechStack());
            ps.setString(4, project.getImageUrl());
            ps.setString(5, project.getProjectLink());
            ps.setString(6, project.getGithubLink());
            ps.setInt(7, project.getId());

            return ps.executeUpdate() > 0;
        }
    }
    public Project getProjectById(int id) throws SQLException {
        String query = "SELECT * FROM projects WHERE id = ?";
        Project project = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    project = new Project();
                    project.setId(rs.getInt("id"));
                    project.setTitle(rs.getString("title"));
                    project.setDescription(rs.getString("description"));
                    project.setTechStack(rs.getString("tech_stack"));
                    project.setImageUrl(rs.getString("image_url"));
                    project.setProjectLink(rs.getString("project_link"));
                    project.setGithubLink(rs.getString("github_link"));
                    
                    Timestamp timestamp = rs.getTimestamp("created_at");
                    if (timestamp != null) {
                        project.setCreatedAt(timestamp.toLocalDateTime());
                    }
                }
            }
        }
        return project;
    }


    public boolean deleteProject(int id) throws SQLException {
        String query = "DELETE FROM projects WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
