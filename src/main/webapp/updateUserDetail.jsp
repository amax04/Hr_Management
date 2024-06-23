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
	String email;
    
	Connection connection = null;
    PreparedStatement preparedStatement,selectStatement = null;
    ResultSet resultSet = null;
    

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/ems";
        String dbUsername = "root";
        String dbPassword = "aman";
        connection = DriverManager.getConnection(url, dbUsername, dbPassword);
		
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
        String sqlQuery = "UPDATE users SET username=?, password=? WHERE employee_id=?";
        preparedStatement = connection.prepareStatement(sqlQuery);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);
        preparedStatement.setString(3, employeeId);

        // Execute the update operation
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            // Successful update
             String message="Your Login details are updated and the new one's are username:"+username+"\n password:"+password;
            response.sendRedirect("email_send.jsp?demand=edit&to="+email+"&message="+message);
%>
            <h2>Employee Details Updated Successfully</h2>
            <p><a href="employee_information.jsp">Back to Search</a></p>
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
        	if (selectStatement != null) selectStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
