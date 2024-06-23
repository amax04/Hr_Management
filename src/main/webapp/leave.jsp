<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>

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
           background-color: rgb(192, 226, 255);
            border-radius: 15px 0;
        }
        #header>div:nth-child(2):hover{
            border: none;
            padding: 5px;
            border-radius: 15px 0;
            background-color: rgb(152, 193, 228);
        }
        #dateForm{
            padding: 55px 50px;
            font-size: 20px;
        }
        #dateForm>div{
            margin: 15px 450px;
        }
        #dateForm>div:nth-child(3){ 
            margin: 5px 650px;
        }
        .button{
            font-size: 16px;
            border: none;
            padding: 10px;
            border-radius: 15px 0;
            background-color: rgb(192, 226, 255);
        }
        .button:hover{
            background-color: rgb(152, 193, 228) ;
        }
		.leave{
            display: flex;
            justify-content: space-between;
            padding: 10px 10px;
            background-color: rgb(236, 235, 235);
        }
		.leave>div{
            text-align: center;
            font-size: 18px;
            padding: 8px;
            border-radius: 15px 0;
            width: 350px;
            background-color: azure;
            border: 1px solid gray;
        }
        .leave>div:nth-child(2n){
            background-color: rgb(210, 248, 248);
        }
        h2{text-align: center;}
        .leave:nth-child(2n)
        {
            background-color: rgb(210, 225, 240);
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
        <div><h1>Apply Leave</h1></div>
        <!-- The dropdown container -->
		<div class="dropdown">
		  <!-- The button to trigger the dropdown -->
		  <button onclick="toggleDropdown()">Settings</button>
		
		  <!-- The dropdown content -->
		  <div id="myDropdown" class="dropdown-content">
		    <!-- Dropdown items -->
		    <a onclick="goBack()">Back-To-Dashboard</a>
		    <a onclick="attendence()">Attendence</a>
		    <a onclick="logout()">Log Out</a>
		  </div>
		</div>
        
    </div>	
    
   		 <script>
   		function goBack() {
            window.history.back();
        }
   		function attendence(){
   			window.location.href="attendence.jsp";	
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
    <div>
        <form id="dateForm" action="insertData.jsp" method="post">

            <div>
                <label for="startDate">Start Date:</label>
                <input type="date" id="startDate" name="startDate" required>
            
                <label for="endDate">End Date:</label>
                <input type="date" id="endDate" name="endDate" required>
            </div>
            <div>
                <label for="comment">Comment:</label>
                <textarea id="comment" name="comment" rows="4" cols="50" placeholder="Add your comment" required></textarea>
            </div>
            <div>
                <button class="button" type="submit" onclick="validateDateRange()">Submit</button>
            </div>
        </form>
        
        <script>
        function encodeDocument() {
            var fileInput = document.getElementById("document");
            var file = fileInput.files[0];

            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("documentBase64").value = e.target.result.split(",")[1];
            };

            reader.readAsDataURL(file);
        }
        
            function validateDateRange() {
                var startDate = new Date(document.getElementById('startDate').value);
                var endDate = new Date(document.getElementById('endDate').value);
        
                // Calculate the difference in days
                var timeDifference = endDate - startDate;
                var daysDifference = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
        
                // Check if the difference is more than 10 days
                if (daysDifference > 10) {
            alert('Error: The date range cannot be more than 10 days.');
        } else {
            var comment = document.getElementById('comment').value;
            if (comment.trim() === "") {
                alert('Error: Comment cannot be empty.');
            } else {
                var formattedStartDate = formatDate(startDate);
                var formattedEndDate = formatDate(endDate);
                alert('Date range is valid!\nStart Date: ' + formattedStartDate + '\nEnd Date: ' + formattedEndDate + '\nComment: ' + comment);
                // You can submit the form or perform other actions here
            }
        }
            }
        </script>
    </div>

	 
    <H2>Leaves Applyed</H2>
    <div id="leave-cont">
        <div class="leave">
            <div>Start_Date</div>
            <div>End_Date</div>
            <div>Status</div>
            <div>comments</div>
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
				resultSet = statement.executeQuery("SELECT * FROM leaves where employee_id="+id);
				
				while (resultSet.next()) {
					out.println(" <div class='leave'>");
					
					java.sql.Date start = resultSet.getDate("start_date");
					java.sql.Date end = resultSet.getDate("end_date");

					out.println("<div>" + start +"</div>");
					out.println(" <div>" + end +"</div>");
					out.println(" <div>" + resultSet.getString("status")+"</div>");
					
					out.println(" <div>" + resultSet.getString("comments")+"</div>");
					out.println("</div>");
					
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