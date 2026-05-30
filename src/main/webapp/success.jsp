<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.registration.servlet.RegisterServlet.Student" %>
<%
    Student student = (Student) request.getAttribute("student");
%>
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

    <!-- Navigation Header -->
    <nav class="nav-header">
        <a href="${pageContext.request.contextPath}/registration.jsp" class="nav-brand">Student Portal</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/registration.jsp" class="nav-link">Register Student</a>
            <a href="${pageContext.request.contextPath}/register" class="nav-link">View Directory</a>
            <% if (session.getAttribute("isAdmin") != null) { %>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color: #ef4444;">Logout</a>
            <% } %>
        </div>
    </nav>

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

            <!-- College Student ID Card Preview -->
            <div style="margin-top: 40px; border-top: 1px solid rgba(255, 255, 255, 0.1); padding-top: 30px;">
                <h3 style="color: var(--text-primary); font-size: 1.1rem; margin-bottom: 20px; text-transform: uppercase; letter-spacing: 1px; text-align: center;">Generated College ID Card</h3>
                <div class="id-card-wrapper">
                    <div class="id-card">
                        <div class="id-card-header">
                            <h2>Dayananda Sagar College of Engineering</h2>
                            <p>Student Identity Card</p>
                        </div>
                        <div class="id-card-main">
                            <div class="id-card-left">
                                <div class="id-card-photo-frame">
                                    <% if (student != null && student.getPhoto() != null && !student.getPhoto().isEmpty()) { %>
                                        <img src="<%= student.getPhoto() %>" class="id-card-photo" alt="Student Photo" style="cursor: zoom-in;" onclick="openLightbox(this.src)">
                                    <% } else { %>
                                        <div class="id-card-photo-placeholder">
                                            <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                                <circle cx="12" cy="7" r="4"></circle>
                                            </svg>
                                        </div>
                                    <% } %>
                                </div>
                                <div class="id-card-sign" style="margin-top: 8px; text-align: center;">Student Image</div>
                            </div>
                            <div class="id-card-right">
                                <div class="id-card-name"><%= student != null ? student.getName() : "Guest Student" %></div>
                                <div class="id-card-title">Student</div>
                                
                                <div class="id-card-details">
                                    <div class="id-card-row">
                                        <span class="id-card-label">ID Number</span>
                                        <span class="id-card-value" style="color: var(--accent-hover);"><%= student != null ? student.getStudentId() : "STU-XXXXXX" %></span>
                                    </div>
                                    <div class="id-card-row">
                                        <span class="id-card-label">Course</span>
                                        <span class="id-card-value"><%= student != null ? student.getCourse() : "Computer Science" %></span>
                                    </div>
                                    <div class="id-card-row">
                                        <span class="id-card-label">Batch</span>
                                        <span class="id-card-value"><%= student != null ? student.getBatch() : "2024 - 2028" %></span>
                                    </div>
                                    <div class="id-card-row">
                                        <span class="id-card-label">Blood Group</span>
                                        <span class="id-card-value" style="color: #f87171;"><%= student != null ? student.getBloodGroup() : "Not Specified" %></span>
                                    </div>
                                    <div class="id-card-row">
                                        <span class="id-card-label">Phone</span>
                                        <span class="id-card-value"><%= student != null ? student.getPhone() : "+1234567890" %></span>
                                    </div>
                                </div>
                                
                                <div class="id-card-address-block">
                                    <strong>Address:</strong>
                                    <span class="id-card-address-value"><%= student != null ? student.getAddress() : "Not Provided" %></span>
                                </div>
                                
                                <div class="id-card-footer-landscape">
                                    <div class="id-card-barcode">
                                        <div class="barcode-line w-2"></div>
                                        <div class="barcode-line w-1"></div>
                                        <div class="barcode-line w-3"></div>
                                        <div class="barcode-line w-1"></div>
                                        <div class="barcode-line w-2"></div>
                                        <div class="barcode-line w-4"></div>
                                        <div class="barcode-line w-1"></div>
                                        <div class="barcode-line w-2"></div>
                                        <div class="barcode-line w-1"></div>
                                        <div class="barcode-line w-3"></div>
                                        <div class="barcode-line w-2"></div>
                                    </div>
                                    <span style="font-size: 0.5rem; opacity: 0.5;">DSCE - Bangalore</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div style="margin-top: 20px; text-align: center;">
                    <button onclick="window.print()" class="btn-search" style="padding: 10px 24px; display: inline-flex; align-items: center; gap: 8px; justify-content: center; font-size: 0.95rem;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle;">
                            <polyline points="6 9 6 2 18 2 18 9"></polyline>
                            <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                            <rect x="6" y="14" width="12" height="8"></rect>
                        </svg>
                        Print ID Card
                    </button>
                </div>
            </div>

            <div style="margin-top: 25px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap;">
                <a href="${pageContext.request.contextPath}/registration.jsp" class="btn-submit" style="text-decoration: none;">Register Another</a>
                <a href="${pageContext.request.contextPath}/register" class="btn-secondary">View Directory</a>
            </div>
        </div>
    </div>

    <script>
        function openLightbox(src) {
            if (src && src.trim().length > 0) {
                document.getElementById("lightboxImg").src = src;
                document.getElementById("photoLightbox").style.display = "flex";
            }
        }
        function closeLightbox() {
            document.getElementById("photoLightbox").style.display = "none";
        }
    </script>

    <!-- Lightbox Modal for Full Resolution Photo -->
    <div id="photoLightbox" class="modal-overlay" style="display: none; z-index: 1100;" onclick="closeLightbox()">
        <div style="position: relative; max-width: 90%; max-height: 90%; display: flex; justify-content: center; align-items: center;" onclick="event.stopPropagation()">
            <span style="position: absolute; top: -40px; right: 0; color: #fff; font-size: 35px; cursor: pointer; font-weight: bold;" onclick="closeLightbox()">&times;</span>
            <img id="lightboxImg" src="" style="max-width: 100%; max-height: 80vh; border-radius: 8px; box-shadow: 0 10px 30px rgba(0,0,0,0.8); border: 2px solid rgba(255,255,255,0.2); object-fit: contain;">
        </div>
    </div>
</body>
</html>
