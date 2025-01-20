<%-- 
    Document   : dashboardResident
    Created on : Jan 18, 2025, 10:31:27 PM
    Author     : USER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard Resident</title>
    </head>
    <body>
        <%
            // Check if the session exists and if the user is logged in
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return; // Stop rendering the page if the session is invalid
            }
            
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid"); // Use implicit session
            String username = (String) session.getAttribute("username");
        %>

        <h1>Welcome to the Dashboard, <%= username %>!</h1>
        <p>Your User ID: <%= userid %></p>

        <h2>Navigation</h2>
       
        <p><a href="./Resident/complaint.jsp">Complaint</a></p>
        <p><a href="LogoutServlet">Logout</a></p>
    </body>
</html>


