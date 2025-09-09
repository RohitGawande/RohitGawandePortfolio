package com.rohitgawande.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/logout")
public class AdminLogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AdminLogoutServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the current session (don't create a new one if it doesn't exist)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Invalidate the session - this removes all session attributes
            session.invalidate();
            
            // Optional: Add a logout success message as a request attribute
            request.setAttribute("logoutMessage", "You have been successfully logged out.");
        }
        
        // Redirect to login page with a success parameter
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp?logout=success");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Call doGet to handle POST requests the same way as GET requests
        doGet(request, response);
    }
}