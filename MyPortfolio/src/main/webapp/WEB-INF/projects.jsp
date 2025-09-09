<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rohitgawande.dao.ProjectDAO" %>
<%@ page import="com.rohitgawande.model.Project" %>
<%@ include file="/MyPortfolio/src/main/webapp/includes/header.jsp" %>

<section class="projects-section">
    <div class="container">
        <h1>My Projects</h1>

        <div class="projects-grid">
            <%
                ProjectDAO projectDAO = new ProjectDAO();
                List<Project> projects = projectDAO.getAllProjects();

                for (Project project : projects) {
            %>
                <div class="project-card">
                    <img src="assets/images/<%= project.getImageUrl() %>" alt="<%= project.getTitle() %>">
                    <h3><%= project.getTitle() %></h3>
                    <p><%= project.getDescription() %></p>
                    <p><strong>Tech Stack:</strong> <%= project.getTechStack() %></p>
                    <div class="project-links">
                        <% if(project.getProjectLink() != null && !project.getProjectLink().isEmpty()) { %>
                            <a href="<%= project.getProjectLink() %>" target="_blank">Live Demo</a>
                        <% } %>
                        <% if(project.getGithubLink() != null && !project.getGithubLink().isEmpty()) { %>
                            <a href="<%= project.getGithubLink() %>" target="_blank">GitHub</a>
                        <% } %>
                    </div>
                </div>
            <%
                }
            %>
        </div>
    </div>
</section>

<%@ include file="includes/footer.jsp" %>
