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

    <div class="container">
        <div class="card">
            <div class="card-header">
                <h1>Student Registration</h1>
                <p>Please fill out the form below to register a new student.</p>
            </div>

            <!-- HTML Form submitting data to RegisterServlet mapped at '/register' via POST -->
            <form action="${pageContext.request.contextPath}/register" method="POST" class="registration-form" onsubmit="return validateForm()">
                
                <div class="form-grid">
                    
                    <!-- Student ID Field -->
                    <div class="form-group">
                        <label for="studentId" class="form-label">Student ID</label>
                        <input type="text" id="studentId" name="studentId" class="form-control" 
                               placeholder="e.g., STU12345" required 
                               pattern="^[a-zA-Z0-9-]{3,20}$"
                               title="Student ID must be 3-20 alphanumeric characters or hyphens.">
                        <span id="studentId-error" class="error-msg"></span>
                    </div>

                    <!-- Full Name Field -->
                    <div class="form-group">
                        <label for="name" class="form-label">Full Name</label>
                        <input type="text" id="name" name="name" class="form-control" 
                               placeholder="e.g., John Doe" required
                               pattern="^[a-zA-Z\s]{2,100}$"
                               title="Name must contain only alphabets and spaces, between 2 and 100 characters.">
                        <span id="name-error" class="error-msg"></span>
                    </div>

                    <!-- Email Address Field -->
                    <div class="form-group">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" 
                               placeholder="e.g., john.doe@example.com" required
                               title="Please enter a valid email address.">
                        <span id="email-error" class="error-msg"></span>
                    </div>

                    <!-- Phone Number Field -->
                    <div class="form-group">
                        <label for="phone" class="form-label">Phone Number</label>
                        <input type="tel" id="phone" name="phone" class="form-control" 
                               placeholder="e.g., 9876543210" required
                               pattern="^\+?[0-9]{10,15}$"
                               title="Phone number must be between 10 and 15 digits.">
                        <span id="phone-error" class="error-msg"></span>
                    </div>

                    <!-- Gender Selection -->
                    <div class="form-group">
                        <label class="form-label">Gender</label>
                        <div class="radio-group">
                            <label class="radio-option">
                                <input type="radio" name="gender" value="Male" required>
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
                        <input type="date" id="dob" name="dob" class="form-control" required>
                        <span id="dob-error" class="error-msg"></span>
                    </div>

                    <!-- Course Selection Dropdown -->
                    <div class="form-group full-width">
                        <label for="course" class="form-label">Course Enrolled</label>
                        <select id="course" name="course" class="form-control" required>
                            <option value="" disabled selected>-- Select a Course --</option>
                            <option value="Computer Science">B.Sc. Computer Science</option>
                            <option value="Information Technology">B.Tech. Information Technology</option>
                            <option value="Electronics Engineering">B.E. Electronics Engineering</option>
                            <option value="Mechanical Engineering">B.E. Mechanical Engineering</option>
                            <option value="Business Administration">Bachelor of Business Administration (BBA)</option>
                        </select>
                        <span id="course-error" class="error-msg"></span>
                    </div>

                    <!-- Home Address Field -->
                    <div class="form-group full-width">
                        <label for="address" class="form-label">Home Address</label>
                        <textarea id="address" name="address" class="form-control" 
                                  placeholder="Enter complete residential address..." required
                                  minlength="10" title="Address should be at least 10 characters long."></textarea>
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

            // Validate Student ID
            const studentId = document.getElementById("studentId");
            const studentIdErr = document.getElementById("studentId-error");
            if (!studentId.value.trim().match(/^[a-zA-Z0-9-]{3,20}$/)) {
                studentIdErr.textContent = "Student ID must be 3-20 alphanumeric characters/hyphens.";
                studentIdErr.style.display = "block";
                isValid = false;
            }

            // Validate Name
            const name = document.getElementById("name");
            const nameErr = document.getElementById("name-error");
            if (!name.value.trim().match(/^[a-zA-Z\s]{2,100}$/)) {
                nameErr.textContent = "Name must contain only alphabets and spaces (2-100 characters).";
                nameErr.style.display = "block";
                isValid = false;
            }

            // Validate Phone
            const phone = document.getElementById("phone");
            const phoneErr = document.getElementById("phone-error");
            if (!phone.value.trim().match(/^\+?[0-9]{10,15}$/)) {
                phoneErr.textContent = "Phone number must be between 10 and 15 digits.";
                phoneErr.style.display = "block";
                isValid = false;
            }

            // Validate Address length
            const address = document.getElementById("address");
            const addressErr = document.getElementById("address-error");
            if (address.value.trim().length < 10) {
                addressErr.textContent = "Address must be at least 10 characters long.";
                addressErr.style.display = "block";
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
