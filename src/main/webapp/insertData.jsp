<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.sql.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>


    <%
        // Check if the form is submitted
        if (request.getMethod().equalsIgnoreCase("post")) {
            // Get form data
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String comment = request.getParameter("comment");

            try {
                // Convert date strings to java.sql.Date
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.sql.Date startDate = new java.sql.Date(dateFormat.parse(startDateStr).getTime());
                java.sql.Date endDate = new java.sql.Date(dateFormat.parse(endDateStr).getTime());

                // Insert data into the "leaves" table
                Connection connection = null;
                PreparedStatement preparedStatement = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "aman");

                    String sql = "INSERT INTO leaves (employee_id, start_date, end_date, comments) VALUES (?, ?, ?, ?)";
                    preparedStatement = connection.prepareStatement(sql);
                    
                    // Assume 'id' is the employee ID obtained from the session
                    String id = (String) session.getAttribute("id");
                    preparedStatement.setString(1, id);
                    preparedStatement.setDate(2, startDate);
                    preparedStatement.setDate(3, endDate);
                    preparedStatement.setString(4, comment);

                    preparedStatement.executeUpdate();

                    out.println("<p>Leave details inserted successfully!</p>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error inserting leave details.</p>");
                } finally {
                    try {
                        if (preparedStatement != null) preparedStatement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } catch (ParseException e) {
                e.printStackTrace();
                out.println("<p>Error parsing date.</p>");
            }
        }
    %>


<!DOCTYPE html>
<html lang="en">
<head>
    <title>Document</title>
    <!-- Add your styles here -->
     <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            margin-bottom: 8px;
        }

        input[type="file"] {
            padding: 8px;
            margin-bottom: 16px;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        p {
            text-align: center;
            color: #27ae60;
        }

        .error {
            text-align: center;
            color: #c0392b;
        }
    </style>
</head>
<body>
    <!-- Your HTML content here -->

    <div>
        <form id="dateForm" action="docUpload.jsp" method="post" enctype="multipart/form-data">
            <!-- Your form fields here -->
            <div>
                <label for="document">Document (TXT):</label>
                <input type="file" id="document" name="document" accept=".txt">
            </div>
            <div>
                <button class="button" type="submit">Submit</button>
            </div>
        </form>

        <!-- Display success message if any -->
    </div>
</body>
</html>
