package com.registration.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DatabaseConnection Utility Class
 * Responsible for loading the MySQL JDBC driver and establishing a database connection.
 */
public class DatabaseConnection {

    // Database connection configuration parameters
    // Change "root" and "password" to match your local MySQL configuration.
    // 'allowPublicKeyRetrieval=true' is added for compatibility with MySQL 8.x authentication.
    private static final String URL = "jdbc:mysql://localhost:3306/college_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "4532"; 

    /**
     * Establishes and returns a connection to the MySQL database.
     * 
     * @return Connection object
     * @throws SQLException if a database access error occurs
     * @throws ClassNotFoundException if the JDBC driver class cannot be located
     */
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Step 1: Explicitly load the MySQL Connector/J driver class into memory
        // This is a crucial step in standard Servlet/JSP projects to register the driver.
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Step 2: Establish the connection using the DriverManager and return it
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
