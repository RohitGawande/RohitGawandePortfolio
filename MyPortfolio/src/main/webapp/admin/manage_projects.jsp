<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<jsp:useBean id="projectDAO" class="com.rohitgawande.dao.ProjectDAO" />
<%
    // Get all projects
    java.util.List<com.rohitgawande.model.Project> projects = projectDAO.getAllProjects();
    request.setAttribute("projects", projects);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Projects - Admin Dashboard</title>
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
                <h1>Manage Projects</h1>
                <div class="header-actions">
                    <a href="project_form.jsp?action=new" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Add New Project
                    </a>
                </div>
            </div>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    Project operation completed successfully!
                </div>
            <% } %>
            
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    Error performing project operation. Please try again.
                </div>
            <% } %>
            
            <c:choose>
                <c:when test="${empty projects}">
                    <div class="no-data">
                        <i class="fas fa-briefcase" style="font-size: 3rem; margin-bottom: 20px;"></i>
                        <h3>No Projects Found</h3>
                        <p>Get started by adding your first project.</p>
                        <a href="project_form.jsp?action=new" class="btn btn-primary">Add New Project</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Technologies</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="project" items="${projects}">
                                <tr>
                                    <td>${project.title}</td>
                                    <td>
                                        <c:forTokens items="${project.techStack}" delims="," var="tech">
                                            <span class="tech-tag">${tech}</span>
                                        </c:forTokens>
                                    </td>
                                    <td>${project.createdAt}</td>
                                    <td>
                                        <div class="table-actions">
                                            <a href="../project?id=${project.id}" class="action-btn btn-view" target="_blank">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="project_form.jsp?action=edit&id=${project.id}" class="action-btn btn-edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <form action="projects/delete" method="POST" style="display: inline;">
                                                <input type="hidden" name="id" value="${project.id}">
                                                <button type="submit" class="action-btn btn-delete" onclick="return confirm('Are you sure you want to delete this project?')">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <script src="../assets/js/admin.js"></script>
</body>
</html>