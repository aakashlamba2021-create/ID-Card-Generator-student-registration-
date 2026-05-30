<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <!-- Background glowing decorative blobs -->
    <div class="blur-blob blob-1"></div>
    <div class="blur-blob blob-2"></div>

    <div class="container">
        <div class="card alert-card">
            
            <!-- Error Animated/Styled Icon -->
            <div class="icon-wrapper icon-error">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="18" y1="6" x2="6" y2="18"></line>
                    <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
            </div>

            <h1 class="status-title" style="color: #f87171;">Registration Failed</h1>
            <p class="status-text">An error occurred while processing the student registration request. Please review the details below.</p>

            <!-- Display error description dynamically from Request Scope -->
            <div class="details-table-wrapper" style="border-color: rgba(239, 68, 68, 0.2); background: rgba(239, 68, 68, 0.05);">
                <div style="padding: 15px; text-align: left; font-size: 0.95rem; line-height: 1.6;">
                    <strong style="color: #ef4444; display: block; margin-bottom: 5px;">Error Details:</strong>
                    <span style="color: var(--text-primary); font-family: monospace; word-break: break-all;">
                        ${not empty errorMessage ? errorMessage : 'An unexpected server-side error occurred. Please try again.'}
                    </span>
                </div>
            </div>

            <a href="javascript:history.back()" class="btn-secondary" style="border-color: var(--text-secondary); margin-right: 15px;">Go Back</a>
            <a href="${pageContext.request.contextPath}/registration.jsp" class="btn-submit" style="text-decoration: none; display: inline-block;">Return to Form</a>
        </div>
    </div>

</body>
</html>
