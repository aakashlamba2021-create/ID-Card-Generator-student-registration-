package com.registration.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Date;

import com.registration.dao.DatabaseConnection;

/**
 * RegisterServlet handles incoming POST requests containing student registration form data.
 * Validates fields server-side and uses JDBC PreparedStatement to save data in MySQL.
 */
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Handles HTTP POST requests.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Step 1: Retrieve form parameters from request
        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String course = request.getParameter("course");
        String address = request.getParameter("address");

        // Trim values to remove trailing/leading whitespace
        if (studentId != null) studentId = studentId.trim();
        if (name != null) name = name.trim();
        if (email != null) email = email.trim();
        if (phone != null) phone = phone.trim();
        if (gender != null) gender = gender.trim();
        if (dobStr != null) dobStr = dobStr.trim();
        if (course != null) course = course.trim();
        if (address != null) address = address.trim();

        // Step 2: Server-Side Validation (Backup validation for security and data integrity)
        String validationError = validateInputs(studentId, name, email, phone, gender, dobStr, course, address);
        
        if (validationError != null) {
            // Forward to error page with the validation error message
            request.setAttribute("errorMessage", validationError);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Step 3: Establish database connection using helper utility
            conn = DatabaseConnection.getConnection();

            // Step 4: SQL Insert Query using placeholders (?) for security
            String sql = "INSERT INTO students (student_id, name, email, phone, gender, dob, course, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, studentId);
            stmt.setString(2, name);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, gender);
            
            // Parse String date (YYYY-MM-DD) into java.sql.Date for the SQL DATE column
            Date dob = Date.valueOf(dobStr);
            stmt.setDate(6, dob);
            
            stmt.setString(7, course);
            stmt.setString(8, address);

            // Step 5: Execute database insertion
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Wrap the student data inside a helper bean object to display in success.jsp
                Student student = new Student(studentId, name, email, phone, gender, dobStr, course, address);
                request.setAttribute("student", student);
                
                // Forward the request to success.jsp
                request.getRequestDispatcher("/success.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration could not be completed. Please try again.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            // Catch specific SQL key duplicates (e.g., Student ID or Email already exists)
            e.printStackTrace();
            String msg = "A student record with this ID or Email already exists in the database.";
            request.setAttribute("errorMessage", msg);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (SQLException e) {
            // Catch general SQL failures (e.g., table not found, database down)
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Connection/Execution Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (ClassNotFoundException e) {
            // Catch missing JDBC driver class error
            e.printStackTrace();
            request.setAttribute("errorMessage", "MySQL JDBC Driver not found in WEB-INF/lib directory. Error details: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } finally {
            // Step 6: Close resources in reverse order of creation to prevent connection leaks
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Validates all form inputs. Returns error message if invalid, or null if all pass.
     */
    private String validateInputs(String studentId, String name, String email, String phone, 
                                  String gender, String dob, String course, String address) {
        
        if (studentId == null || studentId.isEmpty() || !studentId.matches("^[a-zA-Z0-9-]{3,20}$")) {
            return "Invalid Student ID. Must be 3 to 20 alphanumeric characters or hyphens.";
        }
        if (name == null || name.isEmpty() || !name.matches("^[a-zA-Z\\s]{2,100}$")) {
            return "Invalid Name. Should contain only alphabets and spaces, length 2-100.";
        }
        if (email == null || email.isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            return "Invalid Email format. Please provide a valid email address.";
        }
        if (phone == null || phone.isEmpty() || !phone.matches("^\\+?[0-9]{10,15}$")) {
            return "Invalid Phone Number. Must contain between 10 to 15 digits.";
        }
        if (gender == null || gender.isEmpty()) {
            return "Gender selection is required.";
        }
        if (dob == null || dob.isEmpty()) {
            return "Date of Birth is required.";
        }
        try {
            Date.valueOf(dob); // Validate date format
        } catch (IllegalArgumentException e) {
            return "Invalid Date of Birth format. Please use YYYY-MM-DD.";
        }
        if (course == null || course.isEmpty()) {
            return "Course selection is required.";
        }
        if (address == null || address.length() < 10) {
            return "Address must be at least 10 characters long.";
        }
        
        return null; // All validation checks passed
    }

    /**
     * Simple Helper Bean Class to hold student attributes.
     * Makes it easier to read fields inside success.jsp using Expression Language (EL).
     */
    public static class Student {
        private String studentId;
        private String name;
        private String email;
        private String phone;
        private String gender;
        private String dob;
        private String course;
        private String address;

        public Student(String studentId, String name, String email, String phone, 
                       String gender, String dob, String course, String address) {
            this.studentId = studentId;
            this.name = name;
            this.email = email;
            this.phone = phone;
            this.gender = gender;
            this.dob = dob;
            this.course = course;
            this.address = address;
        }

        // Getters are required for JSP Expression Language (EL) to fetch property values
        public String getStudentId() { return studentId; }
        public String getName() { return name; }
        public String getEmail() { return email; }
        public String getPhone() { return phone; }
        public String getGender() { return gender; }
        public String getDob() { return dob; }
        public String getCourse() { return course; }
        public String getAddress() { return address; }
    }
}
