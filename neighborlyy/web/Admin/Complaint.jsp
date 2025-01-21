<%-- 
    Document   : Complaint
    Created on : Jan 19, 2025, 11:01:00 AM
    Author     : Dean Ardley
--%>

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
    <link rel="stylesheet" href="../style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
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
            
            
                <nav class="menu">
                    <ul>
                        <li><a href="../dashboardAdmin.jsp">Dashboard</a></li>
                        <li><a href="Visitor.jsp">Visitor</a></li>
                        <li><a href="Fee.jsp">Fee</a></li>
                        <li><a href="Report.jsp">Report</a></li>
                        <li class="active"><a href="Complaint.jsp">Complaints</a></li>  
                        <li><a href="registerGuard.jsp">Register Guard</a></li>
                        <li><a href="registerResident.jsp">Register Resident</a></li>
                        <li><a href=../LogoutServlet">Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                                                                      
                    <section class="data-table">                    
                        <table class="table">
                            <h3>List of Complaints</h3>
                            <thead>
                                
                                <tr>
                                    <th>Complaint ID</th>
                                    <th>User ID</th>                                  
                                    <th>Description</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Location</th>
                                    <th>Attachment</th>
                                    <th>Action</th>
                                </tr>
                        
                            </thead>
                    
                            <tbody>
                                <%
                
                                    try{                         
                                        Connection conn = DBConnection.createConnection();
                                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM complaint");
                                        ResultSet rs = stmt.executeQuery();

                            
                                        while(rs.next()){
                                            int complaintID = rs.getInt("complaintID");
                                            int userID = rs.getInt("userID");
                                            int statusID = rs.getInt("statusID");                      
                                            int complaintTypeID = rs.getInt("complaint_type_ID");
                                            String complaintDescription = rs.getString("complaint_description");
                                            String complaintDate = rs.getString("complaint_date");
                                            String complaintStatus = rs.getString("complaint_status");
                                            String complaintLocation = rs.getString("complaint_location");
                                            String complaintAttachment = rs.getString("complaint_attachment");
                        
                                    
                                            //To formate the entry and exit time
                                            DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");                                                                                                      
                                    
                                            //To format the date 
                                            SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                                            Date fullDate = fullFormat.parse(complaintDate);
                                            String onlyDate = dateFormat.format(fullDate);
                                    
                            
                                
                                            %>    
                                                                    
                                            <tr>
                                                <td><%= complaintID %></td>
                                                <td><%= userID %></td>                                               
                                                <td><%= complaintDescription %></td>
                                                <td><%= onlyDate %></td>
                                                <td><%= complaintStatus %></td>
                                                <td><%= complaintLocation %></td>
                                                <td><%= complaintAttachment %></td>                            
                                                <td>                                          
                                                    <a class="btn-submit" href="UpdateComplaint.jsp?complaint_type_ID=<%= complaintID %>">
                                                    <i class="ti ti-pencil me-1"></i> Edit</a>
                              
                                                    <a class="btn-submit" href="/neighborlyy/ComplaintController?accessType=delete&complaintID=<%= complaintID %>">
                                                    <i class="ti ti-trash me-1"></i> Delete</a>
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
            </main>
        </div>                    
    </body>
</html>
