<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
         <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            .sidebar {
                height: 100vh;
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
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
            </div>
            
            <nav class="menu">
                <ul>
                    <li class="active"><a href="/neighborlyy/dashboardResident.jsp">Dashboard</a></li>
                    <li ><a href="./Resident/profile.jsp">Profile</a></li>
                    <li ><a href="./Resident/complaint.jsp">Complaint</a></li>
                    <li ><a href="./Resident/fee.jsp">Fee</a></li>
                    <li ><a href="LogoutServlet">Log Out</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Welcome to the Dashboard, <%= username %>! </h1>
                
            </header>
            <section class="dashboard-overview">
               <!-- Welcome Section -->
               <div class="welcome-box">
                  <br>
                  <br>
                  <p>Your one-stop platform for managing your residence.</p>
                  <br>
               </div>
                </section>
                
               <!-- Dashboard Summary -->
              
               <section class="data-table">
    <h3>Your Process Fees</h3>
    <table class="table">
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
                        // Load Oracle JDBC Driver
                 
                        Connection conn = DBConnection.createConnection();
                        // Create SQL query with a WHERE clause
                        String query = "SELECT f.FEEID, s.STATUS_DESCRIPTION, fc.FEE_CATEGORY_NAME, f.FEE_AMOUNT, f.FEE_DATE, f.ATTACHMENT, f.PAYFEE, f.REMARK " +
                                       "FROM FEE f " +
                                       "JOIN FEE_CATEGORY fc ON f.FEE_CATEGORY_ID = fc.FEE_CATEGORY_ID " +
                                       "JOIN STATUS s ON f.STATUSID = s.STATUSID " +
                                       "WHERE f.USERID = ?";

                         PreparedStatement pstmt = conn.prepareStatement(query);
                         pstmt.setInt(1, userid);
                         ResultSet rs = pstmt.executeQuery();

                    boolean hasUnpaidFees = false;
                    while (rs.next()) {
                        hasUnpaidFees = true;
                        String feeType = rs.getString("fee_category_name");
                        double feeAmount = rs.getDouble("fee_amount");
                        String statusDesc = rs.getString("status_description");
            %>
            <tr>
                <td><%= feeType %></td>
                <td>RM <%= feeAmount %></td>
                <td><%= statusDesc %></td>
            </tr>
            <% 
                    }
                    if (!hasUnpaidFees) {
                        out.println("<tr><td colspan='3'>No unpaid fees found.</td></tr>");
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>
        </section>
</div>
           
     </main>
   </div>
</body>

</html>
