<%@page import="java.text.SimpleDateFormat"%>
<%@page import="util.DBConnection"%>
<%@page import="java.sql.*"%>
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
        <div class="dashboard-container">
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
        
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
            
            
            <nav class="menu">
                <ul>
                    <li class="active"><a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a></li>
                    <li><a href="./Guard/profileGuard.jsp">Profile</a></li>
                    <li><a href="./Guard/RoundingReport.jsp">Rounding Report</a></li>
                    <li><a href="./Guard/RoundingReportTable.jsp">Rounding Report List</a></li>
                    <li><a href="./Guard/VisitorForm.jsp">Visitor Form</a></li>
                    <li><a href="./Guard/VisitorTable.jsp">Visitor List</a></li>
                    <li><a href="./Guard/userlist.jsp">Users List</a></li>
                    <li><a href="LogoutServlet">Logout</a></li>
                </ul>
            </nav>
        </aside>
        
            <main class="main-content">
            <header class="cardheader">
                <h1>Welcome to the Dashboard, <%= username %>!</h1>
                <span>Your User ID: <%= userid %></span>
            </header>
                <%
                    try {
                        Connection conn = DBConnection.createConnection();

                        // Query to get the count of reports for the user
                        String reportCountQuery = "SELECT COUNT(*) AS reportCount FROM report WHERE userid = ?";
                        PreparedStatement reportCountStmt = conn.prepareStatement(reportCountQuery);
                        reportCountStmt.setInt(1, userid);
                        ResultSet reportCountRs = reportCountStmt.executeQuery();
                        int totalReports = 0;
                        if (reportCountRs.next()) {
                            totalReports = reportCountRs.getInt("reportCount");
                        }

                        // Query to check if the user has submitted a report for today
                        String todayReportQuery = "SELECT COUNT(*) AS todayReports FROM report WHERE userid = ? AND TRUNC(dateofvisit) = TRUNC(SYSDATE)";
                        PreparedStatement todayReportStmt = conn.prepareStatement(todayReportQuery);
                        todayReportStmt.setInt(1, userid);
                        ResultSet todayReportRs = todayReportStmt.executeQuery();
                        int submittedToday = 0;
                        if (todayReportRs.next()) {
                            submittedToday = todayReportRs.getInt("todayReports");
                        }

                        // Query to get the total number of visitors for today
                        String visitorsTodayQuery = "SELECT COUNT(*) AS visitorCount FROM visitor WHERE TRUNC(entrytime) = TRUNC(SYSDATE)";
                        PreparedStatement visitorsTodayStmt = conn.prepareStatement(visitorsTodayQuery);
                        ResultSet visitorsTodayRs = visitorsTodayStmt.executeQuery();
                        int totalVisitors = 0;
                        if (visitorsTodayRs.next()) {
                            totalVisitors = visitorsTodayRs.getInt("visitorCount");
                        }

                        // Query to get the total number of visitors who exited today
                        String visitorsExitedQuery = "SELECT COUNT(*) AS exitedCount FROM visitor WHERE TRUNC(entrytime) = TRUNC(SYSDATE) AND exittime IS NOT NULL";
                        PreparedStatement visitorsExitedStmt = conn.prepareStatement(visitorsExitedQuery);
                        ResultSet visitorsExitedRs = visitorsExitedStmt.executeQuery();
                        int totalExitedVisitors = 0;
                        if (visitorsExitedRs.next()) {
                            totalExitedVisitors = visitorsExitedRs.getInt("exitedCount");
                        }
                        
                %>
                <section class="cards">
                    <div class="card">
                        <h2>Rounding Reports</h2>
                        <p class="amount">Submitted Today: <%= submittedToday %></p>
                        <p class="status increased">Total Reports Submitted  <%= totalReports %></p>
                    </div>
                    <div class="card">
                        <h2>Visitors</h2>
                        <p class="amount">Visitor In: <%= totalVisitors %></p>
                        <p class="amount">Visitor Out: <%= totalExitedVisitors %></p>
                    </div>
                </section>

                <section class="data-table">
                    <h3>Visitors Entry List</h3>
                <table class="table">
                    <thead>
                        <tr>    
                            <th>ID</th>
                            <th>Visitor's Name</th>
                            <th>IC/Passport</th>
                            <th>Plate Number</th>
                            <th>Entry Time</th>
                            <th>Exit Time</th>
                            <th>Date</th>
                            <th>Purpose</th>
                            <th>Phone No</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    
                <%
                    //Query to show visitor in
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM visitor WHERE exittime IS NULL ");
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        int registerID = rs.getInt("registerid");
                        String visitorName = rs.getString("visitor_name");
                        if (visitorName == null) visitorName = "N/A";

                        String icpassport = rs.getString("visitor_ic");
                        if (icpassport == null) icpassport = "N/A";

                        String plateNo = rs.getString("no_plate");
                        if (plateNo == null) plateNo = "N/A";

                        Time entryTime = rs.getTime("entrytime");
                        String entryTimeOnly = (entryTime != null) ? new SimpleDateFormat("HH:mm").format(entryTime) : "N/A";

                        Time exitTime = rs.getTime("exittime");
                        String exitTimeOnly = (exitTime != null) ? new SimpleDateFormat("HH:mm").format(exitTime) : "N/A";

                        Date dateVisit = rs.getDate("dateofvisit");
                        String onlyDate = (dateVisit != null) ? new SimpleDateFormat("yyyy-MM-dd").format(dateVisit) : "N/A";

                        String purposeVisit = rs.getString("purposeofvisit");
                        if (purposeVisit == null) purposeVisit = "N/A";

                        String phoneNum = rs.getString("visitor_phonenum");
                        if (phoneNum == null) phoneNum = "N/A";
                %>
                    
                    <tbody>
                        <tr>
                           <td><%= registerID %></td>
                           <td><%= visitorName %></td>
                           <td><%= icpassport %></td>
                           <td><%= plateNo %></td>
                           <td><%= entryTimeOnly %></td>
                           <td><%= exitTimeOnly %></td>
                           <td><%= onlyDate %></td>
                           <td><%= purposeVisit %></td>
                           <td><%= phoneNum %></td>
                           <td>
                               <a href="/neighborlyy/securityController?accessType=editVisitor&id=<%= registerID %>" class="btn-submit">Exit</a>
                               <a href="/neighborlyy/securityController?accessType=deleteVisitor&id=<%= registerID %>" class="btn-submit">Delete</a>
                           </td>
                        </tr>
                   </tbody>
                <%
                        } conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
                    </table>
                </section>
            </main>
        </div>
    </body>
</html>
