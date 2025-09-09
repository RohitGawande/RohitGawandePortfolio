package com.rohitgawande.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.rohitgawande.dao.MessageDAO;
import com.rohitgawande.dao.ProjectDAO;
import com.rohitgawande.model.Admin;
import com.rohitgawande.model.Message;
import com.rohitgawande.model.Project;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProjectDAO projectDAO;
    private MessageDAO messageDAO;

    public void init() {
        projectDAO = new ProjectDAO();
        messageDAO = new MessageDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get stats for dashboard
            List<Project> projects = projectDAO.getAllProjects();
            List<Message> messages = messageDAO.getAllMessages();
            
            long unreadMessages = messages.stream().filter(m -> !m.getIsRead()).count();
            
            request.setAttribute("totalProjects", projects.size());
            request.setAttribute("totalMessages", messages.size());
            request.setAttribute("unreadMessages", unreadMessages);
            request.setAttribute("recentMessages", 
                messages.size() > 5 ? messages.subList(0, 5) : messages);
            
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error. Please try again later.");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }
}