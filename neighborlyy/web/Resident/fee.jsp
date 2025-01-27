<%-- 
    Document   : dashboard.jsp
    Created on : Jan 19, 2025, 12:26:04 AM
    Author     : USER
--%>

<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fee</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../styless.css">
    <style>
         div.content{
            height : 100vh;
         }
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
    <div class="dashboard-container">
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="/neighborlyy/login.jsp">log in</a>.</p>
        <%
                return;
            }
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid");
            String username = (String) session.getAttribute("username");
        %>
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
                
            <div>
                  <a href="/neighborlyy/dashboardResident.jsp">Dashboard</a>
                    <a href="./profile.jsp">Profile</a>
                    <a href="./complaint.jsp">Complaint</a>
                    <a class="active" href="./fee.jsp">Fee</a>
                    <a href="/neighborlyy/LogoutServlet">Log Out</a>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="content">
            <header class="cardheader">
                <h1>Fee</h1>
                <span>Overview</span>
            </header>
            
           <section class="data-table">
                <h3>Your Fee Information</h3>
           <table class="table">
            <thead>
                <tr>
                    <th>Fee Type</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Your Payment</th>
                    <th>Remark</th>
                    <th>Payment Receipt</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                
                        <%
                   
                    try {
                        // Load Oracle JDBC Driver
                        Class.forName("oracle.jdbc.OracleDriver");
                        Connection conn = DBConnection.createConnection();
                        // Create SQL query with a WHERE clause
                        String query = "SELECT f.FEEID, s.STATUS_DESCRIPTION, fc.FEE_CATEGORY_NAME, f.FEE_AMOUNT, f.FEE_DATE, f.ATTACHMENT, f.PAYFEE, f.REMARK " +
                                       "FROM FEE f " +
                                       "JOIN FEE_CATEGORY fc ON f.FEE_CATEGORY_ID = fc.FEE_CATEGORY_ID " +
                                       "JOIN STATUS s ON f.STATUSID = s.STATUSID " +
                                       "WHERE f.USERID = ?";
                        
                         int sessionUserId = Integer.parseInt(session.getAttribute("userid").toString());
                         PreparedStatement pstmt = conn.prepareStatement(query);
                         pstmt.setInt(1, userid);
                         ResultSet rs = pstmt.executeQuery();

                        // Iterate through the result set and display data
                        while (rs.next()) {
                            int feeID = rs.getInt("feeid");
                            String feeType = rs.getString("fee_category_name");
                            double feeAmount = rs.getDouble("fee_amount");
                            Date feeDate = rs.getDate("fee_date");
                            String receipt = rs.getString("attachment");
                            String statusDesc = rs.getString ("status_description");
                            String payFee = rs.getString("payFee");
                            String remark = rs.getString ("remark");
                %>
                <tr>
                    <td><%= feeType %></td>
                    <td>RM <%= feeAmount %></td>
                    <td><%= feeDate %></td>
                    <td>RM <%= payFee %></td>
                    <td><%= remark %></td>
                    
                   <td>
                        <% if (receipt != null && !receipt.isEmpty()) { %>
                        <a href="attachment/<%= receipt %>">View</a>
                        <% } else { %>
                            No Attachment
                        <% } %>
                     </td>
                    <td><%= statusDesc %></td>
                    
                    <td>
                         <div class="profile-actions">
                             <a class="btn-submit" href="feePay.jsp?accessType=payFee&feeid=<%= feeID %>">Pay</a>

                        </div>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                    } 
                %>
                          </tbody>
                      </table>
                 </section>
             </div>
        </div>
    </body>
</html>