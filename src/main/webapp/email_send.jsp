<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
<%@ page import="java.util.Properties"%>
<%
	String demand=request.getParameter("demand");
	String to = request.getParameter("to");
	System.out.println("Recipient Email: " + to);
	System.out.println("Recipient demand: " + demand);
	String text=request.getParameter("message");
	System.out.println("Recipient Message: " + text);
	
	if (to == null || !to.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$")) {
	    // Handle invalid email address
	    out.println("Error: Invalid email address.");
	    return;
	}

// Set the sender's and recipient's email addresses
String from = "saxenakirito06660@gmail.com";
//String to = "";

// Set the host and port for the email server
String host = "smtp.gmail.com";
int port = 587;

// Set the username and password for authentication
String username = "youremail";
String password = "**** **** ****";


// Get system properties
Properties properties = System.getProperties();

// Setup mail server
properties.setProperty("mail.smtp.host", host);
properties.setProperty("mail.smtp.port", String.valueOf(port));
properties.setProperty("mail.smtp.auth", "true");
properties.setProperty("mail.smtp.starttls.enable", "true");

// Declare the session variable
javax.mail.Session sess = null;

try {
    // Get the default Session object
    sess = Session.getInstance(properties, new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
        }
    });
	
    // Create a default MimeMessage object
    MimeMessage message = new MimeMessage(sess);

    // Set the From and To addresses
    message.setFrom(new InternetAddress(from));
    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	if(demand.equals("send")){
	String subject = request.getParameter("subject");
	
    // Set the subject and text of the email
    message.setSubject(subject);
    message.setText(text);
    Transport.send(message);

    out.println("Email sent successfully!");
    out.println("<a href='email_form.jsp'>Go Back</a>");
    
	}
	else if(demand.equals("edit")){
		String subject ="Information Updated";
		
	    // Set the subject and text of the email
	    message.setSubject(subject);
	    message.setText(text);
	    Transport.send(message);

	    out.println("Email sent successfully!");
	    out.println("<a href='employee_information.jsp'>Go Back</a>");
	 
	}
	else if(demand.equals("delete")){
		String subject ="Delete Account";
		
	    // Set the subject and text of the email
	    message.setSubject(subject);
	    message.setText(text);
	    Transport.send(message);

	    out.println("Email sent successfully!");
	    out.println("<a href='employee_information.jsp'>Go Back</a>");
	 
	}
	else if(demand.equals("update")){
		String subject ="Update Login Information";
		
	    // Set the subject and text of the email
	    message.setSubject(subject);
	    message.setText(text);
	    Transport.send(message);

	    out.println("Email sent successfully!");
	    out.println("<a href='employee_information.jsp'>Go Back</a>");
	 
	}
    // Send the message
    

}catch (AddressException e) {
    e.printStackTrace();
    out.println("Error: Invalid email address. Check the console for details.");
} catch (MessagingException e) {
    e.printStackTrace();
    out.println("Error: Unable to send email. Check the console for details.");
}
%>
