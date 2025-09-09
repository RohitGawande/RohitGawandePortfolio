package com.rohitgawande.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.rohitgawande.dao.ProjectDAO;
import com.rohitgawande.model.Project;

@WebServlet("/project")
public class ProjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProjectDAO projectDAO;

    public void init() {
        projectDAO = new ProjectDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String id = request.getParameter("id");
        
        if (id != null) {
            try {
                Project project = projectDAO.getProjectById(Integer.parseInt(id));
                if (project != null) {
                    request.setAttribute("project", project);
                    request.getRequestDispatcher("project-details.jsp").forward(request, response);
                } else {
                    response.sendRedirect("projects");
                }
            } catch (NumberFormatException | SQLException e) {
                response.sendRedirect("projects");
            }
        } else {
            response.sendRedirect("projects");
        }
    }
}