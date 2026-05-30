<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.registration.servlet.RegisterServlet.Student" %>
<%
    List<Student> students = (List<Student>) request.getAttribute("students");
    String searchQuery = (String) request.getAttribute("searchQuery");
    if (searchQuery == null) searchQuery = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Directory - Student Registration System</title>
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
            <% if (session.getAttribute("isAdmin") != null) { %>
                <a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color: #ef4444;">Logout</a>
            <% } %>
        </div>
    </nav>

    <div class="container wide">
        <div class="card" style="padding: 30px;">
            <div class="card-header" style="text-align: left; margin-bottom: 25px;">
                <h1 style="margin-bottom: 5px;">Student Directory</h1>
                <p>Database Records (Loaded via JDBC)</p>
            </div>

            <!-- Search and Filter Bar -->
            <div class="search-bar-wrapper" style="display: flex; justify-content: space-between; align-items: center; gap: 15px; flex-wrap: wrap;">
                <form action="${pageContext.request.contextPath}/register" method="GET" class="search-form" style="margin-bottom: 0; flex-grow: 1; max-width: 500px;">
                    <input type="text" name="search" class="search-input" placeholder="Search by name, ID, email or course..." value="<%= searchQuery %>">
                    <button type="submit" class="btn-search">Search</button>
                    <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                        <a href="${pageContext.request.contextPath}/register" class="btn-clear">Clear</a>
                    <% } %>
                </form>
                <a href="${pageContext.request.contextPath}/registration.jsp" class="btn-submit" style="text-decoration: none; margin-top: 0; padding: 10px 20px; font-size: 0.9rem; display: inline-flex; align-items: center; gap: 8px;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                    Register New Student
                </a>
            </div>

            <!-- Students Data Table -->
            <div class="table-container">
                <% 
                    if (students != null && !students.isEmpty()) {
                %>
                <table class="students-table">
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Full Name</th>
                            <th>Email Address</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>D.O.B</th>
                            <th>Course</th>
                            <th style="text-align: center;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            for (Student student : students) {
                                String genderClass = "badge-other";
                                if ("Male".equalsIgnoreCase(student.getGender())) genderClass = "badge-male";
                                else if ("Female".equalsIgnoreCase(student.getGender())) genderClass = "badge-female";
                        %>
                        <tr>
                            <td class="student-id-col"><%= student.getStudentId() %></td>
                            <td class="student-name-col"><%= student.getName() %></td>
                            <td><%= student.getEmail() %></td>
                            <td><%= student.getPhone() %></td>
                            <td><span class="badge <%= genderClass %>"><%= student.getGender() %></span></td>
                            <td style="white-space: nowrap;"><%= student.getDob() %></td>
                            <td><span class="badge badge-course"><%= student.getCourse() %></span></td>
                            <td style="text-align: center; white-space: nowrap;">
                                <button type="button" class="btn-action-preview"
                                         onclick="openPreviewModal('<%= student.getStudentId() %>', '<%= student.getName().replace("'", "\\'") %>', '<%= student.getCourse().replace("'", "\\'") %>', '<%= student.getPhone().replace("'", "\\'") %>', '<%= student.getPhoto() != null ? student.getPhoto() : "" %>', '<%= student.getBloodGroup() != null ? student.getBloodGroup() : "Not Specified" %>', '<%= student.getBatch() != null ? student.getBatch() : "2024 - 2028" %>', '<%= student.getAddress() != null ? student.getAddress().replace("'", "\\'").replace("\n", " ").replace("\r", " ") : "Not Provided" %>')">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 2px; vertical-align: middle;">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                        <circle cx="12" cy="12" r="3"></circle>
                                    </svg>
                                    Preview ID
                                </button>
                                <a href="${pageContext.request.contextPath}/register?action=edit&id=<%= student.getStudentId() %>" 
                                   class="btn-action-preview" style="background: rgba(16, 185, 129, 0.15); color: #34d399; border-color: rgba(16, 185, 129, 0.3); margin-right: 8px;">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 2px; vertical-align: middle;">
                                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                        <path d="M18.5 2.5a2.121 2.121 0 1 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                    </svg>
                                    Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/register?action=delete&id=<%= student.getStudentId() %>" 
                                   class="btn-action-delete"
                                   onclick="return confirm('Are you sure you want to delete student <%= student.getName() %> (<%= student.getStudentId() %>)?');">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 2px; vertical-align: middle;">
                                        <polyline points="3 6 5 6 21 6"></polyline>
                                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                    </svg>
                                    Delete
                                </a>
                            </td>
                        </tr>
                        <% 
                            } 
                        %>
                    </tbody>
                </table>
                <% 
                    } else { 
                %>
                <div class="empty-state">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="margin: 0 auto 15px; display: block;">
                        <circle cx="12" cy="12" r="10"></circle>
                        <line x1="8" y1="12" x2="16" y2="12"></line>
                    </svg>
                    <p>No student records found <%= (!searchQuery.isEmpty()) ? "matching your search query" : "" %>.</p>
                    <% if (!searchQuery.isEmpty()) { %>
                        <a href="${pageContext.request.contextPath}/register" class="btn-secondary">View All Students</a>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/registration.jsp" class="btn-submit" style="text-decoration: none; display: inline-block;">Register First Student</a>
                    <% } %>
                </div>
                <% 
                    } 
                %>
            </div>
        </div>
    </div>

    <!-- Interactive ID Card Preview Modal -->
    <div id="previewModal" class="modal-overlay" onclick="closePreviewModal(event)">
        <div class="modal-container" onclick="event.stopPropagation()">
            <button class="modal-close-btn" onclick="hideModal()">&times;</button>
            <h3 class="modal-title">College ID Preview</h3>
            
            <div class="id-card-wrapper" style="margin-top: 0;">
                <div class="id-card" id="modalIdCard">
                    <div class="id-card-header">
                        <h2>Dayananda Sagar College of Engineering</h2>
                        <p>Student Identity Card</p>
                    </div>
                    <div class="id-card-main">
                        <div class="id-card-left">
                            <div class="id-card-photo-frame">
                                <img id="modalPhoto" src="" class="id-card-photo" alt="Student Photo" style="display: none; cursor: zoom-in;" onclick="openLightbox(this.src)">
                                <div id="modalPhotoPlaceholder" class="id-card-photo-placeholder">
                                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="12" cy="7" r="4"></circle>
                                    </svg>
                                </div>
                            </div>
                            <div class="id-card-sign" style="margin-top: 8px; text-align: center;">Student Image</div>
                        </div>
                        <div class="id-card-right">
                            <div class="id-card-name" id="modalName">Name Placeholder</div>
                            <div class="id-card-title">Student</div>
                            
                            <div class="id-card-details">
                                <div class="id-card-row">
                                    <span class="id-card-label">ID Number</span>
                                    <span class="id-card-value" id="modalId" style="color: var(--accent-hover);">STU-XXXXXX</span>
                                </div>
                                <div class="id-card-row">
                                    <span class="id-card-label">Course</span>
                                    <span class="id-card-value" id="modalCourse">Course Placeholder</span>
                                </div>
                                <div class="id-card-row">
                                    <span class="id-card-label">Batch</span>
                                    <span class="id-card-value" id="modalBatch">2024 - 2028</span>
                                </div>
                                <div class="id-card-row">
                                    <span class="id-card-label">Blood Group</span>
                                    <span class="id-card-value" id="modalBloodGroup" style="color: #f87171;">Not Specified</span>
                                </div>
                                <div class="id-card-row">
                                    <span class="id-card-label">Phone</span>
                                    <span class="id-card-value" id="modalPhone">+1234567890</span>
                                </div>
                            </div>
                            
                            <div class="id-card-address-block">
                                <strong>Address:</strong>
                                <span class="id-card-address-value" id="modalAddress">Not Provided</span>
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
            
            <div style="margin-top: 15px; text-align: center; width: 100%;">
                <button onclick="printModalCard()" class="btn-search" style="padding: 10px 24px; display: inline-flex; align-items: center; gap: 8px; justify-content: center; width: 100%;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align: middle;">
                        <polyline points="6 9 6 2 18 2 18 9"></polyline>
                        <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                        <rect x="6" y="14" width="12" height="8"></rect>
                    </svg>
                    Print ID Card
                </button>
            </div>
        </div>
    </div>

    <!-- Script to handle Modal and Printing -->
    <script>
        function openPreviewModal(id, name, course, phone, photo, bloodGroup, batch, address) {
            document.getElementById("modalId").textContent = id;
            document.getElementById("modalName").textContent = name;
            document.getElementById("modalCourse").textContent = course;
            document.getElementById("modalPhone").textContent = phone;
            document.getElementById("modalBloodGroup").textContent = bloodGroup ? bloodGroup : "Not Specified";
            document.getElementById("modalBatch").textContent = batch ? batch : "2024 - 2028";
            document.getElementById("modalAddress").textContent = address ? address : "Not Provided";
            
            const photoImg = document.getElementById("modalPhoto");
            const photoPlaceholder = document.getElementById("modalPhotoPlaceholder");
            
            if (photo && photo.trim().length > 0) {
                photoImg.src = photo;
                photoImg.style.display = "block";
                photoPlaceholder.style.display = "none";
            } else {
                photoImg.src = "";
                photoImg.style.display = "none";
                photoPlaceholder.style.display = "flex";
            }
            
            document.getElementById("previewModal").style.display = "flex";
        }
        
        function hideModal() {
            document.getElementById("previewModal").style.display = "none";
        }
        
        function closePreviewModal(event) {
            if (event.target === document.getElementById("previewModal")) {
                hideModal();
            }
        }
        
        function printModalCard() {
            const cardHTML = document.getElementById("modalIdCard").outerHTML;
            const styleURL = "${pageContext.request.contextPath}/css/style.css";
            const printWindow = window.open('', '_blank', 'width=600,height=800');
            printWindow.document.write('<html><head><title>Print ID Card</title>');
            printWindow.document.write('<link rel="stylesheet" href="' + styleURL + '">');
            printWindow.document.write('<style>');
            printWindow.document.write('body { background: transparent; padding: 20px; display: flex; justify-content: center; align-items: center; min-height: auto; }');
            printWindow.document.write('.id-card { border: 1px solid #000000 !important; box-shadow: none !important; margin: 0 auto; }');
            printWindow.document.write('.id-card::before { -webkit-print-color-adjust: exact; print-color-adjust: exact; }');
            printWindow.document.write('</style></head><body>');
            printWindow.document.write('<div class="id-card-wrapper">' + cardHTML + '</div>');
            printWindow.document.write('<script>window.onload = function() { setTimeout(function() { window.print(); window.close(); }, 500); };<\/script>');
            printWindow.document.write('</body></html>');
            printWindow.document.close();
        }

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
