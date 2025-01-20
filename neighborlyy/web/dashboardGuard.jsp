<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
        <title>Dashboard</title>
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
        <ul>
            <li><a href=".\Guard\VisitorForm.jsp">Add Visitor</a></li>
            <li><a href=".\Guard\VisitorTable.jsp">View Visitor Table</a></li>
            <li><a href=".\Guard\RoundingReport.jsp">Add Rounding Report</a></li>
            <li><a href=".\Guard\RoundingReportTable.jsp">View Rounding Report Table</a></li>
        </ul>

        <p><a href="LogoutServlet">Logout</a></p>
    </body>
</html>
