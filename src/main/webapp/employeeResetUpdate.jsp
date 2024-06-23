<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Update Employee Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        p {
            text-align: center;
            margin-top: 20px;
        }

        a {
            display: inline-block;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
    String employeeId = request.getParameter("employeeId");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/ems";
        String dbUsername = "root";
        String dbPassword = "aman";
        connection = DriverManager.getConnection(url, dbUsername, dbPassword);

        // Create a SQL statement
        String sqlQuery = "UPDATE users SET username=?, password=? WHERE employee_id=?";
        preparedStatement = connection.prepareStatement(sqlQuery);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);
        preparedStatement.setString(3, employeeId);

        // Execute the update operation
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            // Successful update
%>
            <h2>Employee Details Updated Successfully</h2>
            <p><a href="employee_dashboard.jsp">Back to Search</a></p>
<%
        } else {
            // Update failed
            out.println("<h2>Update failed</h2>");
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
