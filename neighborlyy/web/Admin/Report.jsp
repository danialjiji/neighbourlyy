<%-- 
    Document   : Report
    Created on : Jan 16, 2025, 2:16:32 PM
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
                        <li class="active"><a href="Report.jsp">Report</a></li>
                        <li><a href="Complaint.jsp">Complaints</a></li>  
                        <li><a href="registerGuard.jsp">Registeration</a></li>
                        <li><a href="userllist1.jsp">User List</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                
                <div class="form-container">
                    <h3>Report Form</h3>
                    
                    <form action="/neighborlyy/ReportController" method="post" enctype="multipart/form-data">                         
                        <input type="hidden" name="accessType" value="add">
            
                        <label>User ID:</label>
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

                        <br><label>Date:</label>
                        <input type="date" class="form-control" id="basic-default-fullname" name="reportDate">
            
                        <br><label class="form-label">Location:</label>
                        <input type="text" name="location" class="form-control">
                                    
                        <br><label class="form-label">Remarks:</label>
                        <textarea name="remarks"></textarea>                        
                     
                        <br><label for="formFile" class="form-label">Attachment</label>
                        <input name="attachment" class="form-control" type="file" id="formFile" />                                                                                                                         

                        <br><button type="submit" class="btn-submit">Submit</button>
                    </form>
                    
                </div>
                                          
                    <section class="data-table">                    
                        <table class="table">
                            <h3>List of Reports</h3>
                            <thead>
                                
                                <tr>
                                    <th>Report ID</th>
                                    <th>User ID</th>
                                    <th>Date</th>
                                    <th>Location</th>
                                    <th>Remarks</th>
                                    <th>Attachment</th>
                                    <th>Action</th>
                                </tr>
                        
                            </thead>
                    
                            <tbody>
                                <%
                
                                    try{                         
                                        Connection conn = DBConnection.createConnection();
                                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM report");
                                        ResultSet rs = stmt.executeQuery();

                            
                                        while(rs.next()){
                                            int reportID = rs.getInt("reportID");
                                            int userID = rs.getInt("userID");
                                            String reportDate = rs.getString("dateOfVisit");
                        
                                            String location = rs.getString("location");
                                            String remarks = rs.getString("remarks");
                                            String attachment = rs.getString("attachment");
                       
                                    
                                            //To formate the entry and exit time
                                            DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                                                                                                                                            
                                            //To format the date 
                                            SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                                            Date fullDate = fullFormat.parse(reportDate);
                                            String onlyDate = dateFormat.format(fullDate);
                                    
                                                         
                                %>    
                                                                       
                                            <tr>
                                                <td><%= reportID %></td>
                                                <td><%= userID %></td>
                                                <td><%= onlyDate %></td>
                                                <td><%= location %></td>
                                                <td><%= remarks %></td>
                                                <td><%= attachment %></td>
                                                    
                                                <td>                                          
                                                    <a class="btn-submit" href="UpdateReport.jsp?reportID=<%= reportID %>">
                                                    <i class="ti ti-pencil me-1"></i> Edit</a>
                              
                                                    <a class="btn-submit" href="/neighborlyy/ReportController?accessType=delete&reportID=<%= reportID %>">
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
