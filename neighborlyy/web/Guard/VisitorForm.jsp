<%@page import="java.util.Arrays"%>
<%@page import="util.DBConnection"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visitor Form</title>
        <link rel="stylesheet" href="../style.css">
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
    
    <style>
        .sidebar{
            height:100vh;
        }
    </style>
    
    <body>
    <div class="dashboard-container">
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return;
            }
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid"); // Use implicit session
            String username = (String) session.getAttribute("username");
        %>
        
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
            
            
            <nav class="menu">
                <ul>
                    <li><a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a></li>
                    <li><a href="profileGuard.jsp">Profile</a></li>
                    <li><a href="RoundingReport.jsp">Rounding Report</a></li>
                    <li class="active"><a href="VisitorForm.jsp">Visitor Form</a></li>
                    <li><a href="userlist.jsp">Users List</a></li>
                    <li><a href="../LogoutServlet">Logout</a></li>
                </ul>
            </nav>
        </aside>
        
        <main class="main-content">
            <div class="form-container">
            <div class="chart-container">
                <canvas id="myChart"></canvas>
            </div>

                <h3>Visitor Form</h3>
                <p>Please fill all informations</p>
                <form action="/neighborlyy/securityController" method="POST" enctype="multipart/form-data">
                    <label for="visitorname">Visitor's Name</label>
                    <input type="text" name="visitorname" placeholder="Name" required/>

                    <label for="icpassport">IC/Passport</label>
                    <input type="text" name="icpassport" placeholder="IC/Passport" required/>

                    <label for="plateno">Plate Number</label>
                    <input type="text" name="plateno" placeholder="Plate Number" required/>

                    <label for="purposevisit">Purpose of Visit</label>
                    <input type="text" name="purposevisit" placeholder="Purpose of Visit" required/>

                    <label for="phoneno">Phone Number</label>
                    <input type="text" name="phoneno" placeholder="Phone Number" required/>

                    <label for="entrytime">Entry Time</label>
                    <input type="time" name="entrytime" required/>

                    <label for="datevisit">Date of Visit</label>
                    <input type="date" name="datevisit" required/>
                    <p></p>

                    <div class="btn-container">
                        <button type="submit" class="btn-submit">Submit</button>
                        <button type="reset" class="btn-cancel">Cancel</button>
                    </div>
                    <input type="hidden" name="accessType" value="addVisitor">
                    <input type="hidden" name="userid" value="<%= userid %>"> <!-- Set the userid dynamically -->
                </form>
            </div>
                <div>
                <section class="data-table">
                <form action="VisitorForm.jsp" method="GET">
                    <label for="searchKeyword">Search:</label>
                    <input 
                        type="text" 
                        id="searchKeyword" 
                        name="searchKeyword" 
                        placeholder="Enter location or remarks" 
                        value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
                    <button type="submit">Search</button>
                    <button><a href="VisitorForm.jsp" class="btn-reset">Reset</a></button> <!-- Reset button -->
                </form>
                <table class="table">
                    <thead>
                        <tr>    
                            <th>ID</th>
                            <th>Visitor's Name</th>
                            <th>IC/Passport</th>
                            <th>Plate Number</th>
                            <th>Entry Time</th>
                            <th>Exit Time</th>
                            <th>Date</th>
                            <th>Purpose</th>
                            <th>Phone No</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <%
                        Connection conn = null;
                        try {
                            conn = DBConnection.createConnection();

                            String searchKeyword = request.getParameter("searchKeyword"); // Get the search keyword from the request
                            String query = "SELECT * FROM visitor";

                            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                                query += " WHERE visitor_name LIKE ? OR visitor_ic LIKE ? OR no_plate LIKE ?";
                            }

                            PreparedStatement stmt = conn.prepareStatement(query);

                            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                                String searchPattern = "%" + searchKeyword + "%";
                                stmt.setString(1, searchPattern); // For visitor_name
                                stmt.setString(2, searchPattern); // For visitor_ic
                                stmt.setString(3, searchPattern); // For no_plate
                            }

                            ResultSet rs = stmt.executeQuery();

                            while (rs.next()) {
                                int registerID = rs.getInt("registerid");
                                String visitorName = rs.getString("visitor_name");
                                if (visitorName == null) visitorName = "N/A";

                                String icpassport = rs.getString("visitor_ic");
                                if (icpassport == null) icpassport = "N/A";

                                String plateNo = rs.getString("no_plate");
                                if (plateNo == null) plateNo = "N/A";

                                Time entryTime = rs.getTime("entrytime");
                                String entryTimeOnly = (entryTime != null) ? new SimpleDateFormat("HH:mm").format(entryTime) : "N/A";

                                Time exitTime = rs.getTime("exittime");
                                String exitTimeOnly = (exitTime != null) ? new SimpleDateFormat("HH:mm").format(exitTime) : "N/A";

                                Date dateVisit = rs.getDate("dateofvisit");
                                String onlyDate = (dateVisit != null) ? new SimpleDateFormat("yyyy-MM-dd").format(dateVisit) : "N/A";

                                String purposeVisit = rs.getString("purposeofvisit");
                                if (purposeVisit == null) purposeVisit = "N/A";

                                String phoneNum = rs.getString("visitor_phonenum");
                                if (phoneNum == null) phoneNum = "N/A";
                    %>
                    <tr>
                        <td><%= registerID %></td>
                        <td><%= visitorName %></td>
                        <td><%= icpassport %></td>
                        <td><%= plateNo %></td>
                        <td><%= entryTimeOnly %></td>
                        <td><%= exitTimeOnly %></td>
                        <td><%= onlyDate %></td>
                        <td><%= purposeVisit %></td>
                        <td><%= phoneNum %></td>
                    </tr>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>

                </table>
            </section>
                    
                </div>
        </main>
    </div>
        <%
            PreparedStatement stmt = null;
            ResultSet rs = null;

            int[] visitorsInPerMonth = new int[12]; // Visitors "In" count for each month
            int[] visitorsOutPerMonth = new int[12]; // Visitors "Out" count for each month

            try {
                conn = DBConnection.createConnection();
                String query = "SELECT " +
                               "EXTRACT(MONTH FROM dateofvisit) AS month, " +
                               "COUNT(*) AS total_in, " +
                               "SUM(CASE WHEN exittime IS NOT NULL THEN 1 ELSE 0 END) AS total_out " +
                               "FROM visitor " +
                               "GROUP BY EXTRACT(MONTH FROM dateofvisit) " +
                               "ORDER BY month";

                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int month = rs.getInt("month"); // 1 for January, 2 for February, etc.
                    visitorsInPerMonth[month - 1] = rs.getInt("total_in"); // Map to the 0-based array index
                    visitorsOutPerMonth[month - 1] = rs.getInt("total_out");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>


        <!-- Chart.js Script -->
        <script>
            const labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

            const data = {
                labels: labels,
                datasets: [
                    {
                        label: 'Visitors In',
                        data: <%= Arrays.toString(visitorsInPerMonth).replace("[", "[").replace("]", "]") %>,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)', // Blue color for "In"
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Visitors Out',
                        data: <%= Arrays.toString(visitorsOutPerMonth).replace("[", "[").replace("]", "]") %>,
                        backgroundColor: 'rgba(255, 99, 132, 0.2)', // Red color for "Out"
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    }
                ]
            };

            const config = {
                type: 'bar',
                data: data,
                options: {
                    responsive: true,
                    scales: {
                        x: {
                            stacked: false // Optional: Set to true for stacked bars
                        },
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
        