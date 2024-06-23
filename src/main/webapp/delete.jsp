<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Delete Employee</title>
</head>
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
    // ... (Same as before)
%>

</body>
</html>
delete.jsp - Improved styling:
jsp
Copy code
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Delete Employee</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 20px;
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
        }

        a:hover {
            background-color: #45a049;
        }
    </style>
<body>

<%
    String employeeId = request.getParameter("employeeId");

    Connection connection = null;
    PreparedStatement preparedStatement,selectStatement= null;
    ResultSet resultSet = null;
    String email = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/ems";
        String username = "root";
        String password = "aman";
        connection = DriverManager.getConnection(url, username, password);
		
     // Fetch email before deleting
        String selectQuery = "SELECT email FROM employee WHERE employee_id=?";
        selectStatement = connection.prepareStatement(selectQuery);
        selectStatement.setString(1, employeeId);
        resultSet = selectStatement.executeQuery();

        // Check if the employee exists
        if (resultSet.next()) {
            email = resultSet.getString("email");
        } else {
            // Handle the case when the employee with the given ID is not found
            out.println("<h2>Employee not found</h2>");
            return;
        }
        
        // Create a SQL statement
        String sqlQuery = "DELETE FROM employee WHERE employee_id=?";
        preparedStatement = connection.prepareStatement(sqlQuery);
        preparedStatement.setString(1, employeeId);

        // Execute the delete operation
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            // Successful delete
            String message="Your Account has been deleted from the Server It Means You are No longer a part of this organisation!";
            response.sendRedirect("email_send.jsp?demand=delete&to="+email+"&message="+message);
%>
            <h2>Employee Deleted Successfully</h2>
            <p><a href="employee_information.jsp">Back to Search</a></p>
<%
        } else {
            // Delete failed
            out.println("<h2>Delete failed</h2>");
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (selectStatement != null) selectStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
