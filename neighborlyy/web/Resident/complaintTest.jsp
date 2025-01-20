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
                    <li ><a href="#">Dashboard</a></li>
                    <li><a href="#">Profile</a></li>
                    <li class="active"><a href="#">Complaint</a></li>
                    <li><a href="#">Fee</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Complaint</h1>
                <span>Overview</span>
            </header>
            <div class="form-container">
                <h3>Complaint Form</h3><br>
                <p>Please Fill in the Form to Complaint to Management</p>
                <form>
                <label for="gender">Complaint Type</label>
                <select id="gender"name="complaintType">
                     <option selected>Open this select menu</option>
                    <option value="60001">Parking</option>
                    <option value="60002">Noise</option>
                    <option value="60003">Property</option>
                    <option value="60004">Environment</option>
                    <option value="60005">Waste Management</option>
                </select>
                
               <label for="dateComplaint">Date</label>
                <input type="date" id="dateComplaint" name="dateComplaint" placeholder="YYYY-MM-DD">
                <label for="name">Location</label>
                <input type="text" id="Location" placeholder="Location">

                <label for="email">Description</label>
                <input type="email" id="Description" placeholder="Description"> 

                <div class="btn-container">
                    <button type="submit" class="btn-submit">Submit</button>
                    <button type="button" class="btn-cancel">Cancel</button>
                </div>
            </form>
        </div>
            
           <section class="data-table">
        <h3>Your Fee Information</h3>
        <table class="table">
            <thead>
                <tr>
                    <th>Fee Type</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Payment Receipt</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection parameters
                    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
                    String dbUser  = "neighborly";
                    String dbPassword = "system"; // Replace with your actual password

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        // Load Oracle JDBC Driver
                        Class.forName("oracle.jdbc.OracleDriver");

                        // Establish connection
                        conn = DriverManager.getConnection(jdbcURL, dbUser , dbPassword);

                        // Create SQL query with a WHERE clause
                        String query = "SELECT fc.fee_category_name, f.fee_amount, f.fee_date, f.attachment " +
                                       "FROM fee f " +
                                       "JOIN fee_category fc ON f.fee_category_ID = fc.fee_category_ID " +
                                       "WHERE f.userID = ?";

                        // Prepare statement
                        pstmt = conn.prepareStatement(query);
                        //pstmt.setInt(1, loggedInUser Id);

                        // Execute query
                        rs = pstmt.executeQuery();

                        // Iterate through the result set and display data
                        while (rs.next()) {
                            String feeType = rs.getString("fee_category_name");
                            double feeAmount = rs.getDouble("fee_amount");
                            Date feeDate = rs.getDate("fee_date");
                            String attachment = rs.getString("attachment");
                %>
                <tr>
                    <td><%= feeType %></td>
                    <td><%= feeAmount %></td>
                    <td><%= feeDate %></td>
                    <td>
                        <% if (attachment != null && !attachment.isEmpty()) { %>
                            <a href="<%= attachment %>" target="_blank">View Receipt</a>
                        <% } else { %>
                            N/A
                        <% } %>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        // Close resources
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </tbody>
        </table>
    </section>
     </main>
   </div>
</body>
</html>
