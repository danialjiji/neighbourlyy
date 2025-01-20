<%-- 
    Document   : dashboard.jsp
    Created on : Jan 19, 2025, 12:26:04 AM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
     <link rel="stylesheet" href=".../style.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, Danial</h3>
            </div>
            
            <nav class="menu">
                <ul>
                    <li class="active"><a href="#">Dashboard</a></li>
                    <li ><a href="#">Profile</a></li>
                    <li ><a href="#">Complaint</a></li>
                    <li ><a href="#">Fee</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Profile</h1>
                <span>Overview</span>
            </header>
            
            <section class="dashboard-overview">
               <!-- Welcome Section -->
               <div class="welcome-box">
                  <h2>Welcome to Neighborly!</h2>
                  <p>Your one-stop platform for managing your residence.</p>
               </div>
               <!-- Profile Summary -->
               <div class="overview-box profile-summary">
                  <h3>Your Profile</h3>
                  <%
                     // Database connection to fetch profile data
                     String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
                     String dbUser = "neighborly";
                     String dbPassword = "system"; // Replace with your actual password

                     Connection conn = null;
                     PreparedStatement pstmt = null;
                     ResultSet rs = null;

                     try {
                         Class.forName("oracle.jdbc.OracleDriver");
                         conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                         String query = "SELECT username, name, email FROM users WHERE userID = ?";
                         pstmt = conn.prepareStatement(query);
                         pstmt.setInt(1, Integer.parseInt(session.getAttribute("userid").toString())); // Use session userID
                         rs = pstmt.executeQuery();
                         if (rs.next()) {
                             String username = rs.getString("username");
                             String name = rs.getString("name");
                             String email = rs.getString("email");
                  %>
                  <p><strong>Name:</strong> <%= name %></p>
                  <p><strong>Username:</strong> <%= username %></p>
                  <p><strong>Email:</strong> <%= email %></p>
                  <% 
                         } else {
                             out.println("<p>No profile data found.</p>");
                         }
                     } catch (Exception e) {
                         out.println("<p>Error: " + e.getMessage() + "</p>");
                     } finally {
                         if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                         if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                         if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                     }
                  %>
               </div>
               <!-- Fee Summary -->
               <div class="overview-box fee-summary">
                  <h3>Your Fees</h3>
                  <table>
                     <thead>
                        <tr>
                           <th>Fee Type</th>
                           <th>Amount</th>
                           <th>Status</th>
                        </tr>
                     </thead>
                     <tbody>
                        <%
                           try {
                               Class.forName("oracle.jdbc.OracleDriver");
                               conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                               String feeQuery = "SELECT fc.fee_category_name, f.fee_amount, f.payment_status " +
                                                 "FROM fee f " +
                                                 "JOIN fee_category fc ON f.fee_category_ID = fc.fee_category_ID " +
                                                 "WHERE f.userID = ?";
                               pstmt = conn.prepareStatement(feeQuery);
                               pstmt.setInt(1, Integer.parseInt(session.getAttribute("userid").toString())); // Use session userID
                               rs = pstmt.executeQuery();
                               while (rs.next()) {
                                   String feeType = rs.getString("fee_category_name");
                                   double feeAmount = rs.getDouble("fee_amount");
                                   String paymentStatus = rs.getString("payment_status");
                        %>
                        <tr>
                           <td><%= feeType %></td>
                           <td>RM <%= feeAmount %></td>
                           <td><%= paymentStatus %></td>
                        </tr>
                        <% 
                               }
                           } catch (Exception e) {
                               out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                           } finally {
                               if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                               if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                               if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                           }
                        %>
                     </tbody>
                  </table>
               </div>
               <!-- Complaint Summary -->
               <div class="overview-box complaint-summary">
                  <h3>Recent Complaints</h3>
                  <table>
                     <thead>
                        <tr>
                           <th>Complaint ID</th>
                           <th>Type</th>
                           <th>Date</th>
                        </tr>
                     </thead>
                     <tbody>
                        <%
                           try {
                               Class.forName("oracle.jdbc.OracleDriver");
                               conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                               String complaintQuery = "SELECT c.complaintID, ct.comp_type_name, c.complaint_date " +
                                                       "FROM complaint c " +
                                                       "JOIN complaint_type ct ON c.complaint_type_id = ct.complaint_type_id " +
                                                       "WHERE c.userID = ? " +
                                                       "ORDER BY c.complaint_date DESC FETCH FIRST 3 ROWS ONLY";
                               pstmt = conn.prepareStatement(complaintQuery);
                               pstmt.setInt(1, Integer.parseInt(session.getAttribute("userid").toString())); // Use session userID
                               rs = pstmt.executeQuery();
                               while (rs.next()) {
                                   int complaintID = rs.getInt("complaintID");
                                   String complaintType = rs.getString("comp_type_name");
                                   Date complaintDate = rs.getDate("complaint_date");
                        %>
                        <tr>
                           <td><%= complaintID %></td>
                           <td><%= complaintType %></td>
                           <td><%= complaintDate %></td>
                        </tr>
                        <% 
                               }
                           } catch (Exception e) {
                               out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                           } finally {
                               if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                               if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                               if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                           }
                        %>
                     </tbody>
                  </table>
               </div>
            </section>
     </main>
   </div>
</body>
</html>
