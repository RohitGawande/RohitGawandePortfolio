<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rohitgawande.dao.ProjectDAO" %>
<%@ page import="com.rohitgawande.model.Project" %>
<jsp:include page="/includes/header.jsp" />

<%
    ProjectDAO projectDAO = new ProjectDAO();
    List<Project> projects = projectDAO.getAllProjects();
    request.setAttribute("projects", projects);
%>

<section class="section projects" id="projects">
    <div class="container">
        <h2 class="section-title">My Projects</h2>
        
        <c:choose>
            <c:when test="${empty projects}">
                <div class="no-projects">
                    <h3>No Projects Yet</h3>
                    <p>Check back soon for my latest projects!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="projects-grid">
                    <c:forEach var="project" items="${projects}">
                        <div class="project-card">
                            <div class="project-image">
                                <img src="${project.imageUrl}" alt="${project.title}">
                            </div>
                            <div class="project-info">
                                <h3>${project.title}</h3>
                                <p>${project.description}</p>
                                <div class="project-tech">
                                    <c:forTokens items="${project.techStack}" delims="," var="tech">
                                        <span>${tech}</span>
                                    </c:forTokens>
                                </div>
                                <div class="project-links">
                                    <c:if test="${not empty project.projectLink}">
                                        <a href="${project.projectLink}" target="_blank">
                                            <i class="fas fa-external-link-alt"></i> Live Demo
                                        </a>
                                    </c:if>
                                    <c:if test="${not empty project.githubLink}">
                                        <a href="${project.githubLink}" target="_blank">
                                            <i class="fab fa-github"></i> GitHub
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<jsp:include page="/includes/footer.jsp" />