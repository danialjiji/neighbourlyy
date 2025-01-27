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
url="jdbc:oracle:thin:@localhost:1521:XE" user="proj_neighborly" password="system"/> <!-- Change user -->

<%
    String updateComplaintID = request.getParameter("complaint_type_ID");
    
    int updateUserID = 0;
    int updateStatusID = 0;
    int updateComplaintTypeID = 0;
    String updateComplaintDescription = "";
    String updateComplaintDate = "";
    String updateComplaintStatus = "";
    String updateComplaintLocation = "";
    String updateComplaintAttachment = "";
    
    
    
    
    try{
        Connection conn = DBConnection.createConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM complaint WHERE complaintID=?");
        stmt.setInt(1, Integer.parseInt(updateComplaintID));
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
            updateUserID = rs.getInt("userID");
            updateStatusID = rs.getInt("statusID");
            updateComplaintTypeID = rs.getInt("complaint_type_ID");
            updateComplaintDescription = rs.getString("complaint_description");
            updateComplaintDate = rs.getString("complaint_date");           
            updateComplaintLocation = rs.getString("complaint_location");
            updateComplaintAttachment = rs.getString("complaint_attachment");
            
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
                        <li><a href="registerGuard.jsp">Registeration</a></li>
                        <li><a href="userllist1.jsp">User List</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
                </nav>
            </aside>
        
            
            <!-- Main Content -->
            <main class="main-content">
            
            
                <div class="form-container">
                    <h3>Update Complaint</h3>
                    
                    <form action="/neighborlyy/ComplaintController" method="post" enctype="multipart/form-data">
            
                    <input type="hidden" name="accessType" value="update">
            
                    <%
                        //To formate the entry and exit time
                        DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                                                                                                                                      
                        //To format the date 
                        SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                        Date fullDate = fullFormat.parse(updateComplaintDate);
                        String onlyDate = dateFormat.format(fullDate);
                    %>
            
                    Complaint ID:<input type="text" name="complaintID" value="<%= updateComplaintID %>">
            
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
                                
                    <br><label for="defaultSelect" class="form-label">Complaint Type ID:</label>
                    <select name="complaintTypeID" class="form-select">
              
                                                
                        <option value="<%= updateComplaintTypeID %>" required><%= updateComplaintTypeID %></option>
                        <%
                            try{
                                                
                                Connection conn = DBConnection.createConnection();
                                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM complaint_type");
                                ResultSet rs = stmt.executeQuery();
                                                
                                while(rs.next()){
                                    int complaintTypeID = rs.getInt("complaint_type_ID");
                                    String complaintName = rs.getString("comp_type_name");
                                    %>
                                        <option value="<%= complaintTypeID%>"><%= complaintTypeID%> - <%=complaintName%></option>
                                    <%
                                }
                            }catch(SQLException e){
                                e.printStackTrace();
                            }
                        %>                                                                                                                                                                          
                    </select>
            
                    <br><label class="form-label" for="basic-default-company">Description:</label>
                    <input type="text" class="form-control" id="basic-default-company" name="description" value="<%= updateComplaintDescription %>" required>
                                           
                    <br><label>Date:</label>
                    <input type="date" class="form-control" id="basic-default-fullname" name="complaintDate" value="<%= onlyDate %>" required>                                
                
                    <br><label class="form-label" for="basic-default-company">Location:</label>
                    <input type="text" class="form-control" id="basic-default-company" name="location" value="<%= updateComplaintLocation %>" required>
                                                                                                                                                                                                                                                           
                    <br><label for="formFile" class="form-label">Attachment:</label>
                    <input name="attachment" class="form-control" type="file" id="formFile" />                  
                                                                                          
                    <br><button type="submit" class="btn-submit">Update</button>
                </form>
                    
            </div>

            
                    
            </main>
        </div>
    </body>
</html>
