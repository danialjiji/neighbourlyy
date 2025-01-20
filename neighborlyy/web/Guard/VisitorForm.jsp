<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visitor Form</title>
        <link rel="stylesheet" href="../style.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
    </head>
    <body>
    <div class="dashboard-container">
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
        
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
            
            
            <nav class="menu">
                <ul>
                    <li><a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a></li>
                    <li><a href="RoundingReport.jsp">Rounding Report</a></li>
                    <li><a href="RoundingReportTable.jsp">Rounding Report List</a></li>
                    <li class="active"><a href="VisitorForm.jsp">Visitor Form</a></li>
                    <li><a href="VisitorTable.jsp">Visitor List</a></li>
                    <li><a href="/neighborlyy/LogoutServlet.java" class="btn-add-project">Logout</a></li>
                </ul>
            </nav>
        </aside>
        
        <main class="main-content">
            <div class="form-container">
                <h3>Visitor Form</h3>
                <p>Please fill all informations</p>
                <form action="/neighborlyy/securityController" method="POST" enctype="multipart/form-data">
                    <label for="visitorname">Visitor's Name</label>
                    <input type="text" name="visitorname" placeholder="Name" required/>

                    <label for="icpassport">IC/Passport</label>
                    <input type="text" name="icpassport" placeholder="IC/Passport" required/>

                    <label for="plateno">Plate Number</label>
                    <input type="text" name="plateno" placeholder="Plate Number" required/>

                    <label for="purposevisit">Purpose of Visit</label>
                    <input type="text" name="purposevisit" placeholder="Purpose of Visit" required/>

                    <label for="phoneno">Phone Number</label>
                    <input type="text" name="phoneno" placeholder="Phone Number" required/>

                    <label for="entrytime">Entry Time</label>
                    <input type="time" name="entrytime" required/>

                    <label for="datevisit">Date of Visit</label>
                    <input type="date" name="datevisit" required/>
                    <p></p>

                    <div class="btn-container">
                        <button type="submit" class="btn-submit">Submit</button>
                        <button type="reset" class="btn-cancel">Cancel</button>
                    </div>
                    <input type="hidden" name="accessType" value="addVisitor">
                    <input type="hidden" name="userid" value="<%= userid %>"> <!-- Set the userid dynamically -->
                </form>
            </div>
        </main>
    </div>
    </body>
</html>
        