<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="java.sql.*"%>

<%
    // Set the path to the directory where you want to store the uploaded files
    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

    // Create the directory if it doesn't exist
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // Create a DiskFileItemFactory
    DiskFileItemFactory factory = new DiskFileItemFactory();

    // Set the temporary directory to store files
    factory.setRepository(uploadDir);

    // Create a ServletFileUpload
    ServletFileUpload upload = new ServletFileUpload(factory);

    try {
        // Parse the request to get file items.
        List<FileItem> fileItems = upload.parseRequest(request);

        // Process the uploaded file items
        for (FileItem item : fileItems) {
            if (!item.isFormField()) {
                // Get the uploaded file's input stream
                InputStream fileContent = item.getInputStream();

                // Get the original file name
                String fileName = item.getName();

                // Find the ID of the latest inserted row in the "leaves" table
                int latestLeaveId = -1;
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ems", "root", "aman");
                
                // Retrieve the ID of the latest inserted row
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT MAX(leave_id) AS leave_id FROM leaves");
                
                if (rs.next()) {
                    latestLeaveId = rs.getInt("leave_id");
                }

                // Update the document in the "leaves" table based on the latest ID
                PreparedStatement updatePstmt = con.prepareStatement("UPDATE leaves SET filename=?, document=? WHERE leave_id=?");
                updatePstmt.setString(1, fileName);
                updatePstmt.setBlob(2, fileContent);
                updatePstmt.setInt(3, latestLeaveId);
                updatePstmt.executeUpdate();

                // Close the database connections
                updatePstmt.close();
                rs.close();
                stmt.close();
                con.close();

                out.println("Document updated successfully for Leave ID: " + latestLeaveId);
                response.sendRedirect("leave.jsp");
            }
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
