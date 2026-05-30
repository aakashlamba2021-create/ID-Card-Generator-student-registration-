<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Background glowing decorative blobs -->
    <div class="blur-blob blob-1"></div>
    <div class="blur-blob blob-2"></div>

    <div class="container">
        <div class="card alert-card">
            
            <!-- Success Animated/Styled Icon -->
            <div class="icon-wrapper icon-success">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>

            <h1 class="status-title">Registration Successful!</h1>
            <p class="status-text">The student record has been successfully validated and stored in the database.</p>

            <!-- Display registered student details dynamically from Request Scope -->
            <div class="details-table-wrapper">
                <table class="details-table">
                    <tr>
                        <th>Student ID</th>
                        <td>${student.studentId}</td>
                    </tr>
                    <tr>
                        <th>Full Name</th>
                        <td>${student.name}</td>
                    </tr>
                    <tr>
                        <th>Email Address</th>
                        <td>${student.email}</td>
                    </tr>
                    <tr>
                        <th>Phone Number</th>
                        <td>${student.phone}</td>
                    </tr>
                    <tr>
                        <th>Gender</th>
                        <td>${student.gender}</td>
                    </tr>
                    <tr>
                        <th>Date of Birth</th>
                        <td>${student.dob}</td>
                    </tr>
                    <tr>
                        <th>Course</th>
                        <td>${student.course}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${student.address}</td>
                    </tr>
                </table>
            </div>

            <a href="${pageContext.request.contextPath}/registration.jsp" class="btn-secondary">Register Another Student</a>
        </div>
    </div>

</body>
</html>
