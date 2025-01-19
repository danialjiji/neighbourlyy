<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visitor Form</title>
    </head>
    <body>
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return;
            }
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid"); // Use implicit session
            String username = (String) session.getAttribute("username");
        %>

        <form action="securityController" method="POST" enctype="multipart/form-data">
            <p>Visitor's Name</p>
                <input type="text" name="visitorname" required/><br>
            <p>IC/Passport</p>
                <input type="text" name="icpassport" required/><br>
            <p>Plate Number</p>
                <input type="text" name="plateno" required/><br>
            <p>Entry Time</p>
                <input type="time" name="entrytime" required/><br>
            <p>Date of Visit</p>
                <input type="date" name="datevisit" required/><br>
            <p>Purpose of Visit</p>
                <input type="text" name="purposevisit" required/><br>
            <p>Phone Number</p>
                <input type="text" name="phoneno" required/><br>
            <button type="submit">Submit</button>
            <button type="reset">Cancel</button>
            <input type="hidden" name="accessType" value="addVisitor">
            <input type="hidden" name="userid" value="<%= userid %>"> <!-- Set the userid dynamically -->
        </form>
    </body>
</html>
