<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rohit Gawande | Portfolio</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        <%@ include file="assets/css/style.css" %>
    </style>
</head>
<body>
    <jsp:include page="includes/header.jsp" />
    
    <section class="hero" id="home">
        <div class="container">
            <div class="hero-content">
                <h1>Hi, I'm <span>Rohit Gawande</span></h1>
                <p>I'm a <span class="typed-text">Full Stack Developer</span> passionate about creating innovative web solutions</p>
                <div class="hero-btns">
                    <a href="#projects" class="btn">View My Work</a>
                    <a href="#contact" class="btn btn-outline">Get In Touch</a>
                </div>
            </div>
        </div>
    </section>

    <section class="section about" id="about">
        <div class="container">
            <h2 class="section-title">About Me</h2>
            <div class="about-content">
                <div class="about-image">
                    <img src="assets/images/profile.jpg" alt="Rohit Gawande">
                </div>
                <div class="about-text">
                    <h3>Full Stack Developer & UI/UX Enthusiast</h3>
                    <p>Hello! I'm Rohit Gawande, a passionate full stack developer with expertise in Java, JavaScript, and modern web frameworks. I enjoy creating seamless, user-friendly web applications that solve real-world problems.</p>
                    <p>With a strong foundation in both front-end and back-end development, I bring ideas to life with clean, efficient code and intuitive user interfaces.</p>
                    <div class="skills">
                        <span class="skill">Java</span>
                        <span class="skill">JavaScript</span>
                        <span class="skill">Spring Boot</span>
                        <span class="skill">React</span>
                        <span class="skill">Node.js</span>
                        <span class="skill">MySQL</span>
                        <span class="skill">HTML/CSS</span>
                        <span class="skill">Git</span>
                    </div>
                    <a href="resume.jsp" class="btn" style="margin-top: 20px;">View Resume</a>
                </div>
            </div>
        </div>
    </section>

    <section class="section projects" id="projects">
        <div class="container">
            <h2 class="section-title">Featured Projects</h2>
            <div class="projects-grid">
                <c:forEach var="project" items="${featuredProjects}">
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
                                <a href="${project.projectLink}" target="_blank"><i class="fas fa-external-link-alt"></i> Live Demo</a>
                                <a href="${project.githubLink}" target="_blank"><i class="fab fa-github"></i> GitHub</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div style="text-align: center; margin-top: 40px;">
                <a href="projects.jsp" class="btn">View All Projects</a>
            </div>
        </div>
    </section>

    <section class="section contact" id="contact">
        <div class="container">
            <h2 class="section-title">Get In Touch</h2>
            <div class="contact-container">
                <div class="contact-info">
                    <h3>Let's Talk About Your Project</h3>
                    <p>I'm currently available for freelance work and open to new opportunities. Feel free to reach out if you have any questions or if you'd like to collaborate on a project.</p>
                    <div class="contact-details">
                        <div class="contact-detail">
                            <div class="contact-icon">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="contact-text">
                                <h4>Email</h4>
                                <p>rohit.gawande@example.com</p>
                            </div>
                        </div>
                        <div class="contact-detail">
                            <div class="contact-icon">
                                <i class="fas fa-phone"></i>
                            </div>
                            <div class="contact-text">
                                <h4>Phone</h4>
                                <p>+1 (123) 456-7890</p>
                            </div>
                        </div>
                        <div class="contact-detail">
                            <div class="contact-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            <div class="contact-text">
                                <h4>Location</h4>
                                <p>Mumbai, India</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="contact-form">
                    <h3>Send Me a Message</h3>
                    <form action="contact" method="POST">
                        <div class="form-group">
                            <label for="name">Your Name</label>
                            <input type="text" id="name" name="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Your Email</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <input type="text" id="subject" name="subject" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="message">Your Message</label>
                            <textarea id="message" name="message" class="form-control" required></textarea>
                        </div>
                        <button type="submit" class="btn">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="includes/footer.jsp" />
    
    <script>
        <%@ include file="assets/js/script.js" %>
    </script>
</body>
</html>