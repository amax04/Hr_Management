<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>

<%
    // Check if the user is logged in
    String role = (String) session.getAttribute("role");
    if (role == null || role.isEmpty()) {
        // If not logged in, redirect to the login page
        response.sendRedirect("login.html");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave Requests</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }
		body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        header {
            background-color: #333;
            padding: 15px;
            text-align: center;
            color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        nav {
            background: linear-gradient(to right, #4CAF50, #2196F3);
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        nav a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
        }

        nav a:hover {
            background-color: #ddd;
            color: black;
        }

        section {
            padding: 20px;
        }

        /* Responsive Navigation */
        @media screen and (max-width: 600px) {
            nav a {
                float: none;
                width: 100%;
                text-align: left;
            }
        }
        
        .file{
        	color:gray;
        }
        .file:hover {
			color:darkgray;
		}
    </style>
</head>
<body>

	<header>
        <h1>Leave Requests</h1>
    </header>

    <nav>
        <a href="employee_information.jsp">Employee Information</a>
        <a href="attendenceTracking.jsp">Attendance Tracking</a>
        <a href="">Leave Management</a>
         <a href="email_form.jsp">Notifications/Reminders</a>
		<a href="admin.jsp">Back-To-DashBoard</a>
		<a href="logout.jsp">LogOut</a>
    </nav>


    <table>
        <tr>
			<th>Leave ID</th>
            <th>Employee ID</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Status</th>
            <th>File</th>
            <th>Comment</th>
            <th>Action</th>
        </tr>
        <%
            try {
                // JDBC Connection
                String url = "jdbc:mysql://localhost:3306/ems";
                String dbUsername = "root";
                String dbPassword = "aman";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);

                // Fetch leave requests from the database
                String query = "SELECT * FROM leaves where status='pending'";
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query);

                while (resultSet.next()) {
					String leaveId=resultSet.getString("leave_id");
                    String employeeId = resultSet.getString("employee_id");
                    String startDate = resultSet.getString("start_date");
                    String endDate = resultSet.getString("end_date");
                    String status =	resultSet.getString("status");
                    String comment = resultSet.getString("comments");
					String filename=resultSet.getString("filename");
                    out.println("<tr>");
                    out.println("<td>" + leaveId + "</td>");
                    out.println("<td>" + employeeId + "</td>");
                    out.println("<td>" + startDate + "</td>");
                    out.println("<td>" + endDate + "</td>");
                    out.println("<td>" + status + "</td>");
                    %>
                    <td class="file" onclick="location='downloadDocument.jsp?leaveId=<%=leaveId%>'"><u><%=filename %></u></td>
                    <%
                    out.println("<td>" + comment + "</td>");

                    // Add a form to update the status
                    out.println("<td>");
                    out.println("<form action=\"update.jsp\" method=\"post\">");
                    out.println("<input type=\"hidden\" name=\"leaveId\" value=\"" + leaveId + "\">");
					
                    out.println("<select name=\"newStatus\">");
                    out.println("<option value=\"Approved\">Approved</option>");
                    out.println("<option value=\"Rejected\">Rejected</option>");
                    out.println("<option value=\"Pending\">Pending</option>");
                    out.println("</select>");
                    out.println("<input type=\"submit\" value=\"Update\">");
                    out.println("</form>");
                    out.println("</td>");

                    out.println("</tr>");
                }

                // Close resources
                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

</body>
</html>
