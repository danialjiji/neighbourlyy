<%-- 
    Document   : VisitorForm
    Created on : Dec 27, 2024, 4:18:26 PM
    Author     : Dean Ardley
--%>


<%@page import="java.util.Arrays"%>
<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.time.*, java.time.format.*, java.util.Date, java.text.SimpleDateFormat"%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:setDataSource var="myDatasource" 
driver="oracle.jdbc.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:XE" user="neighborly" password="system"/>

<!DOCTYPE html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="../styless.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .chart-container {
                width: 68%; /* Adjust width as needed */
                margin: 20px auto; /* Center the chart on the page */
            }
            canvas#myChart {
                max-width: 100%; /* Ensure the chart doesn't overflow */
                height: 400px; /* Set a fixed height */
            }
        </style>
    </head>
    <body>
        
        <!-- Check for Session -->
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="../login.jsp">log in</a>.</p>
        <%
                return;
            }
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid"); // Use implicit session
            String username = (String) session.getAttribute("username");
        %>
        
        <div class="dashboard-container">
            
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="profile">
                    <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                    <h3>Hi, <%= username %></h3>
                
                </div>
            
                <div>
                    <ul>
                        <a href="../dashboardAdmin.jsp">Dashboard</a>
                        <a class="active" href="Visitor.jsp">Visitor</a>
                        <a href="Fee.jsp">Fee</a>
                        <a href="Report.jsp">Report</a>
                        <a href="Complaint.jsp">Complaints</a>
                        <a href="registerGuard.jsp">Registration</a>
                        <a href="userllist1.jsp">User List</a>
                        <a href="../LogoutServlet">Logout</a>
                    </ul>
                </div>
            </aside>

            <!-- Main Content -->
            <div class="content">
                <header class="cardheader">
                    <h1>Visitor</h1>
                    <span>Overview</span>
                </header>
                <div class="form-container">
                    
                    <h3>Search Visitor</h3>
                    <form action="/neighborlyy/VisitorController" method="post">    
                                    
                        <!-- Determine Action -->
                        <input type="hidden" name="accessType" value="search">
                        <input type="text" name="searchVisitorName" placeholder="Search visitor">
                        <div class="btn-container">
                            <button type="submit" class="btn-submit">Search</button>                  
                        </div>
                    
                    </form>
                </div>
                          
            
            
                    <section class="data-table">                    
                <table class="table">
                    
                                   
                    <br><h3>List of Visitors</h3>
                    <thead>
                        
                        <tr>
                            <th>Register ID</th>              
                            <th>Visitor Name</th>
                            <th>IC Number</th>
                            <th>Plate Number</th>
                            <th>Entry Time</th>
                            <th>Exit Time</th>
                            <th>Date</th>
                            <th>Purpose</th>
                            <th>Phone Number</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody
                        <%
                            String searchVisitorName = request.getParameter("searchVisitorName");
                
                            try{                         
                                Connection conn = DBConnection.createConnection();
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM visitor WHERE UPPER(visitor_name) LIKE ?");
                                stmt.setString(1, "%" + searchVisitorName.toUpperCase() + "%");
                                ResultSet rs = stmt.executeQuery();

                            
                                while(rs.next()){
                                    int registerID = rs.getInt("registerID");
                                    int userID = rs.getInt("userID");
                                    String visitorName = rs.getString("visitor_name");
                                    String visitorIC = rs.getString("visitor_ic");
                                    String plateNumber = rs.getString("no_plate");
                                    String entryTime = rs.getString("entryTime");
                                    String exitTime = rs.getString("exitTime");
                                    String dateOfVisit = rs.getString("dateOfVisit");
                                    String purposeOfVisit = rs.getString("purposeOfVisit");
                                    String phoneNumber = rs.getString("visitor_phonenum");
                                    
                               
                                
                                    %>    
                                                                    
                                    <tr>
                                        <td><%= registerID %></td>                         
                                        <td><%= visitorName %></td>
                                        <td><%= visitorIC %></td>
                                        <td><%= plateNumber %></td>
                                        <td><%= entryTime %></td>
                                        <td><%= exitTime %></td>
                                        <td><%= dateOfVisit %></td>
                                        <td><%= purposeOfVisit %></td>
                                        <td><%= phoneNumber %></td>
                            
                                        <td>                                          
                                            <a class="btn-submit" href="UpdateVisitor.jsp?registerID=<%= registerID %>">Edit</a> <br> <br>                         
                              
                                            <a class="btn-submit" href="/neighborlyy/VisitorController?accessType=delete&registerID=<%= registerID %>">Delete</a>
                                
                                        </td>                           
                                    </tr>                                                                                                                                                                                                             
                                    <%                                   
                                }
                                conn.close();
                            }catch(SQLException e){
                                e.printStackTrace();
                            }
                        %>
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
                                                                           
    </body>
</html>
