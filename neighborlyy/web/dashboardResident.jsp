<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="java.util.Arrays"%>

<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="styless.css">
    <%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
         <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
           .chart-container {
                display: flex;
                justify-content: center; /* Horizontally center */
                align-items: center; /* Vertically center */
                width: 80%;  /* Adjust width as needed */
                max-width: 800px;  /* Maximum width for the chart */
                margin: 0 auto;  /* Center horizontally */
                height: 400px; /* Set a medium height */
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
            
            <div>
                    <a class="active" href="dashboardResident.jsp">Dashboard</a>
                    <a href="./Resident/profile.jsp">Profile</a>
                    <a href="./Resident/complaint.jsp">Complaint</a>
                    <a href="./Resident/fee.jsp">Fee</a>
                    <a href="LogoutServlet">Log Out</a>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="content">
            <header class="cardheader">
                <h1>Resident Dashboard</h1>
                
            </header>
             <section class="dashboard-overview">
               <!-- Welcome Section -->
               <div class="welcome-box">
                <h2>Welcome Back, <%= username %>!</h2>
                <p>We’re excited to have you back. Your personalized dashboard is ready to help you manage your residence effortlessly.</p>
                <p>Explore your options and enjoy your stay!</p>
                <button onclick="window.location.href='/neighborlyy/dashboardResident.jsp'">Start Exploring</button>
            </div>
            </section>
                
               <!-- Dashboard Summary -->
                   
                 
               </section>
                              
            <section class="data-table">
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;


                    int[] complaintsPerMonth = new int[12]; // Array to store complaints for 12 months, initialize to 0

                    try {
                        conn = DBConnection.createConnection();
                        String query = "SELECT EXTRACT(MONTH FROM complaint_date) AS month, COUNT(*) AS total_complaints " +
                           "FROM complaint " +
                           "WHERE userid = ? " + // Filter for the logged-in user's complaints
                           "GROUP BY EXTRACT(MONTH FROM complaint_date) " +
                           "ORDER BY month";

                        stmt = conn.prepareStatement(query);
                        stmt.setInt(1, userid); // Set the logged-in user's ID
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
                        <div class="chart-container">
                            <canvas id="myChart"></canvas>
                        </div>

                        <script>
                            const labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                            const data = {
                                labels: labels,
                                datasets: [{
                                    label: 'Complaints',
                                    data: <%= Arrays.toString(complaintsPerMonth) %>, // Pass data dynamically
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
                    </section>
                                    
               <section class="data-table">
                        <%
                            Map<String, Integer> feeStatusCounts = new HashMap<String, Integer>(); // Map to store count of statuses

                            try {
                                conn = DBConnection.createConnection();
                                String query = "SELECT s.status_description, COUNT(*) AS status_count " +
                                               "FROM fee f " +
                                               "JOIN status s ON f.statusID = s.statusID " +
                                               "WHERE f.userID = ? " +
                                               "GROUP BY s.status_description";

                                stmt = conn.prepareStatement(query);
                                stmt.setInt(1, userid); // Pass the logged-in user's ID
                                rs = stmt.executeQuery();

                                while (rs.next()) {
                                    feeStatusCounts.put(rs.getString("status_description"), rs.getInt("status_count"));
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>

                       <div class="chart-container" style="width: 500px; height: 500px; margin: 0 auto;"> <!-- Adjusted size for medium chart -->
                            <canvas id="feeChart"></canvas>
                        </div>

                        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                        <script>
                            // Manually construct the JavaScript object for fee status counts
                            const feeData = {
                                <% 
                                    for (Map.Entry<String, Integer> entry : feeStatusCounts.entrySet()) {
                                        String key = entry.getKey();
                                        Integer value = entry.getValue();
                                %>
                                    "<%= key %>": <%= value %>,
                                <% } %>
                            };

                            console.log('Fee Data:', feeData); // Debugging: Log feeData to inspect its structure

                            const feeLabels = Object.keys(feeData); // Extract keys (status descriptions)
                            const feeValues = Object.values(feeData); // Extract values (status counts)

                            // Create a pie chart for fee statuses by count
                            const feeChartData = {
                                labels: feeLabels,
                                datasets: [{
                                    label: 'Count of Fee Statuses',
                                    data: feeValues,
                                    backgroundColor: [
                                        'rgba(75, 192, 192, 0.2)',
                                        'rgba(255, 99, 132, 0.2)',
                                        'rgba(54, 162, 235, 0.2)',
                                        'rgba(255, 206, 86, 0.2)',
                                        'rgba(153, 102, 255, 0.2)',
                                        'rgba(255, 159, 64, 0.2)'
                                    ],
                                    borderColor: [
                                        'rgba(75, 192, 192, 1)',
                                        'rgba(255, 99, 132, 1)',
                                        'rgba(54, 162, 235, 1)',
                                        'rgba(255, 206, 86, 1)',
                                        'rgba(153, 102, 255, 1)',
                                        'rgba(255, 159, 64, 1)'
                                    ],
                                    borderWidth: 1
                                }]
                            };

                            const feeChartConfig = {
                                type: 'pie',
                                data: feeChartData,
                                options: {
                                    responsive: true
                                }
                            };

                            const feeChart = new Chart(
                                document.getElementById('feeChart'),
                                feeChartConfig
                            );
                        </script>
                    </section>
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
                 
                         conn = DBConnection.createConnection();
                        // Create SQL query with a WHERE clause
                        String query = "SELECT f.FEEID, s.STATUS_DESCRIPTION, fc.FEE_CATEGORY_NAME, f.FEE_AMOUNT, f.FEE_DATE, f.ATTACHMENT, f.PAYFEE, f.REMARK " +
                                       "FROM FEE f " +
                                       "JOIN FEE_CATEGORY fc ON f.FEE_CATEGORY_ID = fc.FEE_CATEGORY_ID " +
                                       "JOIN STATUS s ON f.STATUSID = s.STATUSID " +
                                       "WHERE f.USERID = ? AND F.STATUSID = 50001";

                         PreparedStatement pstmt = conn.prepareStatement(query);
                         pstmt.setInt(1, userid);
                          rs = pstmt.executeQuery();

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
     </div>
   </div>
</body>
</html>
