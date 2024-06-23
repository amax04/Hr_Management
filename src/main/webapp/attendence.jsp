<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
<html lang="en">
<head>
    <title>Document</title>
    <style>
        body{
            background-color: aliceblue;
        }
        #header{
            
            background-color: aliceblue;
            display: flex;
            justify-content: space-between;
            padding: 5px 150px;
			border-bottom: 1px solid silver;
        }
        #header>div{
            
        }
        #header>div:nth-child(2){
            margin: 30px;
            padding: 5px;
            border: 1px solid rgb(135, 192, 192);
            background-color: rgb(192, 226, 255);
            border-radius: 15px 0;
        }
        #header>div:nth-child(2):hover{
            background-color: rgb(152, 193, 228);
        }
        #cont>div:nth-child(2){
           background-color: whitesmoke;
        }
        .cont-det{
            background-color: rgb(221, 230, 239);
            display: flex;
            justify-content: space-between;
            padding: 5px 100px;
        }
        .cont-det>div{
           
            width: 400px;
            padding: 10px 250px;
            margin: 0px 20px;
            font-size: 18px;
            background-color: rgb(171, 217, 234);
           
            border-radius: 15px 0;
        }
        .cont-det>div:nth-child(2)
        {
            background-color: rgb(181, 204, 226);
        }
        /* Style for the dropdown container */
    .dropdown {
      position: relative;
      display: inline-block;
    }

    /* Style for the dropdown button */
    .dropdown button {
      background-color: #3498db;
      color: white;
      padding: 10px;
      border: none;
      cursor: pointer;
    }

    /* Style for the dropdown content (hidden by default) */
    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #f9f9f9;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      z-index: 1;
    }

    /* Style for the dropdown items */
    .dropdown-content a {
      color: black;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
      cursor: pointer;
    }

    /* Change color on hover */
    .dropdown-content a:hover {
      background-color: #f1f1f1;
    }
    </style>
</head>
<body>
    <div id="header">
        <div><h1>Attendence</h1></div>
        
        <!-- The dropdown container -->
		<div class="dropdown">
		  <!-- The button to trigger the dropdown -->
		  <button onclick="toggleDropdown()">Settings</button>
		
		  <!-- The dropdown content -->
		  <div id="myDropdown" class="dropdown-content">
		    <!-- Dropdown items -->
		    <a onclick="goBack()">Back-To-Dashboard</a>
		    <a onclick="leave()">Leave</a>
		    <a onclick="logout()">Log Out</a>
		  </div>
		</div>
        <script>
            function goBack() {
                window.history.back();
            }
        	function leave(){
        		window.location.href="leave.jsp";
        	};
		// Function to toggle the dropdown content
		function toggleDropdown() {
		  var dropdownContent = document.getElementById("myDropdown");
		  dropdownContent.style.display = (dropdownContent.style.display === "block") ? "none" : "block";
		}
		
		// Function to handle the logout action
		function logout() {
		  // Replace the next line with the actual URL of your login page
		  window.location.href = "logout.jsp";
		}
		</script>
    </div>
    <div id="cont">
        <div class="cont-det">
            <div>Date</div>
            <div>Status</div>
        </div>
        
		<%
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
       // using DriverManager
		
         Class.forName("com.mysql.cj.jdbc.Driver");
         connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "aman");

        statement = connection.createStatement();
        resultSet = statement.executeQuery("SELECT * FROM attendance where employee_id ="+id);

        while (resultSet.next()) {
            out.println(" <div class='cont-det'>"+
						"<div>" + resultSet.getString("attendance_date")+"</div>");
            out.println(" <div>" + resultSet.getString("status")+"</div>"+
						"</div>"	);
            // Add more columns as needed
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
%>
       
    </div>
</body>
</html>