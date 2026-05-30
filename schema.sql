-- ==========================================
-- Database Schema for Student Registration System
-- Targets: MySQL 8+
-- ==========================================

-- Create the database if it does not already exist
CREATE DATABASE IF NOT EXISTS college_db;

-- Switch to using the college_db database
USE college_db;

-- Create the students table to store registration details
-- All fields are properly typed and validated using constraints where necessary
CREATE TABLE IF NOT EXISTS students (
    student_id VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    dob DATE NOT NULL,
    course VARCHAR(50) NOT NULL,
    address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id)
);
