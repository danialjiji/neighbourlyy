<%-- 
    Document   : Complaint
    Created on : Jan 19, 2025, 11:01:00 AM
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
    <title>Complaint</title>
    <link rel="stylesheet" href="../styless.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Complaint</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .chart-container {
                width: 68%; /* Adjust width as needed */
                margin: 20px auto; /* Center the chart on the page */
            }
            canvas#myChart {
                max-width: 100%; /* Ensure the chart doesn't overflow */
                height: 600px; /* Set a fixed height */
            }
        </style>
        
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
                        <a href="Fee.jsp">Fee</a>
                        <a href="Report.jsp">Report</a>
                        <a class="active" href="Complaint.jsp">Complaints</a>
                        <a href="registerGuard.jsp">Registration</a>
                        <a href="userllist1.jsp">User List</a>
                        <a href="../LogoutServlet">Logout</a>
                    </ul>
                </div>
            </aside>
                    
                    
     

            <!-- Main Content -->
            <div class="content">
                <header class="cardheader">
                    <h1>Complaints</h1>
                    <span>Overview</span>
                </header>
                
                <h3>Complaints per Month</h3>
                <!-- Chart Container -->
                <div class="chart-container">
                    <canvas id="myChart"></canvas>
                </div>
                                                                     
                    <section class="data-table">                    
                        <table class="table">
                            
                            
                            <h3>List of Complaints</h3>
                            <thead>
                                
                                <tr>
                                    <th>Complaint ID</th>
                                    <th>User ID</th>                                  
                                    <th>Description</th>
                                    <th>Date</th>                                  
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
                                                <td><%= complaintLocation %></td>
                                                <td>
                                                    <% if (complaintAttachment != null && !complaintAttachment.isEmpty()) { %>
                                                    <a href="attachment/<%= complaintAttachment %>">View</a>
                                                    <% } else { %>
                                                        No Attachment
                                                    <% } %>
                                                </td>                         
                                                <td>                                          
                                                    <a class="btn-submit" href="UpdateComplaint.jsp?complaint_type_ID=<%= complaintID %>">
                                                        <i class="ti ti-pencil me-1"></i> Edit</a> <br><br>
                              
                                                    <a class="btn-submit" href="/neighborlyy/ComplaintController?accessType=delete&complaintID=<%= complaintID %>">
                                                        <i class="ti ti-trash me-1"></i> Delete</a> <br>
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
                                
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            int[] complaintsPerMonth = new int[12]; // Array to store complaints for 12 months, initialize to 0

            try {
                conn = DBConnection.createConnection();
                String query = "SELECT EXTRACT(MONTH FROM complaint_date) AS month, COUNT(*) AS total_complaints " +
                            "FROM complaint " +
                            "GROUP BY EXTRACT(MONTH FROM complaint_date) " +
                            "ORDER BY month";

                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int month = rs.getInt("month"); // 1 for January, 2 for February, etc.
                    int total = rs.getInt("total_complaints");
                    complaintsPerMonth[month - 1] = total; // Map to the 0-based array index
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        
        <!-- Chart.js Script -->
        <script>
            const labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August','September', 'October', 'November', 'December'];
            const data = {
            labels: labels,
            datasets: [{
                label: 'Complaints',
                data: <%= Arrays.toString(complaintsPerMonth).replace("[", "[").replace("]", "]") %>,
                backgroundColor: [
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(201, 203, 207, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 99, 132, 0.2)'
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 99, 132, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(201, 203, 207, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 99, 132, 1)'
                ],
                borderWidth: 1
            }]
        };

            const config = {
                type: 'bar',
                data: data,
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            };

            const myChart = new Chart(
                document.getElementById('myChart'),
                config
            );
        </script>
    </body>
</html>
