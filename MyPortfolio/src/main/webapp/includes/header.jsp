<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rohit Gawande | Portfolio</title>

    <!-- Font Awesome & Google Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <!-- HEADER / NAVIGATION -->
    <header>
        <div class="container">
            <nav class="navbar">
                <a href="${pageContext.request.contextPath}/index.jsp" class="logo">Rohit Gawande</a>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/index.jsp#home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/projects.jsp">Projects</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/login.jsp">Admin</a></li>
                </ul>
            </nav>
        </div>
    </header>
