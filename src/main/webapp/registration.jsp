<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration System</title>
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
            <a href="${pageContext.request.contextPath}/registration.jsp" class="nav-link active">Register Student</a>
            <a href="${pageContext.request.contextPath}/register" class="nav-link">View Directory</a>
            <% if (session.getAttribute("isAdmin") != null) { %>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color: #ef4444;">Logout</a>
            <% } %>
        </div>
    </nav>

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1>Student Registration</h1>
                <p>Please fill out the form below to register a new student.</p>
            </div>

            <!-- HTML Form submitting data to RegisterServlet mapped at '/register' via POST -->
            <form action="${pageContext.request.contextPath}/register" method="POST" class="registration-form" enctype="multipart/form-data" onsubmit="return validateForm()">
                
                <div class="form-grid">
                    
                    <!-- Student ID Field -->
                    <div class="form-group">
                        <label for="studentId" class="form-label">Student ID</label>
                        <input type="text" id="studentId" name="studentId" class="form-control" 
                               placeholder="e.g., STU12345 (Auto-generated if empty)">
                        <span id="studentId-error" class="error-msg"></span>
                    </div>

                    <!-- Full Name Field -->
                    <div class="form-group">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" id="name" name="name" class="form-control" 
                               placeholder="e.g., John Doe (Guest if empty)">
                        <span id="name-error" class="error-msg"></span>
                    </div>

                    <!-- Email Address Field -->
                    <div class="form-group">
                        <label for="email" class="form-label">Email Address (Optional)</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               placeholder="e.g., john.doe@example.com (Optional)">
                        <span id="email-error" class="error-msg"></span>
                    </div>

                    <!-- Phone Number Field -->
                    <div class="form-group">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               placeholder="e.g., 9876543210 (Default if empty)">
                        <span id="phone-error" class="error-msg"></span>
                    </div>

                    <!-- Admission Year Field -->
                    <div class="form-group">
                        <label for="admissionYear" class="form-label">Admission Year</label>
                        <input type="number" id="admissionYear" name="admissionYear" class="form-control" 
                               placeholder="e.g., 2024 (Default is 2024)">
                        <span id="admissionYear-error" class="error-msg"></span>
                    </div>

                    <!-- Blood Group Field -->
                    <div class="form-group">
                        <label for="bloodGroup" class="form-label">Blood Group</label>
                        <select id="bloodGroup" name="bloodGroup" class="form-control">
                            <option value="" selected>-- Select Blood Group --</option>
                            <option value="A+">A+</option>
                            <option value="A-">A-</option>
                            <option value="B+">B+</option>
                            <option value="B-">B-</option>
                            <option value="AB+">AB+</option>
                            <option value="AB-">AB-</option>
                            <option value="O+">O+</option>
                            <option value="O-">O-</option>
                        </select>
                        <span id="bloodGroup-error" class="error-msg"></span>
                    </div>

                    <!-- Gender Selection -->
                    <div class="form-group">
                        <label class="form-label">Gender</label>
                        <div class="radio-group">
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Male">
                                <span>Male</span>
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Female">
                                <span>Female</span>
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Other">
                                <span>Other</span>
                            </label>
                        </div>
                        <span id="gender-error" class="error-msg"></span>
                    </div>

                    <!-- Date of Birth Field -->
                    <div class="form-group">
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" id="dob" name="dob" class="form-control">
                        <span id="dob-error" class="error-msg"></span>
                    </div>

                    <!-- Course Selection Dropdown -->
                    <div class="form-group full-width">
                        <label for="course" class="form-label">Course Enrolled</label>
                        <select id="course" name="course" class="form-control">
                            <option value="" selected>-- Select a Course --</option>
                            <option value="Computer Science">B.Sc. Computer Science</option>
                            <option value="Information Technology">B.Tech. Information Technology</option>
                            <option value="Electronics Engineering">B.E. Electronics Engineering</option>
                            <option value="Mechanical Engineering">B.E. Mechanical Engineering</option>
                            <option value="Business Administration">Bachelor of Business Administration (BBA)</option>
                        </select>
                        <span id="course-error" class="error-msg"></span>
                    </div>

                    <!-- Student Photo Field -->
                    <div class="form-group full-width">
                        <label for="photo" class="form-label">Upload Student Photo (Optional)</label>
                        <input type="file" id="photo" name="photo" class="form-control" accept="image/*">
                        <span id="photo-error" class="error-msg"></span>
                    </div>

                    <!-- Home Address Field -->
                    <div class="form-group full-width">
                        <label for="address" class="form-label">Home Address</label>
                        <textarea id="address" name="address" class="form-control" 
                                  placeholder="Enter complete residential address..."></textarea>
                        <span id="address-error" class="error-msg"></span>
                    </div>
                    
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn-submit">Submit Registration</button>
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

            // Validate Student ID (only if entered)
            const studentId = document.getElementById("studentId").value.trim();
            const studentIdErr = document.getElementById("studentId-error");
            if (studentId && !studentId.match(/^[a-zA-Z0-9-]{3,20}$/)) {
                studentIdErr.textContent = "Student ID must be 3-20 alphanumeric characters/hyphens.";
                studentIdErr.style.display = "block";
                isValid = false;
            }

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
