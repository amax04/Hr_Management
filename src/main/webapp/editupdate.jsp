<%@ page import="java.sql.*,java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update Employee</title>
</head>
<style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            display: inline-block;
            margin-top: 10px;
            color: #333;
            text-decoration: none;
        }

        a:hover {
            color: #4CAF50;
        }
    </style>
<body>

<%
    String employeeId = request.getParameter("employeeId");
    String name = request.getParameter("name");
    String contactNumber = request.getParameter("contactNumber");
    String jobTitle = request.getParameter("jobTitle");
    String department = request.getParameter("department");
	String email=request.getParameter("email");
	String imageBase64 = request.getParameter("imageBase64");
	byte[] imageBytes = Base64.getDecoder().decode(imageBase64);
	
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        String url = "jdbc:mysql://localhost:3306/ems";
        String username = "root";
        String password = "aman";
        connection = DriverManager.getConnection(url, username, password);

        // Create a SQL statement
        String sqlQuery = "UPDATE employee SET name=?, contact_number=?, job_title=?, department=?,email=?,image=? WHERE employee_id=?";
        preparedStatement = connection.prepareStatement(sqlQuery);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, contactNumber);
        preparedStatement.setString(3, jobTitle);
        preparedStatement.setString(4, department);
        preparedStatement.setString(5, email);
        preparedStatement.setBytes(6, imageBytes);
        
        preparedStatement.setString(7, employeeId);
        // Execute the update operation
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            // Successful update
            String message="Your Infomation has been Updated To:\n Name:"+name+"\n Contact :"+contactNumber+"\n job Title:"+jobTitle+"\n Department :"+department+"\n email:"+email;
            response.sendRedirect("email_send.jsp?demand=edit&to="+email+"&message="+message);
%>
            <h2>Employee Updated Successfully</h2>
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
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
