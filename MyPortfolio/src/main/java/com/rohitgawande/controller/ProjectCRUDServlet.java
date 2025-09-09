package com.rohitgawande.controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.rohitgawande.dao.ProjectDAO;
import com.rohitgawande.model.Admin;
import com.rohitgawande.model.Project;

@WebServlet("/admin/projects/*")
public class ProjectCRUDServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProjectDAO projectDAO;

    public void init() {
        projectDAO = new ProjectDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        String action = request.getPathInfo();
        
        try {
            if (action == null) {
                listProjects(request, response);
            } else {
                switch (action) {
                    case "/new":
                        showNewForm(request, response);
                        break;
                    case "/edit":
                        showEditForm(request, response);
                        break;
                    case "/delete":
                        deleteProject(request, response);
                        break;
                    default:
                        listProjects(request, response);
                        break;
                }
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("../login.jsp");
            return;
        }
        
        String action = request.getPathInfo();
        
        try {
            if (action != null && action.equals("/insert")) {
                insertProject(request, response);
            } else if (action != null && action.equals("/update")) {
                updateProject(request, response);
            } else {
                listProjects(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listProjects(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        request.setAttribute("projects", projectDAO.getAllProjects());
        request.getRequestDispatcher("/admin/manage_projects.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/project_form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Project existingProject = projectDAO.getProjectById(id);
        request.setAttribute("project", existingProject);
        request.getRequestDispatcher("/admin/project_form.jsp").forward(request, response);
    }

    private void insertProject(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String techStack = request.getParameter("tech_stack");
        String imageUrl = request.getParameter("image_url");
        String projectLink = request.getParameter("project_link");
        String githubLink = request.getParameter("github_link");
        
        Project newProject = new Project(title, description, techStack, imageUrl, projectLink, githubLink);
        projectDAO.addProject(newProject);
        response.sendRedirect("list");
    }

    private void updateProject(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String techStack = request.getParameter("tech_stack");
        String imageUrl = request.getParameter("image_url");
        String projectLink = request.getParameter("project_link");
        String githubLink = request.getParameter("github_link");
        
        Project project = new Project(title, description, techStack, imageUrl, projectLink, githubLink);
        project.setId(id);
        projectDAO.updateProject(project);
        response.sendRedirect("list");
    }

    private void deleteProject(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        projectDAO.deleteProject(id);
        response.sendRedirect("list");
    }
}