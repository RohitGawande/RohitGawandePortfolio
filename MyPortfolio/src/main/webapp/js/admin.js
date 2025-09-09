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
    const deleteButtons = document.querySelectorAll('.btn-delete, .delete-form');
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
    
    // Toggle message read status
    const messageItems = document.querySelectorAll('.message-item');
    messageItems.forEach(item => {
        item.addEventListener('click', function() {
            const messageId = this.dataset.messageId;
            if (messageId && this.classList.contains('unread')) {
                // Mark as read via AJAX
                fetch(`markAsRead?id=${messageId}`)
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            this.classList.remove('unread');
                            this.classList.add('read');
                            
                            // Update unread count
                            const unreadCount = document.querySelector('.badge');
                            if (unreadCount) {
                                const currentCount = parseInt(unreadCount.textContent);
                                unreadCount.textContent = currentCount - 1;
                            }
                        }
                    });
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
        techStackInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ',') {
                e.preventDefault();
                const value = this.value.trim();
                if (value) {
                    const tagsContainer = this.previousElementSibling;
                    const tag = document.createElement('span');
                    tag.className = 'tech-tag';
                    tag.innerHTML = `${value} <span class="remove-tag">&times;</span>`;
                    
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
            const tags = Array.from(document.querySelectorAll('.tech-tag'))
                .map(tag => tag.textContent.replace('×', '').trim());
            techStackInput.value = tags.join(',');
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
    
    // Dashboard charts (if Chart.js is included)
    if (typeof Chart !== 'undefined') {
        initDashboardCharts();
    }
    
    function initDashboardCharts() {
        const ctx = document.getElementById('statsChart');
        if (ctx) {
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Projects', 'Messages', 'Unread'],
                    datasets: [{
                        label: 'Statistics',
                        data: [
                            parseInt(document.querySelector('[data-projects]')?.dataset.projects || 0),
                            parseInt(document.querySelector('[data-messages]')?.dataset.messages || 0),
                            parseInt(document.querySelector('[data-unread]')?.dataset.unread || 0)
                        ],
                        backgroundColor: [
                            'rgba(37, 99, 235, 0.8)',
                            'rgba(59, 130, 246, 0.8)',
                            'rgba(126, 34, 206, 0.8)'
                        ],
                        borderColor: [
                            'rgb(37, 99, 235)',
                            'rgb(59, 130, 246)',
                            'rgb(126, 34, 206)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }
    }
});