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
  <title>Email Form</title>

  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f8f8f8;
      text-align: center;
      margin: 0;
      padding: 0;
    }

    h2 {
      color: #333;
      margin-bottom: 30px;
      font-size: 36px;
    }

    form {
      max-width: 500px;
      margin: 0 auto;
      background-color: #ffffff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    }

    label {
      display: block;
      margin: 20px 0 10px;
      color: #333;
      font-size: 18px;
    }

    input,
    textarea {
      width: calc(100% - 20px);
      padding: 10px;
      margin-bottom: 20px;
      box-sizing: border-box;
      font-size: 16px;
      border: 1px solid #ddd;
      border-radius: 6px;
    }

    textarea {
      resize: vertical;
    }

    input[type="submit"] {
      background-color: #4caf50;
      color: #fff;
      padding: 12px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 18px;
      transition: background-color 0.3s ease;
    }

    input[type="submit"]:hover {
      background-color: #45a049;
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
    
  </style>
</head>
<body>
	<header>
        <h1>Leave Requests</h1>
    </header>

    <nav>
        <a href="employee_information.jsp">Employee Information</a>
        <a href="attendenceTracking.jsp">Attendance Tracking</a>
        <a href="leaveManagement.jsp">Leave Management</a>
         <a href="">Notifications/Reminders</a>
		<a href="admin.jsp">Back-To-DashBoard</a>
		<a href="logout.jsp">LogOut</a>
    </nav>
  <h2>Contact Us</h2>

  <form action="email_send.jsp" method="post">
	
	<label for="To">To:</label>
    <input type="email" id="to" name="to" required>
	
	<input type="hidden" id="demand" name="demand" value="send">

    <label for="subject">Subject:</label>
    <input type="text" id="subject" name="subject" required>

    <label for="message">Message:</label>
    <textarea id="message" name="message" rows="10" required></textarea>

    <input type="submit" value="Send Email">
  </form>

</body>
</html>
