<%-- 
    Document   : Fee
    Created on : Jan 16, 2025, 10:38:38 AM
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
    <title>Fee</title>
    <link rel="stylesheet" href="../styless.css">
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
            
            <div>
                <ul>
                    <a href="../dashboardAdmin.jsp">Dashboard</a>
                    <a href="Visitor.jsp">Visitor</a>
                    <a class="active" href="Fee.jsp">Fee</a>
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
                    <h1>Fee</h1>
                    <span>Overview</span>
                </header>
            
                <div class="form-container">
                    <h3>Fee Form</h3>
                
                    <form action="/neighborlyy/FeeController" method="post" enctype="multipart/form-data">
            
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
                                
                    <br><label for="defaultSelect" class="form-label">Fee Category ID:</label>
                    <select name="feeCategoryID" class="form-select">
              
                                                
                        <option value="select" required>Select</option>
                        <%
                            try{
                                                
                                Connection conn = DBConnection.createConnection();
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM fee_category");
                                ResultSet rs = stmt.executeQuery();
                                                
                                while(rs.next()){
                                    int fee_category_ID = rs.getInt("fee_category_ID");
                                    String fee_category_name = rs.getString("fee_category_name");
                                    %>
                                        <option value="<%= fee_category_ID%>"><%= fee_category_ID%> - <%=fee_category_name%></option>
                                    <%
                                }
                            }catch(SQLException e){
                                e.printStackTrace();
                            }
                        %>                                                                                                                                                                          
                    </select>
                                
                    <br><label for="defaultSelect" class="form-label">Status ID:</label>
                    <select name="statusID" class="form-select">
                        <option value="select" required>Select</option>
                        <%
                            try{
                                                
                                Connection conn = DBConnection.createConnection();
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM status");
                                ResultSet rs = stmt.executeQuery();
                                                
                                while(rs.next()){
                                    int statusID = rs.getInt("statusID");
                                    String status_description = rs.getString("status_description");
                                    %>
                                        <option value="<%=statusID%>"><%= statusID%> - <%=status_description%></option>
                                    <%
                                }
                            }catch(SQLException e){
                                e.printStackTrace();
                            }
                        %>
                    </select>

                    <br><label>Date:</label>
                    <input type="date" class="form-control" id="basic-default-fullname" name="feeDate">
            
                    <br><label>Fee Amount:</label>
                    <input type="number" name="feeAmount" placeholder="0.00">                                  
                                                                                                                                                             
                    <br><button type="submit" class="btn-submit">Submit</button>
                </form>
                    </div>

            
                    <section class="data-table">                    
                        <table class="table">
                            <h3>List of Fees</h3>
                            <thead>
                                <tr>
                                    <th>Fee ID</th>
                                    <th>User ID</th>                                   
                                    <th>Fee Date</th>
                                    <th>Fee Amount</th>  
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                        
                        
                            </thead>
                    
                            <tbody>
                                <%
                            
                
                                    try{                         
                                        Connection conn = DBConnection.createConnection();
                                        PreparedStatement stmt = conn.prepareStatement("SELECT f.feeID, f.userID, f.fee_date, f.fee_amount, s.status_description FROM fee f JOIN status s ON (f.statusID=s.statusID)");
                                        ResultSet rs = stmt.executeQuery();

                            
                                        while(rs.next()){
                                            int feeID = rs.getInt("feeID");
                                            int userID = rs.getInt("userID");                                         
                                            String feeDate = rs.getString("fee_date");
                                            int feeAmount = rs.getInt("fee_amount"); 
                                            String status_description = rs.getString("status_description");

                       
                                    
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
                                            <td><%= userID %></td>                                           
                                            <td><%= onlyDate %></td>
                                            <td>RM<%= feeAmount %></td> 
                                            <td><%= status_description %></td>
                                                    
                                            <td>                                          
                                                <a class="btn-submit" href="UpdateFee.jsp?feeID=<%= feeID %>">
                                                <i class="ti ti-pencil me-1"></i> Edit</a>
                              
                                                <a class="btn-submit" href="/neighborlyy/FeeController?accessType=delete&feeID=<%= feeID %>">
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
            </div>
        </div>
    </body>
</html>
