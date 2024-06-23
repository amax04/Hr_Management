<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>

<%
    // Check if the user is logged in
    String id = (String) session.getAttribute("id");
    if (id == null || id.isEmpty()) {
        // If not logged in, redirect to the login page
        response.sendRedirect("login.html");
    }
%>
<html>
<head>
    <title>Employee Details</title>
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

        form {
            max-width: 400px;
            width: 100%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            display: block;
            margin-top: 10px;
            text-align: center;
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            color: #45a049;
        }
    </style>
</head>
<body>

<%
    String employeeId = request.getParameter("employeeId");

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/ems";
        String username = "root";
        String password = "aman";
        connection = DriverManager.getConnection(url, username, password);

        // Create a SQL statement
        statement = connection.createStatement();

        // Execute the SQL query to fetch the employee details
        String sqlQuery = "SELECT * FROM users WHERE employee_id = '" + employeeId + "'";
        resultSet = statement.executeQuery(sqlQuery);

        if (resultSet.next()) {
            String user = resultSet.getString("username");
            String pass = resultSet.getString("password");

            // Display the employee details in a form for editing
%>
            <form action="employeeResetUpdate.jsp" method="POST">
                <h2>Employee Details</h2>
                <input type="hidden" name="employeeId" value="<%= employeeId %>">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= user %>" required><br>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= pass %>" required><br>
                <button type="submit">Update Details</button>
            </form>
<%
        } else {
            // Employee not found
            out.println("<h2>Employee not found</h2>");
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
