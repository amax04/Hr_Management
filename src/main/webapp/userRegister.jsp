<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cool Login Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .login-container {
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
            width: 300px;
        }

        .login-header {
            background-color: #4caf50;
            color: #ffffff;
            padding: 20px;
            text-align: center;
        }

        .login-form {
            padding: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            margin-top: 8px;
        }

        .form-group .signup-link {
            text-align: center;
            margin-top: 16px;
        }

        .form-group .signup-link a {
            color: #4caf50;
            text-decoration: none;
        }

        .form-group .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-header">
        <h2>Register User Login</h2>
    </div>
	
    <div class="login-form">
        <form action="userRegister.jsp" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Register">
            </div>
            <div class="form-group signup-link">
                
            </div>
        </form>
    </div>
</div>
<%	
			if (request.getMethod().equalsIgnoreCase("post")) {
				String username = request.getParameter("username");
				String password = request.getParameter("password");

				// Store the username and password in session for later use
				session.setAttribute("username", username);
				session.setAttribute("password", password);
			
			
			String attributeValue = (String) session.getAttribute("role");
			String name = (String) session.getAttribute("name");
			String num = (String) session.getAttribute("num");
			String dept = (String) session.getAttribute("dept");
			String job = (String) session.getAttribute("job");
				out.println(name);
				out.println(username);
				out.println(password);
				
				Connection connection = null;
				Statement statement = null;
				ResultSet resultSet = null;
		
				try {
					
					 // using DriverManager
					 Class.forName("com.mysql.cj.jdbc.Driver");
					 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "aman");
						out.println(name+"<br>");
						out.println(num+"<br>");
						out.println(job+"<br>");
						out.println(dept+"<br>");
					 // Execute a query
					String query = "SELECT employee_id FROM employee WHERE name = ? AND contact_number = ? AND job_title =? AND department = ?;";
					PreparedStatement preparedStatement = connection.prepareStatement(query);
					preparedStatement.setString(1,name);
					preparedStatement.setString(2,num);
					preparedStatement.setString(3,job);
					preparedStatement.setString(4,dept);
					resultSet = preparedStatement.executeQuery();
					out.println(num);
					out.println(name+"<br>");
						out.println(num+"<br>");
						out.println(job+"<br>");
						out.println(dept+"<br>");

					if(resultSet.next()) {
						
					int id=resultSet.getInt("employee_id");
					session.setAttribute("role",attributeValue);
					session.setAttribute("id",id);
					out.println(id);
					
					response.sendRedirect("processLogin.jsp?employee_id=" + id);
					}
				} catch (SQLException  e) {
					e.printStackTrace();
				} finally {
					// Close resources in the reverse order of their creation
					try {
						if (resultSet != null) resultSet.close();
						if (statement != null) statement.close();
						if (connection != null) connection.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}	
	%>
</body>
</html>
