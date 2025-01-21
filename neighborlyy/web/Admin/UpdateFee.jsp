<%-- 
    Document   : UpdateFee
    Created on : Jan 17, 2025, 10:33:27 PM
    Author     : Dean Ardley
--%>

<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.time.*, java.time.format.*, java.util.Date, java.text.SimpleDateFormat"%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:setDataSource var="myDatasource" 
driver="oracle.jdbc.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:XE" user="proj_neighborly" password="system"/>
<%
    String updateFeeID = request.getParameter("feeID");
    
    int updateUserID = 0;
    int updateFeeCategoryID = 0;
    int updateStatusID = 0;
    String updateFeeDate = "";
    int updateFeeAmount = 0;
    String updateFeeStatus = "";
    String updateAttachment = "";

    
    
    try{
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "proj_neighborly", "system");
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM fee WHERE feeID=?");
        stmt.setInt(1, Integer.parseInt(updateFeeID));
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            updateUserID = rs.getInt("userID");
            updateFeeCategoryID = rs.getInt("fee_category_ID");
            updateStatusID = rs.getInt("statusID");
            updateFeeDate = rs.getString("fee_date");
            updateFeeAmount = rs.getInt("fee_amount");
            updateFeeStatus = rs.getString("fee_status");
            updateAttachment = rs.getString("attachment");
        }
        
        rs.close();
        stmt.close();
        conn.close();
        
    }catch(SQLException e){
        e.printStackTrace();
    }
%>

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
                        <li><a href="Visitor.jsp">Visitor</a></li>
                        <li class="active"><a href="Fee.jsp">Fee</a></li>
                        <li><a href="Report.jsp">Report</a></li>
                        <li><a href="Complaint.jsp">Complaints</a></li>  
                        <li><a href="registerGuard.jsp">Register Guard</a></li>
                        <li><a href="registerResident.jsp">Register Resident</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
            
            
                <div class="form-container">
                    <h3>Fee Form</h3>
                    
                    <form action="/neighborlyy/FeeController" method="post" enctype="multipart/form-data">
            
                    <input type="hidden" name="accessType" value="update">
            
                    <%
                        //To formate the entry and exit time
                        DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                                                                                                                                      
                        //To format the date 
                        SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                        Date fullDate = fullFormat.parse(updateFeeDate);
                        String onlyDate = dateFormat.format(fullDate);
                    %>
            
                    Fee ID:<input type="text" name="feeID" value="<%= updateFeeID %>">
            
                    <br><label for="defaultSelect" class="form-label">User ID:</label>
                    <select name="userID" class="form-select">
                        <sql:query var="result" dataSource="${myDatasource}">
                            SELECT userID FROM admin
                        </sql:query>
                                                
                        <option value="<%= updateUserID %>" required><%= updateUserID %></option>
                        <c:forEach var="row" items="${result.rowsByIndex}">
                            <c:forEach var="column" items="${row}">
                                <option value="${column}"><c:out value="${column}"/></option>
                            </c:forEach>
                        </c:forEach>                                                                                                                                                                           
                    </select>                    
                                
                    <br><label for="defaultSelect" class="form-label">Fee Category ID:</label>
                    <select name="feeCategoryID" class="form-select">
              
                                                
                        <option value="<%= updateFeeCategoryID %>" required><%= updateFeeCategoryID %></option>
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
                        <option value="<%= updateStatusID %>" required><%= updateStatusID %></option>
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
                    <input type="date" class="form-control" id="basic-default-fullname" name="feeDate" value="<%= onlyDate %>" required>
            
                    <br><label class="form-label" for="basic-default-company">Fee Amount:</label>
                    <input type="number" class="form-control" id="basic-default-company" name="feeAmount" placeholder="0.00" value="<%= updateFeeAmount %>" required>

                    <br><label for="defaultSelect" class="form-label">Fee Status:</label>
                    <select name="feeStatus" class="form-select">
                        <option value="<%= updateFeeStatus %>"><%= updateFeeStatus %></option>
                        <option value="Active">Active</option>
                    <option value="Pending">Pending</option>
                        <option value="Completed">Completed</option>                                                                                                                                                                                                   
                    </select>                  
                                
                <br><label for="formFile" class="form-label">Attachment:</label>
                <input name="attachment" class="form-control" type="file" id="formFile" />                  
                                                                                          
                    <br><button type="submit" class="btn-submit">Update</button>
                </form>
                    
                </div>

            
                    
            </main>
        </div>                
    </body>
</html>
