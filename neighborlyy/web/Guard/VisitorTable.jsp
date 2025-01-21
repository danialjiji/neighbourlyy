<%@page import="util.DBConnection"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Visitor</title>
        <link rel="stylesheet" href="..\style.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
    </head>
    
    <style>
        .sidebar{
            height:100vh;
        }
    </style>
    
    <body>
        <div class="dashboard-container">
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return;
            }

            String username = (String) session.getAttribute("username");
        %>
        
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
            
            
            <nav class="menu">
                <ul>
                    <li><a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a></li>
                    <li><a href="RoundingReport.jsp">Rounding Report</a></li>
                    <li><a href="RoundingReportTable.jsp">Rounding Report List</a></li>
                    <li><a href="VisitorForm.jsp">Visitor Form</a></li>
                    <li class="active"><a href="VisitorTable.jsp">Visitor List</a></li>
                    <li><a href="../LogoutServlet" class="btn-add-project">Logout</a></li>
                </ul>
            </nav>
        </aside>
        
        <main class="main-content">
            <h1>List Visitor</h1>
            
            <section class="data-table">
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
                        Connection conn = null;
                        try {
                            conn = DBConnection.createConnection();
                            if (conn == null) {
                                throw new SQLException("Database connection is null");
                            }
                            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM visitor");
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
                            }
                            conn.close();
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
