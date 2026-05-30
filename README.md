# Student Registration System (Java Servlet, JSP, JDBC & MySQL)

This project is a complete, beginner-friendly Dynamic Java Web Application suitable for university practical exams and college assignments. It demonstrates form design, client & server-side validation, database storage using JDBC, and dynamic JSP rendering.

---

## 📁 Complete Project Structure

Here is how the project files are laid out inside the project directory:

```
student-registration/
│
├── schema.sql                   # Database setup queries
├── README.md                    # Setup and deployment manual
│
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── registration/
        │           ├── dao/
        │           │   └── DatabaseConnection.java   # JDBC Connection class
        │           └── servlet/
        │               └── RegisterServlet.java      # Main controller Servlet
        │
        └── webapp/
            ├── css/
            │   └── style.css                         # Custom UI Stylesheet
            ├── WEB-INF/
            │   └── web.xml                           # Tomcat deployment descriptor
            ├── registration.jsp                      # Registration form interface
            ├── success.jsp                           # Registration success response
            └── error.jsp                             # Error handler response
```

---

## 🚀 Setup and Deployment Instructions

Follow these step-by-step instructions to get the application up and running.

### Prerequisites
*   **Java Development Kit (JDK 17 or higher)**
*   **Apache Tomcat (Version 10.x or higher)** - Tomcat 10+ is required due to the `jakarta.servlet` namespace requirement.
*   **MySQL Database (Version 8.x or higher)**
*   **MySQL Connector/J (JDBC Driver)** (e.g., `mysql-connector-j-8.x.x.jar`)

---

### Step 1: Create the Database in MySQL
1.  Open the MySQL Command Line Client, MySQL Workbench, or your preferred SQL editor.
2.  Login to your MySQL database.
3.  Copy and execute the SQL queries from [schema.sql](file:///c:/coding/projects/student%20registration/schema.sql):
    ```sql
    -- Create the database
    CREATE DATABASE IF NOT EXISTS college_db;

    -- Switch to the database
    USE college_db;

    -- Create the table
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
    ```

---

### Step 2: Configure Database Credentials in Java
1.  Open [DatabaseConnection.java](file:///c:/coding/projects/student%20registration/src/main/java/com/registration/dao/DatabaseConnection.java).
2.  Update the database password (and username, if different) to match your local MySQL settings:
    ```java
    private static final String USER = "root";
    private static final String PASSWORD = "password"; // Set your MySQL password here
    ```

---

### Step 3: Compile the Java Source Code
The Java classes must be compiled into standard `.class` files. You can compile them using an IDE (like Eclipse or IntelliJ) or via the command line.

If compiling via the Command Line, run the following commands (ensuring you include Tomcat's servlet API jar and MySQL Connector jar in the compilation classpath):

```powershell
# Create the output directory for class files
mkdir -p src/main/webapp/WEB-INF/classes

# Compile JDBC Connection and Servlet classes
javac -d src/main/webapp/WEB-INF/classes `
      -classpath "C:\path\to\tomcat\lib\servlet-api.jar" `
      src/main/java/com/registration/dao/DatabaseConnection.java `
      src/main/java/com/registration/servlet/RegisterServlet.java
```

---

### Step 4: Add the MySQL JDBC Driver (Connector/J)
For Tomcat to interface with MySQL, the JDBC driver library must be included inside the webapp package:
1.  Download the **MySQL Connector/J JAR** file (e.g. `mysql-connector-j-8.3.0.jar`) from the [MySQL Downloads Portal](https://dev.mysql.com/downloads/connector/j/).
2.  Create a folder named `lib` inside `src/main/webapp/WEB-INF/` (if it does not exist).
3.  Copy and paste the `mysql-connector-j-x.x.x.jar` file into the [WEB-INF/lib](file:///c:/coding/projects/student%20registration/src/main/webapp/WEB-INF/lib) directory.

---

### Step 5: Deploy the Project to Apache Tomcat

To deploy the application to your Tomcat server:
1.  Locate your Tomcat installation folder (e.g., `C:\Program Files\Apache Software Foundation\Tomcat 10.1`).
2.  Navigate to the `webapps/` subdirectory inside Tomcat.
3.  Copy the compiled application root directory (**the contents of the `src/main/webapp` folder**) into a new folder inside `webapps`. 
    Let's name this folder `student-registration`.

Your Tomcat deployment directory structure must look like this:
```
C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\student-registration\
├── registration.jsp
├── success.jsp
├── error.jsp
├── css\
│   └── style.css
└── WEB-INF\
    ├── web.xml
    ├── lib\
    │   └── mysql-connector-j-8.x.x.jar
    └── classes\
        └── com\
            └── registration\
                ├── dao\
                │   └── DatabaseConnection.class
                └── servlet\
                    └── RegisterServlet.class
```

---

### Step 6: Start Tomcat and Run the Project
1.  Start the Apache Tomcat server:
    *   **Option A**: Run `startup.bat` from Tomcat's `bin` folder.
    *   **Option B**: Start the Tomcat service via the Windows Services Manager.
2.  Open your web browser.
3.  Navigate to the following address:
    `http://localhost:8080/student-registration/`
4.  You will be presented with the glowing modern Registration Form. Fill in valid student details, submit, and verify that the data has been stored inside the database.
