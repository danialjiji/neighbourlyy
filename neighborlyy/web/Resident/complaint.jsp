<%-- 
    Document   : complaint
    Created on : Jan 16, 2025, 2:01:09 PM
    Author     : soleha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Complaint Form</title>
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
        <form action="residentController" method="POST" enctype="multipart/form-data">
            <label for="exampleFormControlSelect1" class="form-label">Complaints type</label>
                    <select class="form-select" id="exampleFormControlSelect1" aria-label="Default select example" name="complaintType">
                      <option selected>Open this select menu</option>
                      <option value="60001">Parking</option>
                      <option value="60002">Noise</option>
                      <option value="60003">Property</option>
                      <option value="60004">Environment</option>
                      <option value="60005">Waste Management</option>
                    </select>
            <p>Date</p>
                <input type="date" id="dateComplaint" name ="dateComplaint" placeholder="YYYY-MM-DD"/><br>
            <p>Location</p>
                <input type="text" id="location" name="location"/><br>
            <p>Description</p>
                <input type="text" id="description" name="description"/><br>
            <p>Attachment</p>
            <input type="file" id="attachment" name="attachment"/><br>
            <button type="submit" value="Submit" >Submit</button>
            <button type="reset" >Cancel</button>
            <input type="hidden" name="accessType" value="addComplaints">
             <input type="hidden" name="userid" value="<%= userid %>">
        </form>
    </body>
</html>