<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/header.jsp" />

<section class="section contact" id="contact">
    <div class="container">
        <h2 class="section-title">Get In Touch</h2>
        
        <%-- Display success/error messages --%>
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <%= request.getAttribute("successMessage") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        
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
                            <p>rohitgawande2004@gmail.com</p>
                        </div>
                    </div>
                    <div class="contact-detail">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div class="contact-text">
                            <h4>Phone</h4>
                            <p>+91 1234567890</p>
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
                        <label for="name">Your Name *</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Your Email *</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject *</label>
                        <input type="text" id="subject" name="subject" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Your Message *</label>
                        <textarea id="message" name="message" class="form-control" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</section>

<jsp:include page="includes/footer.jsp" />