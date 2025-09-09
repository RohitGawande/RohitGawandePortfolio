package com.rohitgawande.controller;

import java.io.IOException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rohitgawande.dao.AdminDAO;
import com.rohitgawande.model.Admin;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminDAO adminDAO;

    @Override
    public void init() {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect to dashboard if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate admin using DAO (Optional<Admin>)
        Optional<Admin> optionalAdmin = adminDAO.validateAdmin(username, password);

        if (optionalAdmin.isPresent()) {
            Admin admin = optionalAdmin.get();

            // Store admin in session
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        } else {
            // Login failed: show error message
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}
