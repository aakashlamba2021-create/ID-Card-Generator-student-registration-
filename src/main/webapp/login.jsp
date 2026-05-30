<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Student Registration System</title>
    <!-- Link to the premium styling sheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Background glowing decorative blobs -->
    <div class="blur-blob blob-1"></div>
    <div class="blur-blob blob-2"></div>

    <div class="container" style="max-width: 450px;">
        <div class="card" style="padding: 40px 30px;">
            <div class="card-header">
                <h1>Admin Login</h1>
                <p>Enter credentials to access the Student Directory</p>
            </div>

            <!-- Error message if validation fails -->
            <% 
                String error = (String) request.getAttribute("loginError");
                if (error != null) {
            %>
                <div style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); border-radius: var(--radius-md); padding: 12px; margin-bottom: 20px; color: var(--error); text-align: center; font-size: 0.9rem;">
                    <%= error %>
                </div>
            <% 
                } 
            %>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/login" method="POST" class="registration-form">
                <div class="form-group">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Enter username" required autocomplete="username">
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" required autocomplete="current-password">
                </div>

                <button type="submit" class="btn-submit" style="margin-top: 10px;">Login</button>
            </form>
            
            <div style="margin-top: 20px; text-align: center;">
                <a href="${pageContext.request.contextPath}/registration.jsp" class="btn-secondary" style="font-size: 0.9rem; padding: 8px 16px; border-color: transparent;">&larr; Back to Registration</a>
            </div>
        </div>
    </div>

</body>
</html>
