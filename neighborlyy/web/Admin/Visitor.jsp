<%-- 
    Document   : VisitorForm
    Created on : Dec 27, 2024, 4:18:26 PM
    Author     : Dean Ardley
--%>


<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.time.*, java.time.format.*, java.util.Date, java.text.SimpleDateFormat"%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:setDataSource var="myDatasource" 
driver="oracle.jdbc.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:XE" user="proj_neighborly" password="system"/>

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
            
            
                <nav class="menu">
                    <ul>
                        <li><a href="../dashboardAdmin.jsp">Dashboard</a></li>
                        <li class="active"><a href="Visitor.jsp">Visitor</a></li>
                        <li><a href="Fee.jsp">Fee</a></li>
                        <li><a href="Report.jsp">Report</a></li>
                        <li><a href="Complaint.jsp">Complaints</a></li>  
                        <li><a href="../registerGuard1.jsp">Register Guard</a></li>
                        <li><a href="../registerResident1.jsp">Register Resident</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
            
            
                <div class="form-container">
                    <h3>Visitor Form</h3>
                
                    <form action="/neighborlyy/VisitorController" method="post">    
                                    
                    <!-- Determine Action -->
                    <input type="hidden" name="accessType" value="add">
                                    
                    <!-- User Input -->                          
                    <label>User ID</label>
                    <select name="userID">
                        <sql:query var="result" dataSource="${myDatasource}">
                            SELECT userID FROM admin
                        </sql:query>
                                                
                        <option value="select" required>Select</option>
                        <c:forEach var="row" items="${result.rowsByIndex}">
                            <c:forEach var="column" items="${row}">
                                <option value="${column}"><c:out value="${column}"/></option>
                            </c:forEach>
                        </c:forEach>                                                                                                                                                                           
                    </select>
                                                                                                     
                    <br><label>Visitor Name:</label>
                    <input type="text" name="visitorName" placeholder="Enter visitor name">
                                                                                                         
                    <br><label>IC Number:</label>
                    <input type="text" name="visitorIC" placeholder="Enter IC number">
                                                                      
                    <br><label class="form-label">Plate Number:</label>
                    <input type="text" name="plateNumber" placeholder="Enter plate number">
                                                                     
                    <br><label>Entry Time:</label>
                    <input type="time" name="entryTime">
                                                                     
                    <br><label>Exit Time:</label>
                    <input type="time" name="exitTime">
                                                                    
                    <br><label>Date of Visit:</label>
                    <input type="date" name="visitDate">
                                                                    
                    <br><label>Purpose of Visit:</label>
                    <textarea type="text" name="purposeOfVisit" placeholder="Hi, Do you have a moment to talk Gaeul?"></textarea>
                               
                    <br><label>Phone Number:</label>
                    <input type="tel" placeholder="Enter phone number" name="phoneNumber">                                         
            
                    <div class="btn-container">
                        <button type="submit" class="btn-submit">Submit</button>                  
                    </div>
                </form>
            </div>

            
            <section class="data-table">                    
                <table class="table">
                    <h3>List of Visitors</h3>
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
                            
                
                            try{                         
                                Connection conn = DBConnection.createConnection();
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM visitor");
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
                                    
                                    //To formate the entry and exit time
                                    DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                                    
                                    LocalDateTime entry = LocalDateTime.parse(entryTime, fullFormatter);
                                    LocalDateTime exit = LocalDateTime.parse(exitTime, fullFormatter);
                                    
                                    String entryTimeOnly = entry.format(timeFormatter);
                                    String exitTimeOnly = exit.format(timeFormatter);
                                    
                                    //To format the date 
                                    SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                                    Date fullDate = fullFormat.parse(dateOfVisit);
                                    String onlyDate = dateFormat.format(fullDate);
                                    
                            
                                
                                    %>    
                                                                    
                                    <tr>
                                        <td><%= registerID %></td>                         
                                        <td><%= visitorName %></td>
                                        <td><%= visitorIC %></td>
                                        <td><%= plateNumber %></td>
                                        <td><%= entryTimeOnly %></td>
                                        <td><%= exitTimeOnly %></td>
                                        <td><%= onlyDate %></td>
                                        <td><%= purposeOfVisit %></td>
                                        <td><%= phoneNumber %></td>
                            
                                        <td>                                          
                                            <a class="btn-submit" href="UpdateVisitor.jsp?registerID=<%= registerID %>">Edit</a>                            
                              
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
            
            </main>
        </div>
               
    </body>
</html>
