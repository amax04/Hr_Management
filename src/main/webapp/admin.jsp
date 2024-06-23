<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
    <meta name="viewport" content="width=
    , initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            background-color: black;
            color: aliceblue;
        }
        
        #header{
            text-align: center;
            font-size: 28px;
            display: flex;
            padding-top: 10px;
                
        }
        #header>:nth-child(1){
            width: 90%;
            }
        #header>:nth-child(2){
         margin: 50px 5px 50px 15px;
        border: 1px solid;
        border-radius: 15px;
        padding: 3px 15px;
         }
    
         #cont{
         display: flexbox;
        }
        #cont>div{
            display: flex;
            flex-direction: row;
        }
        #cont>div>div{
            border: 1px solid red;
            background-color: maroon;
            opacity: 50%;
            width: 40%;
            height: 150px;
            margin: 1% 5%;
            text-align: center;
            padding-top: 5%;
            font-size: 30px;
            padding-bottom: 0%;
        }
        #cont>div>div:hover{
            opacity: unset;
            background-color: crimson;
        }
    </style>
</head>
<body>
	
    <!--  div id="header"></div -->
    <div id="header">
        <div><h1>AD<font color="red">M</font>IN</h1></div>
        <div onclick="location='logout.jsp'">logout</div>
    </div>
    <div id="cont"> 
        <div>
            <div onclick="location='employee_information.jsp'">Employee Information</div>
            <div onclick="location='attendenceTracking.jsp'">Attendence Tracking</div>
        </div>
        <div>
            <div onclick="location='leaveManagement.jsp'">Leave Management</div>
            <div onclick="location='email_form.jsp'">Notification & Reminders</div>
        </div>
    </div>
</body>
</html>