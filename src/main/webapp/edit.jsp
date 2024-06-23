<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Edit Employee</title>
	 <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
			flex-direction:column;
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
        String sqlQuery = "SELECT * FROM employee WHERE employee_id = '" + employeeId + "'";
        resultSet = statement.executeQuery(sqlQuery);

        if (resultSet.next()) {
            String name = resultSet.getString("name");
            String contactNumber = resultSet.getString("contact_number");
            String jobTitle = resultSet.getString("job_title");
            String department = resultSet.getString("department");
			String email=resultSet.getString("email");
			byte[] imageBytes = resultSet.getBytes("image"); // Assuming the column name is "image"

            // Convert the image bytes to Base64
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);

            // Display the employee details in a form for editing
%>
            <h2>Edit Employee</h2>
            <form action="editupdate.jsp" method="POST">
                <input type="hidden" name="employeeId" value="<%= employeeId %>">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= name %>" required><br>
                <label for="contactNumber">Contact Number:</label>
                <input type="text" id="contactNumber" name="contactNumber" value="<%= contactNumber %>" required><br>
                 <label for="email">Email:</label>
                <input type="text" id="email" name="email" value="<%= email %>" required><br>
                
                <label for="jobTitle">Job Title:</label>
                <input type="text" id="jobTitle" name="jobTitle" value="<%= jobTitle %>" required><br>
                <label for="department">Department:</label>
                <input type="text" id="department" name="department" value="<%= department %>" required><br>
                
                 <label for="image">Upload Image:</label>
		        <input type="file" id="image" name="image" accept="image/*" onchange="encodeImage()"><br>
		         <input type="hidden" id="imageBase64" name="imageBase64" value="<%= base64Image %>">
				
				<script>
				    function encodeImage() {
				        var fileInput = document.getElementById("image");
				        var file = fileInput.files[0];
				
				        var reader = new FileReader();
				        reader.onload = function(e) {
				            document.getElementById("imageBase64").value = e.target.result.split(",")[1];
				        };
				
				        reader.readAsDataURL(file);
				    }
				</script>
                <button type="submit">Save Changes</button>
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
