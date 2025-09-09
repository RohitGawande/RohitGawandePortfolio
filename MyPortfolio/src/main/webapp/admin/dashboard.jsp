<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Rohit Gawande Portfolio</title>
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
                    <li class="nav-item active">
                        <a href="dashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="manage_projects.jsp">
                            <i class="fas fa-briefcase"></i>
                            <span>Manage Projects</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="view_messages.jsp">
                            <i class="fas fa-envelope"></i>
                            <span>Messages</span>
                            <span class="badge">${unreadMessages}</span>
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
                <h1>Dashboard</h1>
                <div class="header-actions">
                    <span>Welcome, ${admin.username}</span>
                </div>
            </div>
            
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${totalProjects}</h3>
                        <p>Total Projects</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${totalMessages}</h3>
                        <p>Total Messages</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-envelope-open"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${unreadMessages}</h3>
                        <p>Unread Messages</p>
                    </div>
                </div>
            </div>
            
            <div class="dashboard-content">
                <div class="recent-messages">
                    <h2>Recent Messages</h2>
                    <c:if test="${empty recentMessages}">
                        <p class="no-data">No messages yet.</p>
                    </c:if>
                    <c:forEach var="message" items="${recentMessages}">
                        <div class="message-item ${message.isRead ? 'read' : 'unread'}">
                            <div class="message-header">
                                <h4>${message.name} &lt;${message.email}&gt;</h4>
                                <span class="message-time">${message.timestamp}</span>
                            </div>
                            <div class="message-subject">${message.subject}</div>
                            <div class="message-preview">${message.message}</div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="quick-actions">
                    <h2>Quick Actions</h2>
                    <div class="action-buttons">
                        <a href="manage_projects.jsp?action=new" class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            Add New Project
                        </a>
                        <a href="view_messages.jsp" class="btn btn-secondary">
                            <i class="fas fa-envelope"></i>
                            View All Messages
                        </a>
                        <a href="settings.jsp" class="btn btn-outline">
                            <i class="fas fa-cog"></i>
                            Settings
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="../assets/js/admin.js"></script>
</body>
</html>