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
        <title>Fee form</title>
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
        <form action="feeServlet" method="POST" enctype="multipart/form-data">
            <label for="exampleFormControlSelect1" class="form-label">Fee type</label>
                    <select class="form-select" id="exampleFormControlSelect1" aria-label="Default select example" name="feeType">
                      <option selected>Open this select menu</option>
                      <option value="80001">Maintenance</option>
                      <option value="80002">Quit Rent</option>
                      <option value="80003">Insurance</option>
                    </select>
            <p>Amount</p>
                <input type="text" id="amount" name="amount"/><br>
            <p>Date</p>
                <input type="date" id="feeDate" name ="dateFee" placeholder="YYYY-MM-DD"/><br>
            <p>Attachment</p>
            <input type="file" id="receipt" name="receipt"/><br>
            <button type="submit" value="Submit" >Submit</button>
            <button type="reset" >Cancel</button>
            <input type="hidden" name="accessType" value="addFee">
             <input type="hidden" name="userid" value="<%= userid %>">
        </form>
    </body>
</html>