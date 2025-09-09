<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Check if user is logged in
    if (session == null || session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<jsp:useBean id="messageDAO" class="com.rohitgawande.dao.MessageDAO" />
<%
    // Get all messages
    java.util.List<com.rohitgawande.model.Message> messages = messageDAO.getAllMessages();
    request.setAttribute("messages", messages);
    
    // Get unread count
    long unreadCount = messages.stream().filter(m -> !m.getIsRead()).count();
    request.setAttribute("unreadCount", unreadCount);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Messages - Admin Dashboard</title>
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
                    <li class="nav-item">
                        <a href="manage_projects.jsp">
                            <i class="fas fa-briefcase"></i>
                            <span>Manage Projects</span>
                        </a>
                    </li>
                    <li class="nav-item active">
                        <a href="view_messages.jsp">
                            <i class="fas fa-envelope"></i>
                            <span>Messages</span>
                            <c:if test="${unreadCount > 0}">
                                <span class="badge">${unreadCount}</span>
                            </c:if>
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
                <h1>View Messages</h1>
                <div class="header-actions">
                    <span>${unreadCount} unread messages</span>
                </div>
            </div>
            
            <c:choose>
                <c:when test="${empty messages}">
                    <div class="no-data">
                        <i class="fas fa-envelope" style="font-size: 3rem; margin-bottom: 20px;"></i>
                        <h3>No Messages Yet</h3>
                        <p>You haven't received any messages yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="message-filters" style="margin-bottom: 20px;">
                        <button class="btn btn-outline active" data-filter="all">All Messages</button>
                        <button class="btn btn-outline" data-filter="unread">Unread Only</button>
                    </div>
                    
                    <div class="messages-list">
                        <c:forEach var="message" items="${messages}">
                            <div class="message-item ${message.isRead ? 'read' : 'unread'}" data-message-id="${message.id}">
                                <div class="message-header">
                                    <h4>${message.name} &lt;${message.email}&gt;</h4>
                                    <span class="message-time">${message.timestamp}</span>
                                </div>
                                <div class="message-subject">${message.subject}</div>
                                <div class="message-preview">${message.message}</div>
                                <div class="message-actions">
                                    <a href="message_detail.jsp?id=${message.id}" class="btn btn-primary btn-sm">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                    <form action="markAsRead" method="POST" style="display: inline;">
                                        <input type="hidden" name="id" value="${message.id}">
                                        <button type="submit" class="btn btn-secondary btn-sm">
                                            <i class="fas fa-check"></i> Mark as Read
                                        </button>
                                    </form>
                                    <form action="deleteMessage" method="POST" style="display: inline;">
                                        <input type="hidden" name="id" value="${message.id}">
                                        <button type="submit" class="btn btn-danger btn-sm" 
                                                onclick="return confirm('Are you sure you want to delete this message?')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <script src="../assets/js/admin.js"></script>
    <script>
        // Filter messages
        document.querySelectorAll('.message-filters button').forEach(button => {
            button.addEventListener('click', function() {
                const filter = this.dataset.filter;
                
                // Update active state
                document.querySelectorAll('.message-filters button').forEach(btn => {
                    btn.classList.remove('active');
                });
                this.classList.add('active');
                
                // Filter messages
                document.querySelectorAll('.message-item').forEach(item => {
                    if (filter === 'all') {
                        item.style.display = 'block';
                    } else if (filter === 'unread') {
                        if (item.classList.contains('unread')) {
                            item.style.display = 'block';
                        } else {
                            item.style.display = 'none';
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>