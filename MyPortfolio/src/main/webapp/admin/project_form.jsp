<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    com.rohitgawande.model.Project project = null;
    String action = request.getParameter("action");
    String pageTitle = "Add New Project";
    String formAction = "projects/insert";
    
    if ("edit".equals(action)) {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                com.rohitgawande.dao.ProjectDAO projectDAO = new com.rohitgawande.dao.ProjectDAO();
                project = projectDAO.getProjectById(id);
                pageTitle = "Edit Project";
                formAction = "projects/update";
            } catch (Exception e) {
                response.sendRedirect("manage_projects.jsp?error=invalid_id");
                return;
            }
        }
    }
    
    request.setAttribute("project", project);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %> - Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/admin.css">
</head>
<body class="admin-dashboard">
    <div class="admin-container">
        <!-- Sidebar -->
        <div class="admin-sidebar">
            <div class="admin-profile">
                <div class="profile-image">
                    <img src="../assets/images/admin-avatar.png" alt="Admin Avatar">
                </div>
                <div class="profile-info">
                    <h3>Rohit Gawande</h3>
                    <p>Administrator</p>
                </div>
            </div>
            
            <nav class="admin-nav">
                <ul>
                    <li class="nav-item">
                        <a href="dashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item active">
                        <a href="manage_projects.jsp">
                            <i class="fas fa-briefcase"></i>
                            <span>Manage Projects</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="view_messages.jsp">
                            <i class="fas fa-envelope"></i>
                            <span>Messages</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="settings.jsp">
                            <i class="fas fa-cog"></i>
                            <span>Settings</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        
        <!-- Main Content -->
        <div class="admin-main">
            <div class="admin-header">
                <h1><%= pageTitle %></h1>
                <div class="header-actions">
                    <a href="manage_projects.jsp" class="btn btn-outline">
                        <i class="fas fa-arrow-left"></i>
                        Back to Projects
                    </a>
                </div>
            </div>
            
            <div class="admin-form">
                <form action="<%= formAction %>" method="POST" enctype="multipart/form-data">
                    <c:if test="${not empty project}">
                        <input type="hidden" name="id" value="${project.id}">
                    </c:if>
                    
                    <div class="form-group">
                        <label for="title">Project Title *</label>
                        <input type="text" id="title" name="title" class="form-control" 
                               value="${project.title}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Project Description *</label>
                        <textarea id="description" name="description" class="form-control" 
                                  rows="5" required>${project.description}</textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="tech_stack">Technologies * (comma-separated)</label>
                            <input type="text" id="tech_stack" name="tech_stack" class="form-control" 
                                   value="${project.techStack}" required placeholder="Java, Spring Boot, React, MySQL">
                        </div>
                        
                        <div class="form-group">
                            <label for="image_url">Image URL</label>
                            <input type="text" id="image_url" name="image_url" class="form-control" 
                                   value="${project.imageUrl}" placeholder="https://example.com/image.jpg">
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="project_link">Project Link</label>
                            <input type="url" id="project_link" name="project_link" class="form-control" 
                                   value="${project.projectLink}" placeholder="https://example.com">
                        </div>
                        
                        <div class="form-group">
                            <label for="github_link">GitHub Link</label>
                            <input type="url" id="github_link" name="github_link" class="form-control" 
                                   value="${project.githubLink}" placeholder="https://github.com/username/repo">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="image_upload">Upload Image (optional)</label>
                        <input type="file" id="image_upload" name="image_upload" 
                               accept="image/*" class="form-control">
                        <div class="image-preview" style="margin-top: 10px;">
                            <c:if test="${not empty project.imageUrl}">
                                <img src="${project.imageUrl}" alt="Current image" style="max-width: 200px; max-height: 150px;">
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <c:choose>
                                <c:when test="${not empty project}">Update Project</c:when>
                                <c:otherwise>Create Project</c:otherwise>
                            </c:choose>
                        </button>
                        <a href="manage_projects.jsp" class="btn btn-outline">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="../assets/js/admin.js"></script>
</body>
</html>