<!-- insertData.jsp -->
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Connection connection = null;
    
    if (request.getMethod().equalsIgnoreCase("post")) {
       
	    String employeeId = request.getParameter("leaveId");
        String newStatus = request.getParameter("newStatus");
		
        try {
            // JDBC Connection
            String url = "jdbc:mysql://localhost:3306/ems";
            String dbUsername = "root";
            String dbPassword = "aman";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, dbUsername, dbPassword);
			
			

            // Update leave request status in the database
            String updateQuery = "UPDATE leaves SET status = ? WHERE leave_id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {
                preparedStatement.setString(1, newStatus);
                preparedStatement.setString(2, employeeId);
				preparedStatement.executeUpdate();
            }

            // Close resources
            connection.close();

            // Redirect back to the leaveRequests.jsp page
            response.sendRedirect("leaveManagement.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
	}
    
%>
