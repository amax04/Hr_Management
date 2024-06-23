import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateLeaveStatusServlet")
public class UpdateLeaveStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String employeeId = request.getParameter("employeeId");
        String newStatus = request.getParameter("newStatus");
		String start = request.getParameter("StartDate");
		String end = request.getParameter("endDate");

        try {
            // JDBC Connection
            String url = "jdbc:mysql://localhost:3306/ems";
            String dbUsername = "root";
            String dbPassword = "aman";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);
			
			java.sql.Date startDate = java.sql.Date.valueOf(start);
            java.sql.Date endDate = java.sql.Date.valueOf(end);

            // Update leave request status in the database
            String updateQuery = "UPDATE leaves SET status = ? WHERE employee_id = ? , start_date=? and end_date=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {
                preparedStatement.setString(1, newStatus);
                preparedStatement.setString(2, employeeId);
				preparedStatement.setDate(3, startDate);
                preparedStatement.setDate(4, endDate);

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

}
