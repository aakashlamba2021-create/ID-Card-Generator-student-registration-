<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.registration.servlet.RegisterServlet.Student" %>
<%
    // Admin validation check
    if (session.getAttribute("isAdmin") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Student student = (Student) request.getAttribute("student");
    if (student == null) {
        response.sendRedirect(request.getContextPath() + "/register");
        return;
    }
    
    // Parse admission year from batch (e.g. "2024 - 2028" -> "2024")
    String admissionYear = "";
    if (student.getBatch() != null && student.getBatch().contains("-")) {
        admissionYear = student.getBatch().split("-")[0].trim();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - Student Registration System</title>
    <!-- Link to the premium styling sheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Background glowing decorative blobs -->
    <div class="blur-blob blob-1"></div>
    <div class="blur-blob blob-2"></div>

    <!-- Navigation Header -->
    <nav class="nav-header">
        <a href="${pageContext.request.contextPath}/registration.jsp" class="nav-brand">Student Portal</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/registration.jsp" class="nav-link">Register Student</a>
            <a href="${pageContext.request.contextPath}/register" class="nav-link active">View Directory</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color: #ef4444;">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-header" style="text-align: left;">
                <h1>Edit Student Record</h1>
                <p>Modify and save details for student: <strong style="color: var(--accent-hover);"><%= student.getName() %> (<%= student.getStudentId() %>)</strong></p>
            </div>

            <!-- HTML Form submitting data to RegisterServlet mapped at '/register?action=update' via POST -->
            <form action="${pageContext.request.contextPath}/register?action=update" method="POST" class="registration-form" enctype="multipart/form-data" onsubmit="return validateForm()">
                
                <!-- Hidden input to submit the student ID since the text input is disabled -->
                <input type="hidden" name="studentId" value="<%= student.getStudentId() %>">

                <div class="form-grid">
                    
                    <!-- Student ID Field (Read-only) -->
                    <div class="form-group">
                        <label for="studentIdDisabled" class="form-label">Student ID</label>
                        <input type="text" id="studentIdDisabled" class="form-control" 
                               value="<%= student.getStudentId() %>" disabled style="opacity: 0.6; cursor: not-allowed; background: rgba(15, 23, 42, 0.4);">
                    </div>

                    <!-- Full Name Field -->
                    <div class="form-group">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" id="name" name="name" class="form-control" 
                               placeholder="e.g., John Doe" value="<%= student.getName() %>">
                        <span id="name-error" class="error-msg"></span>
                    </div>

                    <!-- Email Address Field -->
                    <div class="form-group">
                        <label for="email" class="form-label">Email Address (Optional)</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               placeholder="e.g., john.doe@example.com" value="<%= student.getEmail() %>">
                        <span id="email-error" class="error-msg"></span>
                    </div>

                    <!-- Phone Number Field -->
                    <div class="form-group">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               placeholder="e.g., 9876543210" value="<%= student.getPhone() %>">
                        <span id="phone-error" class="error-msg"></span>
                    </div>

                    <!-- Admission Year Field -->
                    <div class="form-group">
                        <label for="admissionYear" class="form-label">Admission Year</label>
                        <input type="number" id="admissionYear" name="admissionYear" class="form-control" 
                               placeholder="e.g., 2024" value="<%= admissionYear %>">
                        <span id="admissionYear-error" class="error-msg"></span>
                    </div>

                    <!-- Blood Group Field -->
                    <div class="form-group">
                        <label for="bloodGroup" class="form-label">Blood Group</label>
                        <select id="bloodGroup" name="bloodGroup" class="form-control">
                            <option value="">-- Select Blood Group --</option>
                            <option value="A+" <%= "A+".equals(student.getBloodGroup()) ? "selected" : "" %>>A+</option>
                            <option value="A-" <%= "A-".equals(student.getBloodGroup()) ? "selected" : "" %>>A-</option>
                            <option value="B+" <%= "B+".equals(student.getBloodGroup()) ? "selected" : "" %>>B+</option>
                            <option value="B-" <%= "B-".equals(student.getBloodGroup()) ? "selected" : "" %>>B-</option>
                            <option value="AB+" <%= "AB+".equals(student.getBloodGroup()) ? "selected" : "" %>>AB+</option>
                            <option value="AB-" <%= "AB-".equals(student.getBloodGroup()) ? "selected" : "" %>>AB-</option>
                            <option value="O+" <%= "O+".equals(student.getBloodGroup()) ? "selected" : "" %>>O+</option>
                            <option value="O-" <%= "O-".equals(student.getBloodGroup()) ? "selected" : "" %>>O-</option>
                        </select>
                        <span id="bloodGroup-error" class="error-msg"></span>
                    </div>

                    <!-- Gender Selection -->
                    <div class="form-group">
                        <label class="form-label">Gender</label>
                        <div class="radio-group">
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Male" <%= "Male".equalsIgnoreCase(student.getGender()) ? "checked" : "" %>>
                                <span>Male</span>
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Female" <%= "Female".equalsIgnoreCase(student.getGender()) ? "checked" : "" %>>
                                <span>Female</span>
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Other" <%= !"Male".equalsIgnoreCase(student.getGender()) && !"Female".equalsIgnoreCase(student.getGender()) ? "checked" : "" %>>
                                <span>Other</span>
                            </label>
                        </div>
                        <span id="gender-error" class="error-msg"></span>
                    </div>

                    <!-- Date of Birth Field -->
                    <div class="form-group">
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" id="dob" name="dob" class="form-control" value="<%= student.getDob() %>">
                        <span id="dob-error" class="error-msg"></span>
                    </div>

                    <!-- Course Selection Dropdown -->
                    <div class="form-group full-width">
                        <label for="course" class="form-label">Course Enrolled</label>
                        <select id="course" name="course" class="form-control">
                            <option value="">-- Select a Course --</option>
                            <option value="Computer Science" <%= "Computer Science".equals(student.getCourse()) ? "selected" : "" %>>B.Sc. Computer Science</option>
                            <option value="Information Technology" <%= "Information Technology".equals(student.getCourse()) ? "selected" : "" %>>B.Tech. Information Technology</option>
                            <option value="Electronics Engineering" <%= "Electronics Engineering".equals(student.getCourse()) ? "selected" : "" %>>B.E. Electronics Engineering</option>
                            <option value="Mechanical Engineering" <%= "Mechanical Engineering".equals(student.getCourse()) ? "selected" : "" %>>B.E. Mechanical Engineering</option>
                            <option value="Business Administration" <%= "Business Administration".equals(student.getCourse()) ? "selected" : "" %>>Bachelor of Business Administration (BBA)</option>
                        </select>
                        <span id="course-error" class="error-msg"></span>
                    </div>

                    <!-- Student Photo Field -->
                    <div class="form-group full-width">
                        <label for="photo" class="form-label">Upload New Photo (Optional - Keeps current photo if left empty)</label>
                        <div style="display: flex; gap: 15px; align-items: center; margin-bottom: 10px;">
                            <div class="id-card-photo-frame" style="width: 60px; height: 60px; border-width: 2px; margin-bottom: 0; box-shadow: none;">
                                <% if (student.getPhoto() != null && !student.getPhoto().isEmpty()) { %>
                                    <img src="<%= student.getPhoto() %>" class="id-card-photo" alt="Current Photo">
                                <% } else { %>
                                    <div class="id-card-photo-placeholder" style="background: rgba(255,255,255,0.05);">
                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                            <circle cx="12" cy="7" r="4"></circle>
                                        </svg>
                                    </div>
                                <% } %>
                            </div>
                            <span style="font-size: 0.85rem; color: var(--text-secondary);">Current Avatar</span>
                        </div>
                        <input type="file" id="photo" name="photo" class="form-control" accept="image/*">
                        <span id="photo-error" class="error-msg"></span>
                    </div>

                    <!-- Home Address Field -->
                    <div class="form-group full-width">
                        <label for="address" class="form-label">Home Address</label>
                        <textarea id="address" name="address" class="form-control" 
                                  placeholder="Enter complete residential address..."><%= student.getAddress() %></textarea>
                        <span id="address-error" class="error-msg"></span>
                    </div>
                    
                </div>

                <!-- Submit and Cancel Buttons -->
                <div style="margin-top: 15px; display: flex; gap: 15px;">
                    <button type="submit" class="btn-submit" style="flex-grow: 1;">Save Updates</button>
                    <a href="${pageContext.request.contextPath}/register" class="btn-secondary" style="text-decoration: none; padding: 14px 28px; text-align: center; font-size: 1rem;">Cancel</a>
                </div>
            </form>
        </div>
    </div>

    <!-- Client-side Validation Logic -->
    <script>
        function validateForm() {
            let isValid = true;
            
            // Clear previous errors
            document.querySelectorAll(".error-msg").forEach(el => {
                el.textContent = "";
                el.style.display = "none";
            });

            // Validate Name (only if entered)
            const name = document.getElementById("name").value.trim();
            const nameErr = document.getElementById("name-error");
            if (name && !name.match(/^[a-zA-Z\s]{2,100}$/)) {
                nameErr.textContent = "Name must contain only alphabets and spaces (2-100 characters).";
                nameErr.style.display = "block";
                isValid = false;
            }

            // Validate Phone (only if entered)
            const phone = document.getElementById("phone").value.trim();
            const phoneErr = document.getElementById("phone-error");
            if (phone && !phone.match(/^\+?[0-9]{10,15}$/)) {
                phoneErr.textContent = "Phone number must be between 10 and 15 digits.";
                phoneErr.style.display = "block";
                isValid = false;
            }

            // Validate Date of Birth (No future dates)
            const dob = document.getElementById("dob");
            const dobErr = document.getElementById("dob-error");
            if (dob.value) {
                const selectedDate = new Date(dob.value);
                const today = new Date();
                if (selectedDate >= today) {
                    dobErr.textContent = "Date of Birth cannot be in the future.";
                    dobErr.style.display = "block";
                    isValid = false;
                }
            }

            return isValid;
        }
    </script>
</body>
</html>
