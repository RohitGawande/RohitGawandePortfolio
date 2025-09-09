// Admin panel JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Toggle mobile sidebar
    const menuToggle = document.querySelector('.menu-toggle');
    const adminSidebar = document.querySelector('.admin-sidebar');
    
    if (menuToggle && adminSidebar) {
        menuToggle.addEventListener('click', function() {
            adminSidebar.classList.toggle('active');
        });
    }
    
    // Confirm delete actions
    const deleteButtons = document.querySelectorAll('.btn-delete');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to delete this item? This action cannot be undone.')) {
                e.preventDefault();
            }
        });
    });
    
    // Form validation for admin forms
    const adminForms = document.querySelectorAll('.admin-form');
    adminForms.forEach(form => {
        form.addEventListener('submit', function(e) {
            let isValid = true;
            const requiredInputs = this.querySelectorAll('input[required], textarea[required], select[required]');
            
            requiredInputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = '#ef4444';
                    
                    // Add error message
                    if (!input.nextElementSibling || !input.nextElementSibling.classList.contains('error-message')) {
                        const errorMsg = document.createElement('span');
                        errorMsg.className = 'error-message';
                        errorMsg.style.color = '#ef4444';
                        errorMsg.style.fontSize = '0.8rem';
                        errorMsg.style.marginTop = '5px';
                        errorMsg.style.display = 'block';
                        errorMsg.textContent = 'This field is required';
                        input.parentNode.appendChild(errorMsg);
                    }
                } else {
                    input.style.borderColor = '';
                    
                    // Remove error message
                    const errorMsg = input.nextElementSibling;
                    if (errorMsg && errorMsg.classList.contains('error-message')) {
                        errorMsg.remove();
                    }
                }
            });
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    });
    
    // Image preview for project forms
    const imageInput = document.querySelector('input[type="file"][accept="image/*"]');
    const imagePreview = document.querySelector('.image-preview');
    
    if (imageInput && imagePreview) {
        imageInput.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.innerHTML = `<img src="${e.target.result}" alt="Preview" style="max-width: 100%; max-height: 200px;">`;
                };
                reader.readAsDataURL(file);
            }
        });
    }
    
    // Tech stack tags input
    const techStackInput = document.querySelector('input[name="tech_stack"]');
    if (techStackInput) {
        // Create tags container if it doesn't exist
        if (!techStackInput.previousElementSibling || !techStackInput.previousElementSibling.classList.contains('tags-container')) {
            const tagsContainer = document.createElement('div');
            tagsContainer.className = 'tags-container';
            tagsContainer.style.display = 'flex';
            tagsContainer.style.flexWrap = 'wrap';
            tagsContainer.style.gap = '8px';
            tagsContainer.style.marginBottom = '10px';
            techStackInput.parentNode.insertBefore(tagsContainer, techStackInput);
        }
        
        techStackInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ',') {
                e.preventDefault();
                const value = this.value.trim();
                if (value) {
                    const tagsContainer = this.previousElementSibling;
                    const tag = document.createElement('span');
                    tag.className = 'tech-tag';
                    tag.style.background = '#e2e8f0';
                    tag.style.padding = '4px 12px';
                    tag.style.borderRadius = '20px';
                    tag.style.fontSize = '0.9rem';
                    tag.innerHTML = `${value} <span class="remove-tag" style="cursor:pointer; margin-left:5px;">&times;</span>`;
                    
                    const removeBtn = tag.querySelector('.remove-tag');
                    removeBtn.addEventListener('click', function() {
                        tag.remove();
                        updateTechStackValue();
                    });
                    
                    tagsContainer.appendChild(tag);
                    this.value = '';
                    updateTechStackValue();
                }
            }
        });
        
        function updateTechStackValue() {
            const tagsContainer = techStackInput.previousElementSibling;
            const tags = Array.from(tagsContainer.querySelectorAll('.tech-tag'))
                .map(tag => tag.textContent.replace('×', '').trim());
            techStackInput.value = tags.join(',');
        }
        
        // Initialize existing tags if any
        if (techStackInput.value) {
            const tags = techStackInput.value.split(',');
            const tagsContainer = techStackInput.previousElementSibling;
            tags.forEach(tag => {
                if (tag.trim()) {
                    const tagElement = document.createElement('span');
                    tagElement.className = 'tech-tag';
                    tagElement.style.background = '#e2e8f0';
                    tagElement.style.padding = '4px 12px';
                    tagElement.style.borderRadius = '20px';
                    tagElement.style.fontSize = '0.9rem';
                    tagElement.innerHTML = `${tag.trim()} <span class="remove-tag" style="cursor:pointer; margin-left:5px;">&times;</span>`;
                    
                    const removeBtn = tagElement.querySelector('.remove-tag');
                    removeBtn.addEventListener('click', function() {
                        tagElement.remove();
                        updateTechStackValue();
                    });
                    
                    tagsContainer.appendChild(tagElement);
                }
            });
        }
    }
    
    // Auto-resize textareas
    const textareas = document.querySelectorAll('textarea');
    textareas.forEach(textarea => {
        textarea.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });
        
        // Trigger initial resize
        setTimeout(() => {
            textarea.dispatchEvent(new Event('input'));
        }, 100);
    });
});