<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is admin (logged in)
    boolean isAdmin = session != null && session.getAttribute("admin") != null;
%>
<header>
    <div class="container">
        <nav>
            <div class="logo">Rohit<span>Gawande</span></div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#projects">Projects</a></li>
                <li><a href="#contact">Contact</a></li>
                <% if (isAdmin) { %>
                    <li><a href="admin/dashboard.jsp">Dashboard</a></li>
                    <li><a href="admin/logout">Logout</a></li>
                <% } else { %>
                    <li><a href="admin/login.jsp">Admin</a></li>
                <% } %>
            </ul>
            <div class="menu-btn">
                <i class="fas fa-bars"></i>
            </div>
        </nav>
    </div>
</header>