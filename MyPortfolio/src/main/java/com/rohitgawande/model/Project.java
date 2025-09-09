package com.rohitgawande.model;

import java.sql.Timestamp;

public class Project {
    private int id;
    private String title;
    private String description;
    private String techStack;
    private String imageUrl;
    private String projectLink;
    private String githubLink;
    private Timestamp createdAt; // changed from Date to Timestamp

    // Constructors
    public Project() {}

    public Project(String title, String description, String techStack, String imageUrl, String projectLink, String githubLink) {
        this.title = title;
        this.description = description;
        this.techStack = techStack;
        this.imageUrl = imageUrl;
        this.projectLink = projectLink;
        this.githubLink = githubLink;
        this.createdAt = new Timestamp(System.currentTimeMillis());
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

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
