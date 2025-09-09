package com.rohitgawande.model;

import java.time.LocalDateTime;

public class Project {
    private int id;
    private String title;
    private String description;
    private String techStack;
    private String imageUrl;
    private String projectLink;
    private String githubLink;
    private LocalDateTime createdAt; 

    // Constructors
    public Project() {}

    public Project(String title, String description, String techStack, String imageUrl, String projectLink, String githubLink) {
        this.title = title;
        this.description = description;
        this.techStack = techStack;
        this.imageUrl = imageUrl;
        this.projectLink = projectLink;
        this.githubLink = githubLink;
        this.createdAt = LocalDateTime.now(); // ✅ Use current time
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getTechStack() { return techStack; }
    public void setTechStack(String techStack) { this.techStack = techStack; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getProjectLink() { return projectLink; }
    public void setProjectLink(String projectLink) { this.projectLink = projectLink; }

    public String getGithubLink() { return githubLink; }
    public void setGithubLink(String githubLink) { this.githubLink = githubLink; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
