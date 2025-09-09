<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Check if user is admin (logged in)
    boolean isAdmin = session != null && session.getAttribute("admin") != null;
%>
<header>
    <div class="container">
        <nav>
            <div class="logo">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    Rohit<span>Gawande</span>
                </a>
            </div>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/index.jsp#home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp#about">About</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp#projects">Projects</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp#contact">Contact</a></li>
                <% if (isAdmin) { %>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/logout">Logout</a></li>
                <% } else { %>
                    <li><a href="${pageContext.request.contextPath}/admin/login.jsp">Admin</a></li>
                <% } %>
            </ul>
            <div class="menu-btn">
                <i class="fas fa-bars"></i>
            </div>
        </nav>
    </div>
</header>
