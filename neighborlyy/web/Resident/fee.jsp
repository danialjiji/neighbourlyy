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
    <title>Fee Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
     <link rel="stylesheet" href=".../style.css">
</head>
<body>
    <div class="dashboard-container">
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="../login.jsp">log in</a>.</p>
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
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
            
            
            <nav class="menu">
                <ul>
                    <li ><a  href="/neighborlyy/dashboardResident.jsp" >Dashboard</a></li>
                    <li><a href="profile.jsp">Profile</a></li>
                    <li ><a href="complaint.jsp">Complaint</a></li>
                    <li class="active"><a href="fee.jsp">Fee</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Fee</h1>
                <span>Overview</span>
            </header>
             <div class="form-container">
        <h3>Fee Form</h3><br>
        <p>Please fill in the form to pay for the bills</p>
        <form action="/neighborlyy/feeServlet" method="POST" enctype="multipart/form-data">
            <label for="feeType">Fee Type</label>
            <select id="feeType" name="feeType">
                <option selected>Open this select menu</option>
                <option value="80001">Maintenance</option>
                <option value="80002">Quit Rent</option>
                <option value="80003">Insurance</option>
            </select>

            <label for="amount">Amount</label>
            <input type="text" id="amount" name="amount" placeholder="Enter amount" required/>

            <label for="feeDate">Date</label>
            <input type="date" id="feeDate" name="dateFee" placeholder="YYYY-MM-DD" required/>

            <label for="receipt">Attachment</label>
            <input type="file" id="receipt" name="receipt" required/>

            <div class="btn-container">
                <button type="submit" class="btn-submit">Submit</button>
                <button type="reset" class="btn-cancel">Cancel</button>
                <input type="hidden" name="accessType" value="addFee">
             <input type="hidden" name="userid" value="<%= userid %>">
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

                    try {
                        // Load Oracle JDBC Driver
                        Class.forName("oracle.jdbc.OracleDriver");

                        // Establish connection
                         Connection conn = DBConnection.createConnection();
                          

                        // Create SQL query with a WHERE clause
                        String query = "SELECT fc.fee_category_name, f.fee_amount, f.fee_date, f.attachment " +
                                       "FROM fee f " +
                                       "JOIN fee_category fc ON f.fee_category_ID = fc.fee_category_ID " +
                                       "WHERE f.userID = ?";

                         PreparedStatement pstmt = conn.prepareStatement(query);
                         pstmt.setInt(1, userid);
                         ResultSet rs = pstmt.executeQuery();
                                
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
                    <td><%= attachment %></td>
                   
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
                    } 
                %>
                    </tbody>
                </table>
            </section>
     </main>
   </div>
</body>
</html>
