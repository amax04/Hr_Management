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
        #header{
            display: flex;
            background-color: rgb(213, 245, 245);
            justify-content: space-around;
        }
        #header>div:nth-child(2){
            border-top-right-radius: 15px;
            border-bottom-left-radius: 15px;
            margin: 45px 25px;
            padding: 5px;
            background-color: rgb(146, 232, 246);
            font-size: 17px;
        }
        #header>div:nth-child(1){
            margin-left: 350px;
            font-size: 24px;
        }
        #header>div:nth-child(2):hover{
            background-color: rgb(82, 219, 238);
        }
        #header>div:nth-child(2):active{
            background-color: rgb(235, 235, 235);
        }
        #cont{
            display: flex;
            justify-content: space-evenly;
            margin: 50px 150px;
        }
        #cont>div{
            border: 2px solid;
            background-color:rgb(0, 190, 219);
            font-size: 20px;
            padding: 50px 110px 50px 110px;
            border-top-right-radius : 45px;
            border-bottom-left-radius: 45px;
        }
        
        #cont>div:nth-child(2){
            background-color: blueviolet;
        }
        #cont>div:nth-child(2):hover{
            background-color: rgb(117, 39, 191);
        }
		#cont>div:nth-child(2):active{
            background-color: rgb(235, 235, 235);
        }
        #cont>div:hover{
            background-color: rgb(10, 181, 208);
        }
        #cont>div:active{
            background-color: rgb(235, 235, 235);
        }
        #details
        {
            background-color: aliceblue;
            padding: 15px 0;
        }
        #details>div
        {   
            display: flex;
            justify-content: space-between;
            margin: 10px 200px;
        }
        #details>div>div
        {
            background-color: blueviolet;
            width: 440px;
            border-radius: 15px 00px;
            margin: 0px 10px;
            padding: 15px 55px;
            text-align: center;
        }#details>div>div:hover
        {
            background-color: rgb(116, 33, 194);
         }
        #details>div>div:nth-child(2)
        {
            background-color:  rgb(0, 190, 219);
        }
        
        #details>div>div:nth-child(2):hover
        {
            background-color:  rgb(10, 181, 208);
        }
        .details-head{
            padding: 15px 500px;
            font-size: 22px;

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
    img {
      width: 300px;
      height: 250px;
    }
    </style>
</head>
<body>
    <div id="header">
        <div><h1> Employee Dashboard</h1> </div>
        <!-- The dropdown container -->
		<div class="dropdown">
		  <!-- The button to trigger the dropdown -->
		  <button onclick="toggleDropdown()">Settings</button>
		
		  <!-- The dropdown content -->
		  <div id="myDropdown" class="dropdown-content">
		    <!-- Dropdown items -->
		    <a onclick="attendence()">Attendence</a>
		    <a onclick="leave()">Leave</a>
		    <a onclick="logout()">Log Out</a>
		  </div>
		</div>
		
		<script>
            function attendence() {
                window.location.href="attendence.jsp";
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
   
		<%		String attributeValue = (String) session.getAttribute("id");
				session.setAttribute("id",attributeValue);
				String name;
				String number;
				String jobtitle;
				String department;

				Connection connection = null;
				Statement statement = null;
				ResultSet resultSet = null;
		
				try {
					
					 // using DriverManager
					 Class.forName("com.mysql.cj.jdbc.Driver");
					 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "aman");

					statement = connection.createStatement();
					resultSet = statement.executeQuery("SELECT * FROM employee where employee_id="+attributeValue);

					if(resultSet.next()) {
						
						name=resultSet.getString("name");
						
						number=resultSet.getString("contact_number");
						jobtitle=resultSet.getString("job_title");
						department=resultSet.getString("department");
						
						byte[] imageBytes = resultSet.getBytes("image");
	    				String base64Image = imageBytes != null ? new String(Base64.getEncoder().encode(imageBytes)) : "";
	    				
%>

 <div id="details">
 		<div style="display:flex; justify-content: center;">
 			<img src="data:image/jpeg;base64,<%= base64Image %>" alt="Image">
		</div>
        <div class="details-head">
<%		
		out.println(name);
		out.println("</div>"+
					"<div>"+
						"<div>Employee_ID:</div>"+
							"<div>"+attributeValue+"</div>"+
						"</div>"+
						"<div>"+
							"<div>Contact_Number:</div>"+
							"<div>"+number+"</div>"+
						"</div>"+
						"<div>"+
							"<div>job_title:</div>"+
							"<div>"+jobtitle +"</div>"+
						"</div>"+
						"<div>"+
							"<div>Department:</div>"+
							"<div>"+department+"</div>"+
						"</div>"+
					"</div>"
				);
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
    <div id="cont">
        <div onclick="location='attendence.jsp'">Attendence</div>
        <div onclick="location='leave.jsp'">Apply Leave</div>
		<div onclick="location='employeeReset.jsp?employeeId=<%=attributeValue%>'">Reset</div>
    </div>
</body>
</html>