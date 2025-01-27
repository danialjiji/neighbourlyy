<%-- 
    Document   : UpdateVisitor
    Created on : Jan 16, 2025, 10:27:45 AM
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
    String updateRegisterID = request.getParameter("registerID");
    
    int updateUserID = 0;  
    String updateVisitorName = "";
    String updateVisitorIC = "";
    String updatePlateNumber = "";
    String updateEntryTime = "";
    String updateExitTime = "";
    String updateVisitDate = "";
    String updatePurposeOfVisit = "";
    String updatePhoneNumber = "";
    
    if(updateRegisterID != null && !updateRegisterID.trim().isEmpty()){
        try{
            Connection conn = DBConnection.createConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM visitor WHERE registerID = ?");
            stmt.setInt(1, Integer.parseInt(updateRegisterID));
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()){
                updateUserID = rs.getInt("userID");
                updateVisitorName = rs.getString("visitor_name");
                updateVisitorIC = rs.getString("visitor_ic");
                updatePlateNumber = rs.getString("no_plate");
                updateEntryTime = rs.getString("entryTime");
                updateExitTime = rs.getString("exitTime");
                updateVisitDate = rs.getString("dateOfVisit");
                updatePurposeOfVisit = rs.getString("purposeOfVisit");
                updatePhoneNumber = rs.getString("visitor_phonenum");
                                            
            }
                             
            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
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
                    <li class="active"><a href="Visitor.jsp">Visitor</a></li>
                    <li><a href="Fee.jsp">Fee</a></li>
                    <li><a href="Report.jsp">Report</a></li>
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
                <h3>Update Visitor</h3>
                
                <form action="/neighborlyy/VisitorController" method="post">
                                    
                                    
            <!-- Determine Action -->
            <input type="hidden" name="accessType" value="update">
            <%
                                        //To formate the entry and exit time
                DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
                                    
                LocalDateTime entry = LocalDateTime.parse(updateEntryTime, fullFormatter);
                LocalDateTime exit = LocalDateTime.parse(updateExitTime, fullFormatter);
                                    
                String entryTimeOnly = entry.format(timeFormatter);
                String exitTimeOnly = exit.format(timeFormatter);
                                   
                //To format the date 
                SimpleDateFormat fullFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    
                Date fullDate = fullFormat.parse(updateVisitDate);
                String onlyDate = dateFormat.format(fullDate);
            %>
            <!-- User Input -->
            <label>Register ID</label>
            <input type="text" name="registerID" placeholder="Register ID" value="<%= updateRegisterID %>" readonly>
            
            <br><label for="defaultSelect" class="form-label">User ID</label>
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
                                  
                                    
                <br><label class="form-label">Visitor Name:</label>
                <input type="text" class="form-control" id="basic-default-fullname" name="visitorName" placeholder="Enter visitor name" value="<%= updateVisitorName%>" required>                    
                
                <br><label class="form-label">Visitor IC:</label>
                <input type="text" class="form-control" id="basic-default-fullname" name="visitorIC" placeholder="Enter visitor name" value="<%= updateVisitorIC%>" required>
                
                <br><label class="form-label">Plate Number:</label>
                <input type="text" class="form-control" id="basic-default-fullname" name="plateNumber" placeholder="Enter plate number" value="<%= updatePlateNumber %>" required>
                
                <br><label class="form-label">Entry Time:</label>
                <input type="time" class="form-control" id="basic-default-fullname" name="entryTime" value="<%= entryTimeOnly %>" required>
                                    
                <br><label class="form-label">Exit Time:</label>
                <input type="time" class="form-control" id="basic-default-fullname" name="exitTime" value="<%= exitTimeOnly %>" required>
                                    
                <br><label class="form-label">Date of Visit:</label>
                <input type="date" class="form-control" id="basic-default-fullname" name="visitDate" value="<%= onlyDate %>" required>
                                    
                <br><label class="form-label">Purpose of Visit:</label>
                <textarea type="text" name="purposeOfVisit" id="basic-default-message"
                class="form-control"
                value="<%= updatePurposeOfVisit %>" required><%= updatePurposeOfVisit %></textarea>
                                    
                <br><label class="form-label">Phone Number:</label>
                <input type="tel" class="form-control" id="basic-default-fullname" placeholder="Enter phone number" name="phoneNumber" value="<%= updatePhoneNumber %>" required>                                                                   

                <br><button type="submit" class="btn-submit">Update</button>
            </form>
        </div>

            
          
            
        
             

   
            </main>
        </div>
        
         
    </body>
</html>
