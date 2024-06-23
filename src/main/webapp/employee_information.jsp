<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Employee Management System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        #nav {
            background-color: aliceblue;
            margin: -10px 0 30px;
            padding: 0 0 30px;
            text-align: center;
        }

        #nav h1 {
            margin: 0;
        }

        #nav > div {
            display: flex;
            justify-content: space-between;
            padding: 5px 150px 10px 155px;
        }

        #nav > div > div {
            border-radius: 15px 0px;
            padding: 5px 10px;
            background-color: rgb(206, 232, 254);
            cursor: pointer;
        }

        #nav > div > div:hover {
            background-color: rgb(179, 214, 245);
        }

        #Cont-box {
            background-color: rgb(143, 255, 218);
            margin: -30px 0;
            padding: 50px 0px;
        }

        .cont {
            display: flex;
            justify-content: space-between;
            padding: 2px 50px;
        }

        .cont > div {
            border: 1px solid;
            width: 265px;
            padding: 10px;
            text-align: center;
        }

        .cont > div:nth-child(2n) {
            background-color: rgb(50, 244, 185);
        }

        .cont > div:nth-child(2n+1) {
            background-color: rgb(108, 216, 184);
        }

        .cont .action {
            display: flex;
            justify-content: space-around;
        }

        .edit,
        .delete,
        .user-update {
            padding: 8px 12px;
            margin-right: 5px;
            cursor: pointer;
            text-decoration: none;
            color: #fff;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .edit {
            background-color: #2196F3;
        }

        .delete {
            background-color: #f44336;
        }

        .user-update {
            background-color: #FF9800;
        }

        .edit:hover,
        .delete:hover,
        .user-update:hover {
            background-color: #555;
        }

        #empsearch {
            margin: 30px 0 0;
            padding: 20px;
            background-color: #f4f4f4;
        }

        #empsearch h2 {
            color: #333;
            text-align: center;
        }

        select {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background: url('https://img.icons8.com/material-rounded/24/000000/down-arrow.png') no-repeat right 12px center/15px 15px;
        }

        .search-form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .sea {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .button {
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .button:hover {
            background-color: #45a049;
        }

        .label {
            display: block;
            margin-bottom: 8px;
            color: #333;
        }

        #add {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 400px;
            max-width: 100%;
            margin: 30px auto;
        }

        #add h1 {
            color: #333;
            text-align: center;
        }

        .add-in form {
            display: grid;
            gap: 10px;
        }

        .add-in label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }

        .add-in input,
        .add-in select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        #Role p {
            color: #555;
            margin-bottom: 5px;
        }

        #Role input,
        #Role label {
            margin-right: 5px;
        }

        #Role label {
            color: #333;
        }

        #Role input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
            border: none;
            padding: 10px;
            border-radius: 4px;
        }

        #Role input[type="submit"]:hover {
            background-color: #45a049;
        }
        #Cont-box {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
        margin: -30px 0;
        padding: 50px 20px; /* Adjust padding */
    }

    .cont {
        display: flex;
        flex-direction: column;
        border: 1px solid;
        border-radius: 10px;
        overflow: hidden;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease-in-out;
        cursor: pointer;
    }

    .cont:hover {
        transform: translateY(-5px);
    }

    .cont > div {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #ccc;
    }

    .cont > div:last-child {
        border-bottom: none;
    }

    .cont .action {
        display: flex;
        justify-content: space-around;
        margin-top: 10px;
    }

    .cont img {
        width: 250px;
        height: 150px;
        border-bottom: 1px solid #ccc;
    }

    .cont .action a {
        padding: 8px 12px;
        margin-right: 5px;
        cursor: pointer;
        text-decoration: none;
        color: #fff;
        border-radius: 4px;
        transition: background-color 0.3s;
    }

    .cont .action .edit {
        background-color: #2196F3;
    }

    .cont .action .delete {
        background-color: #f44336;
    }

    .cont .action .user-update {
        background-color: #FF9800;
    }

    .cont .action a:hover {
        background-color: #555;
    }
    
    
    .card-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    .card {
      border: 1px solid #ccc;
      border-radius: 8px;
      overflow: hidden;
      width: 300px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      background-color: #fff;
    }

    .card img {
      width: 300px;
      height: 250px;
    }

    .card-content {
      padding: 15px;
    }

    .card-content p {
      margin: 5px 0;
    }

    .buttons {
      display: flex;
      justify-content: space-between;
      padding: 10px;
    }

    button {
      padding: 8px 16px;
      cursor: pointer;
    }

    button.primary {
      background-color: #4caf50;
      color: #fff;
      border: none;
    }

    button.secondary {
      background-color: #2196f3;
      color: #fff;
      border: none;
    }

    button.warning {
      background-color: #ff9800;
      color: #fff;
      border: none;
    }
    </style>
</head>
<body>
    <div id="nav">
        <div>
            <h1>Employee Information</h1>
        </div>
        <div>
            <div>Employee Information</div>
            <div onclick="location='attendenceTracking.jsp'">Attendance Tracking</div>
            <div onclick="location='leaveManagement.jsp'">Leave Management</div>
            <div onclick="location='email_form.jsp'">Notification & Reminders</div>
            <div onclick="location='admin.jsp'">Back To Home Page</div>
            <div onclick="location='logout.jsp'">Logout</div>
        </div>
    </div>
    <div id="Cont-box">
        
        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "aman");

                statement = connection.createStatement();
                resultSet = statement.executeQuery("SELECT * FROM employee");

                while (resultSet.next()) {
                    String employeeId = resultSet.getString("employee_id");
                    byte[] imageBytes = resultSet.getBytes("image");
    				String base64Image = imageBytes != null ? new String(Base64.getEncoder().encode(imageBytes)) : "";
    						
		%>
		<div class="card">
      <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Image">
      <div class="card-content">
        <p><strong>Name:</strong> <%=resultSet.getString("name") %></p>
        <p><strong>ID: </strong><%= resultSet.getString("employee_id") %></p>
        <p><strong>Number:</strong> <%= resultSet.getString("contact_number")%></p>
        <p><strong>Email:</strong> <%= resultSet.getString("email")%></p>
        <p><strong>Job_tital:</strong><%= resultSet.getString("job_title") %> </p>
        <p><strong>Department:</strong> <%=resultSet.getString("department")  %></p>
      </div>
      <div class="buttons">
        <a class="edit" href="edit.jsp?employeeId=<%=employeeId%>">Edit</a> 
        <a class='delete' href="delete.jsp?employeeId=<%=employeeId%>">Delete</a>
        <a class='user-update' href="userUpdate.jsp?employeeId=<%=employeeId%>">Reset</a>
      </div>
    </div>
		<%								
                    
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
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

    <div id="empsearch">
        <h2>Employee Search</h2>

        <form class="search-form" action="search.jsp" method="GET">
            <label class="label" for="searchCriteria">Select Search Criteria:</label>
            <select id="searchCriteria" class="sea" name="searchCriteria" required>
                <option value="" disabled selected>Select...</option>
                <option value="name">Name</option>
                <option value="employee_id">Employee ID</option>
                <option value="contact_number">Contact Number</option>
                <option value="job_title">Job Title</option>
                <option value="department">Department</option>
            </select>

            <label class="label" for="searchValue">Enter Search Value:</label>
            <input type="text" class="sea" id="searchValue" name="searchValue" placeholder="Enter search value" required>

            <div id="jobTitleGroup" style="display: none;">
                <label class="label" for="jobTitle">Select Job Title:</label>
                <select class="sea" id="jobTitle" name="jobTitle">
                    <option value="" disabled selected>Select job title</option>
                    <option value="Software Engineer">Software Engineer</option>
                    <option value="Marketing Specialist">Marketing Specialist</option>
                    <option value="Sales Representative">Sales Representative</option>
                </select>
            </div>

            <div id="departmentGroup" style="display: none;">
                <label for="department">Select Department:</label>
                <select class="sea" id="department" name="department">
                    <option value="" disabled selected>Select department</option>
                    <option value="IT">IT</option>
                    <option value="Marketing">Marketing</option>
                    <option value="Sales">Sales</option>
                </select>
            </div>

            <button class="button" type="submit">Search</button>
        </form>

        <script>
            document.getElementById('searchCriteria').addEventListener('change', function () {
                var jobTitleGroup = document.getElementById('jobTitleGroup');
                var departmentGroup = document.getElementById('departmentGroup');

                jobTitleGroup.style.display = 'none';
                departmentGroup.style.display = 'none';

                var selectedValue = this.value;

                if (selectedValue === 'job_title') {
                    jobTitleGroup.style.display = 'block';
                } else if (selectedValue === 'department') {
                    departmentGroup.style.display = 'block';
                }
            });
        </script>
    </div>

    <div id="add">
        <div>
            <h1>Add New Employee</h1>
        </div>
        <div class="add-in">
            <form action="EmployeeServlet" method="post">
                <div>
                    <label for="Name">Name:</label>
                    <input type="text" name="name" required>
                </div>
                <div>
                    <label for="Contact_Number">Contact Number:</label>
                    <input type="text" name="contactNumber" required>
                </div>
                <div>
                	<label for="email">Email:</label>
                	<input type="email" name="email" required>
                </div>
                <div>
                    <label for="Job_Title">Job Title:</label>
                    <input type="text" name="jobTitle" required>
                </div>
                <div>
                    <label for="Department">Department:</label>
                    <input type="text" name="department" required>
                </div>
                <div id="Role">
                    <p>Select Role of the employee</p>
                    <input type="radio" name="role" value="admin" id="admin">
                    <label for="admin">Admin</label>
                    <input type="radio" name="role" value="employee" id="employee" required>
                    <label for="employee">Employee</label>
                </div>
                <div>
                    <label for="image">Upload Image:</label>
                    <input type="file" id="image" name="image" accept="image/*" onchange="encodeImage()">
                    <br>
                    <input type="hidden" id="imageBase64" name="imageBase64" required>
                    <script>
                        function encodeImage() {
                            var fileInput = document.getElementById("image");
                            var file = fileInput.files[0];

                            var reader = new FileReader();
                            reader.onload = function (e) {
                                document.getElementById("imageBase64").value = e.target.result.split(",")[1];
                            };

                            reader.readAsDataURL(file);
                        }
                    </script>
                </div>
                <div>
                    <input type="submit" value="Add">
                </div>
            </form>
        </div>
    </div>
</body>
</html>
