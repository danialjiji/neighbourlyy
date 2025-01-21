<%-- 
    Document   : dashboard.jsp
    Created on : Jan 19, 2025, 12:26:04 AM
    Author     : USER
--%>


<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="util.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.time.*, java.time.format.*, java.util.Date, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
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
    
    
    
    <div class="dashboard-container">
        
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
            
            
            <nav class="menu">
                <ul>
                    <li class="active"><a href="dashboardAdmin.jsp">Dashboard</a></li>
                    <li><a href="./Admin/Visitor.jsp">Visitor</a></li>
                    <li><a href="./Admin/Fee.jsp">Fee</a></li>
                    <li><a href="./Admin/Report.jsp">Report</a></li>
                    <li><a href="./Admin/Complaint.jsp">Complaints</a></li> 
                    <li><a href="./Admin/registerGuard.jsp">Registeration</a></li>
                    <li><a href="./Admin/userllist1.jsp">List User</a></li>
                    <li><a href="LogoutServlet">Logout</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Dashboard</h1>
                <span>Overview</span>
            </header>
            
            <%
                Connection conn = DBConnection.createConnection();
                
                PreparedStatement stmt1 = conn.prepareStatement("SELECT COUNT(*) AS TotalVisitors FROM visitor");                                                                                                                                        
                ResultSet rs1 = stmt1.executeQuery();
                
                PreparedStatement stmt2 = conn.prepareStatement("SELECT COUNT(*) AS TotalComplaints FROM complaint");
                ResultSet rs2 = stmt2.executeQuery();
                
                PreparedStatement stmt3 = conn.prepareStatement("SELECT COUNT(*) AS TotalReports FROM report");                                                                                                                                        
                ResultSet rs3 = stmt3.executeQuery();
                
                PreparedStatement stmt4 = conn.prepareStatement("SELECT COUNT(*) AS TotalFees FROM fee");
                ResultSet rs4 = stmt4.executeQuery();
                
                
                if(rs1.next() && rs2.next() && rs3.next() && rs4.next()){
                    
                
            %>
            <section class="cards">
                <div class="card">
                    <h2>Visitors</h2>
                    <p class="amount"><%= rs1.getInt("TotalVisitors")%></p>                  
                </div>
                <div class="card">
                    <h2>Complaints</h2>
                    <p class="amount"><%= rs2.getInt("TotalComplaints")%></p>                 
                </div>
                <div class="card">
                    <h2>Reports</h2>
                    <p class="amount"><%= rs3.getInt("TotalReports")%></p>                   
                </div>
                
                <div class="card">
                    <h2>Fees</h2>
                    <p class="amount"><%= rs4.getInt("TotalFees")%></p>                   
                </div>
            </section>
            
            <%
                }
            %>

            

            
            
            <section class="data-table">
                <h3>Pending Complaints</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Complaints ID</th>
                            <th>Description</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Attachment</th>                               
                        </tr>
                    </thead>
                    <tbody>
                        <%
                
                            try{                         
                                Connection conn2 = DBConnection.createConnection();
                                PreparedStatement stmt = conn2.prepareStatement("SELECT c.complaintID, c.complaint_description, c.complaint_date, c.complaint_location, s.status_description, c.complaint_attachment FROM complaint c JOIN status s ON c.statusID=s.statusID WHERE s.status_description='Pending'");
                                ResultSet rs = stmt.executeQuery();

                            
                                    while(rs.next()){
                                        int complaintID = rs.getInt("complaintID");
                                        String description = rs.getString("complaint_description");                                        
                                        String complaintDate = rs.getString("complaint_date");                                           
                                        String complaintLocation = rs.getString("complaint_location");
                                        String status = rs.getString("status_description");
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
                                                <td><%= description %></td>
                                                <td><%= onlyDate %></td>
                                                <td><%= complaintLocation %></td>                                                                                            
                                                <td><%= status %></td>                                              
                                                <td><%= complaintAttachment %></td>                            
                                                                          
                                            </tr>                                                                                                                                                                                                             
                                        <%                                   
                                    }
                                    stmt.close();
                                    conn.close();
                                        
                                }catch(SQLException e){
                                    e.printStackTrace();
                                }
                        %>
                        </tbody>
                    </table>                                                                                                                   
            </section>
                        
            <section class="data-table">
                <h3>Completed Fees</h3>     
                    <table class="table">
                        
                        <thead>
                            <tr>
                                <th>Fee ID</th>
                                <th>Fee Category</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>                               
                                <th>Attachment</th>                               
                            </tr>
                        </thead>
                        <tbody>
                            <%
                
                                try{                         
                                    Connection conn2 = DBConnection.createConnection();
                                    PreparedStatement stmt = conn2.prepareStatement("SELECT f.feeID, fc.fee_category_name, f.fee_date, f.fee_amount, s.status_description, f.attachment FROM fee f JOIN status s ON f.statusID=s.statusID JOIN fee_category fc ON f.fee_category_ID = fc.fee_category_ID WHERE s.status_description='Completed'");
                                    ResultSet rs = stmt.executeQuery();

                            
                                    while(rs.next()){
                                        int feeID = rs.getInt("feeID");
                                        String feeCategory = rs.getString("fee_category_name");
                                        String feeDate = rs.getString("fee_date"); 
                                        int feeAmount = rs.getInt("fee_amount");                                        
                                        String status = rs.getString("status_description");                                                                                                                           
                                        String feeAttachment = rs.getString("attachment");
                                                                                                    
                                        //To formate the entry and exit time
                                        DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");                                                                                                      
                                    
                                        //To format the date 
                                        SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                                        Date fullDate = fullFormat.parse(feeDate);
                                        String onlyDate = dateFormat.format(fullDate);
                                    
                            
                                
                                        %>    
                                                                    
                                            <tr>
                                                <td><%= feeID %></td>   
                                                <td><%= feeCategory %></td> 
                                                <td><%= onlyDate %></td>
                                                <td>RM<%= feeAmount %></td>                                                                                            
                                                <td><%= status %></td>                                              
                                                <td><%= feeAttachment %></td>                            
                                                                          
                                            </tr>                                                                                                                                                                                                             
                                        <%                                   
                                    }
                                    stmt.close();
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
