package com.rohitgawande.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.rohitgawande.dao.MessageDAO;
import com.rohitgawande.model.Message;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageDAO messageDAO;

    public void init() {
        messageDAO = new MessageDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String messageContent = request.getParameter("message");
        
        Message message = new Message(name, email, subject, messageContent);
        
        try {
            boolean isSaved = messageDAO.saveMessage(message);
            if (isSaved) {
                request.setAttribute("successMessage", "Your message has been sent successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to send message. Please try again.");
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error. Please try again later.");
        }
        
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}