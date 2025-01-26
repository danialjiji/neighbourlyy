<%@page import="java.util.Arrays"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="util.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%> <!-- here -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rounding Report Form</title>
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
    <body>
        <div class="dashboard-container">
            <!-- here -->
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return;
            }
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid");
            String username = (String) session.getAttribute("username");
        %>
        <!-- untill here -->
        
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
                        <li class="active"><a href="RoundingReport.jsp">Rounding Report</a></li>
                        <li><a href="VisitorForm.jsp">Visitor Form</a></li>
                        <li><a href="userlist.jsp">Users List</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
                </nav>
            </aside>

            <main class="main-content">
                <div class="form-container">
                <!-- Chart Container -->
                <div class="chart-container">
                    <canvas id="myChart"></canvas>
                </div>
                    <h3>Rounding Report Form</h3>
                    <p>Please fill all informations</p>
                                    <!-- change here -->
                    <form action="/neighborlyy/securityController" method="POST" enctype="multipart/form-data">
                        <label for="dateReport">Date of Report</label>
                        <input type="date" name ="dateReport" placeholder="YYYY-MM-DD"/>
                        <p></p>
                        <label for="location">Location</location>
                        <input type="text" name="location" placeholder="Location"/>
                        
                        <label for="remarks">Remarks</label>
                        <input type="text" name="remarks" placeholder="Remarks"/>
                        
                        <label for="attachment">Attachment</label>
                        <input type="file" name="attachment"/>
                        
                        <div class="btn-container">
                            <button type="submit" value="Submit" class="btn-submit" >Submit</button>
                            <button type="reset" class="btn-cancel" >Cancel</button>
                        </div>
                        <input type="hidden" name="accessType" value="addReport">
                        <input type="hidden" name="userid" value="<%= userid %>"> <!-- here -->
                    </form>
                </div>
                    
                <div>
                <section class="data-table">
                    <form action="RoundingReport.jsp" method="GET">
                        <label for="searchKeyword">Search:</label>
                        <input 
                            type="text" 
                            id="searchKeyword" 
                            name="searchKeyword" 
                            placeholder="Enter location or remarks" 
                            value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
                        <button type="submit">Search</button>
                        <button><a href="RoundingReport.jsp" class="btn-reset">Reset</a></button> <!-- Reset button -->
                    </form>

                    <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Remarks</th>
                            <th>Attachment</th>
                            <th>Action</th>

                        </tr>
                    </thead>
                    <%
                       try {
                           Connection conn = DBConnection.createConnection();

                           // Get the search keyword from the request
                           String searchKeyword = request.getParameter("searchKeyword");
                           String query;

                           if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                               query = "SELECT * FROM report WHERE userid = ? AND (location LIKE ? OR remarks LIKE ?)";
                           } else {
                               query = "SELECT * FROM report WHERE userid = ?";
                           }

                           PreparedStatement stmt = conn.prepareStatement(query);
                           stmt.setInt(1, userid);

                           if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                               String keywordPattern = "%" + searchKeyword + "%";
                               stmt.setString(2, keywordPattern);
                               stmt.setString(3, keywordPattern);
                           }

                           ResultSet rs = stmt.executeQuery();

                           while (rs.next()) {
                               int reportID = rs.getInt("reportid");
                               Date dateOfVisit = rs.getDate("dateofvisit");
                               String location = rs.getString("location");
                               String remarks = rs.getString("remarks");
                               String attachment = rs.getString("attachment");

                               // Format the date
                               SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                               String onlyDate = dateFormat.format(dateOfVisit);
                   %>
                    <tbody>
                        <tr>
                            <td><%= reportID %></td>
                            <td><%= onlyDate %></td>
                            <td><%= location %></td>
                            <td><%= remarks %></td>
                            <td><%= attachment %></td>
                            <td><a href="/neighborlyy/securityController?accessType=deleteReport&id=<%= reportID %>" class="btn-submit">Delete</a></td>
                        </tr>
                    </tbody>
                    <%
                            }
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                    </table>
                </section>
                </div>
            </main>
        </div>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            int[] roundingReportPerMonth = new int[12]; // Array to store complaints for 12 months, initialize to 0

            try {
                conn = DBConnection.createConnection();
                String query = "SELECT EXTRACT(MONTH FROM dateofvisit) AS month, COUNT(*) AS total_reports " +
                               "FROM report " +
                               "GROUP BY EXTRACT(MONTH FROM dateofvisit) " +
                               "ORDER BY month";

                stmt = conn.prepareStatement(query);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int month = rs.getInt("month"); // 1 for January, 2 for February, etc.
                    int total = rs.getInt("total_reports");
                    roundingReportPerMonth[month - 1] = total; // Map to the 0-based array index
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
            label: 'Rounding Reports',
            data: <%= Arrays.toString(roundingReportPerMonth).replace("[", "[").replace("]", "]") %>,
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
