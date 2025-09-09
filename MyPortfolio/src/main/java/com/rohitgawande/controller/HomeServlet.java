package com.rohitgawande.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.rohitgawande.dao.ProjectDAO;
import com.rohitgawande.model.Project;

@WebServlet("/")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProjectDAO projectDAO;

    public void init() {
        projectDAO = new ProjectDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/":
                    showHomePage(request, response);
                    break;
                case "/projects":
                    showProjectsPage(request, response);
                    break;
                case "/about":
                    showAboutPage(request, response);
                    break;
                case "/contact":
                    showContactPage(request, response);
                    break;
                case "/resume":
                    showResumePage(request, response);
                    break;
                default:
                    showHomePage(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void showHomePage(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        // Get featured projects for the home page
        List<Project> featuredProjects = projectDAO.getAllProjects();
        if (featuredProjects.size() > 3) {
            featuredProjects = featuredProjects.subList(0, 3);
        }
        
        request.setAttribute("featuredProjects", featuredProjects);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    private void showProjectsPage(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        List<Project> allProjects = projectDAO.getAllProjects();
        request.setAttribute("projects", allProjects);
        RequestDispatcher dispatcher = request.getRequestDispatcher("projects.jsp");
        dispatcher.forward(request, response);
    }

    private void showAboutPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("about.jsp");
        dispatcher.forward(request, response);
    }

    private void showContactPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("contact.jsp");
        dispatcher.forward(request, response);
    }

    private void showResumePage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("resume.jsp");
        dispatcher.forward(request, response);
    }
}