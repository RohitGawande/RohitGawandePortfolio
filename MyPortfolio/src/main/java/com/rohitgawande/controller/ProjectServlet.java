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

    @Override
    public void init() {
        projectDAO = new ProjectDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null) {
            try {
                int projectId = Integer.parseInt(idParam);
                Project project = projectDAO.getProjectById(projectId);

                if (project != null) {
                    request.setAttribute("project", project);
                    request.getRequestDispatcher("project-details.jsp").forward(request, response);
                } else {
                    // Project not found → redirect to all projects
                    response.sendRedirect("projects.jsp");
                }
            } catch (NumberFormatException e) {
                // If `id` is not a valid number
                response.sendRedirect("projects.jsp");
            } catch (SQLException e) {
                throw new ServletException("Database error while fetching project", e);
            }
        } else {
            // No id provided → go to projects list
            response.sendRedirect("projects.jsp");
        }
    }
}
