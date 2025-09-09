<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer>
    <div class="container">
        <div class="footer-content">
            <p>&copy; <%= java.time.Year.now() %> Rohit Gawande. All Rights Reserved.</p>
            
            <ul class="social-links">
                <li><a href="https://github.com/yourusername" target="_blank"><i class="fab fa-github"></i></a></li>
                <li><a href="https://linkedin.com/in/yourusername" target="_blank"><i class="fab fa-linkedin"></i></a></li>
                <li><a href="https://twitter.com/yourusername" target="_blank"><i class="fab fa-twitter"></i></a></li>
                <li><a href="mailto:rohit.gawande@example.com"><i class="fas fa-envelope"></i></a></li>
            </ul>
        </div>
    </div>
</footer>

<style>
footer {
    background: #111;
    color: #fff;
    padding: 20px 0;
    text-align: center;
}
footer .footer-content {
    display: flex;
    flex-direction: column;
    align-items: center;
}
footer .footer-content p {
    margin-bottom: 10px;
    font-size: 14px;
}
footer .social-links {
    list-style: none;
    display: flex;
    gap: 15px;
}
footer .social-links li a {
    color: #fff;
    font-size: 18px;
    transition: 0.3s;
}
footer .social-links li a:hover {
    color: #f39c12;
}
</style>
