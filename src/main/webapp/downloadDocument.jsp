<%@ page import="java.io.*,java.util.*,javax.servlet.*,javax.servlet.http.*,java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Get the leave ID from the request parameter
    String leaveIdParam = request.getParameter("leaveId");

    // Check if the leaveIdParam is not null or empty
    if (leaveIdParam != null && !leaveIdParam.isEmpty()) {
        int leaveId = Integer.parseInt(leaveIdParam);

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "aman");

            // Retrieve document details from the "leaves" table
            String sql = "SELECT filename, document FROM leaves WHERE leave_id=?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, leaveId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String filename = resultSet.getString("filename");
                Blob documentBlob = resultSet.getBlob("document");

                // Set response headers
                response.setContentType("text/plain");
                response.setHeader("Content-Disposition", "attachment; filename=" + filename);

                // Get the output stream and write the document content
                OutputStream outs = response.getOutputStream();
                InputStream in = documentBlob.getBinaryStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = in.read(buffer)) != -1) {
                    outs.write(buffer, 0, bytesRead);
                }

                in.close();
                outs.close();
            } else {
                // Handle the case where leave ID is not found
                out.println("<p>Leave ID not found.</p>");
            }
        } catch (ClassNotFoundException | SQLException | IOException e) {
            e.printStackTrace();
            out.println("<p>Error downloading file.</p>");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // Handle the case where leaveIdParam is null or empty
        out.println("<p>Invalid leave ID.</p>");
    }
%>
