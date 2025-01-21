<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%> <!-- here -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rounding Report Form</title>
        <link rel="stylesheet" href="../style.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="dashboard-container">
            <!-- here -->
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return;
            }
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid");
            String username = (String) session.getAttribute("username");
        %>
        <!-- untill here -->
        
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="profile">
                    <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                    <h3>Hi, <%= username %></h3>

                </div>


                <nav class="menu">
                    <ul>
                        <li><a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a></li>
                        <li class="active"><a href="RoundingReport.jsp">Rounding Report</a></li>
                        <li><a href="RoundingReportTable.jsp">Rounding Report List</a></li>
                        <li><a href="VisitorForm.jsp">Visitor Form</a></li>
                        <li><a href="VisitorTable.jsp">Visitor List</a></li>
                        <li><a href="/neighborlyy/LogoutServlet.java" class="btn-add-project">Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <main class="main-content">
              <h1>Rounding Report Form</h1>
                <div class="form-container">
                    <h3>Rounding Report Form</h3>
                    <p>Please fill all informations</p>
                                    <!-- change here -->
                    <form action="/neighborlyy/securityController" method="POST" enctype="multipart/form-data">
                        <label for="dateReport">Date of Report</label>
                        <input type="date" name ="dateReport" placeholder="YYYY-MM-DD"/>
                        <p></p>
                        <label for="location">Location</location>
                        <input type="text" name="location" placeholder="Location"/>
                        
                        <label for="remarks">Remarks</label>
                        <input type="text" name="remarks" placeholder="Remarks"/>
                        
                        <label for="attachment">Attachment</label>
                        <input type="file" name="attachment"/>
                        
                        <div class="btn-container">
                            <button type="submit" value="Submit" class="btn-submit" >Submit</button>
                            <button type="reset" class="btn-cancel" >Cancel</button>
                        </div>
                        <input type="hidden" name="accessType" value="addReport">
                        <input type="hidden" name="userid" value="<%= userid %>"> <!-- here -->
                    </form>
        </div>
    </body>
</html>
