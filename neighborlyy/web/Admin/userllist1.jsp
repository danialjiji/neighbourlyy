<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link rel="stylesheet" href="../styless.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<style>
    .chart-container {
        width: 68%; /* Adjust width as needed */
        margin: 20px auto; /* Center the chart on the page */
    }
    canvas#myChart {
        max-width: 100%; /* Ensure the chart doesn't overflow */
        height: 400px; /* Set a fixed height */
    }
    .search-form {
        margin-bottom: 20px;
        text-align: center;
    }
    .search-form input[type="text"] {
        padding: 5px;
        font-size: 14px;
        width: 250px;
    }
    .search-form button {
        padding: 5px 10px;
        font-size: 14px;
        cursor: pointer;
    }
</style>
<body>
<%
    // Check if the session exists and if the user is logged in
    if (session == null || session.getAttribute("userid") == null) {
%>
    <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
<%
        return; // Stop rendering the page if the session is invalid
    }
%>

<div class="dashboard-container">
    <!-- Sidebar -->
    <aside style="height: 100vh;" class="sidebar">
        <div class="profile">
            <img style="height:60px; width:60px; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo">
            <h3>Hi, Danial</h3>
        </div>
        <div>
            <ul>
                <a href="../dashboardAdmin.jsp">Dashboard</a></li>
                <a href="Visitor.jsp">Visitor</a></li>
                <a href="Fee.jsp">Fee</a></li>
                <a href="Report.jsp">Report</a></li>
                <a href="Complaint.jsp">Complaints</a></li>
                <a href="registerGuard.jsp">Registration</a></li>
                <a class="active" href="userllist1.jsp">User List</a></li>
                <a href="../LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </aside>

    <!-- Main Content -->
    <div class="content">
        <header class="cardheader">
            <h1>User List</h1>
            <span>Overview of Users</span>
        </header>

        <!-- Search Form -->
        <div class="search-form">
            <form method="get" action="userllist1.jsp">
                <input type="text" name="search" placeholder="Search by Name" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit">Search</button>
            </form>
        </div>

        <div class="chart-container">
            <canvas id="myChart"></canvas>
        </div>

        <!-- Fetch User Data -->
        <section class="data-table">
            <h3>Recent Users</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>UserID</th>
                        <th>Username</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Salary</th>
                        <th>Shift</th>
                        <th>Post Location</th>
                        <th>House Unit</th>
                        <th>Vehicle Number</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    String searchKey = request.getParameter("search");
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    String sql = "";

                    try {
                        conn = DBConnection.createConnection();

                        if (searchKey != null && !searchKey.trim().isEmpty()) {
                            // Use LIKE operator for partial search
                            sql = "SELECT u.userID, u.username, u.\"name\", u.ic_passport, u.phoneNum, " +  
                                  "u.email, u.plate_id, COALESCE(a.salary, g.salary, 0) AS salary, " +  
                                  "NVL(g.shift, '-') AS shift, NVL(g.post_location, '-') AS post_location, " +  
                                  "NVL(r.unit, '-') AS unit, " +  
                                  "CASE WHEN a.userID IS NOT NULL THEN 'Admin' " +  
                                  "WHEN g.userID IS NOT NULL THEN 'Guard' " +  
                                  "WHEN r.userID IS NOT NULL THEN 'Resident' END AS role " +  
                                  "FROM users u " +  
                                  "LEFT JOIN admin a ON u.userID = a.userID " +  
                                  "LEFT JOIN guard g ON u.userID = g.userID " +  
                                  "LEFT JOIN resident r ON u.userID = r.userID " +  
                                  "WHERE u.\"name\" LIKE ?";  

                                 // Prepare statement and set parameter  
                                 stmt = conn.prepareStatement(sql);  
                                 stmt.setString(1, "%" + searchKey + "%"); 
                      
                        } else {
                            // Default query without search
                            sql = "SELECT u.userID, u.username, u.\"name\", u.ic_passport, u.phoneNum, " +
                                  "u.email, u.plate_id, COALESCE(a.salary, g.salary, 0) AS salary, " +
                                  "NVL(g.shift, '-') AS shift, NVL(g.post_location, '-') AS post_location, " +
                                  "NVL(r.unit, '-') AS unit, " +
                                  "CASE WHEN a.userID IS NOT NULL THEN 'Admin' " +
                                  "WHEN g.userID IS NOT NULL THEN 'Guard' " +
                                  "WHEN r.userID IS NOT NULL THEN 'Resident' END AS role " +
                                  "FROM users u " +
                                  "LEFT JOIN admin a ON u.userID = a.userID " +
                                  "LEFT JOIN guard g ON u.userID = g.userID " +
                                  "LEFT JOIN resident r ON u.userID = r.userID";

                            stmt = conn.prepareStatement(sql);
                        }

                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            int userID = rs.getInt("userID");
                            String username = rs.getString("username");  
                            String name = rs.getString("name");  
                            String email = rs.getString("email");  
                            String icPassport = rs.getString("ic_passport");  
                            String phoneNum = rs.getString("phoneNum");  
                            String plateNum = rs.getString("plate_id");  
                            String role = rs.getString("role");
                            double salary = rs.getDouble("salary");
                            String shift = rs.getString("shift");
                            String postLocation = rs.getString("post_location");
                            String unitHouse = rs.getString("unit");
                            
                            String additionalInfo = salary != 0.0 ? String.valueOf(salary) : "-"; 
                    
                %>
                    <tr>
                        <td><%= userID %></td>  
                            <td><%= username %></td>  
                            <td><%= name %></td>  
                            <td><%= phoneNum %></td>  
                            <td><%= role %></td>  
                            <td><%= additionalInfo %></td>  
                            <td><%= shift %></td>  
                            <td><%= postLocation %></td>  
                            <td><%= unitHouse %></td>  
                            <td><%= plateNum %></td> 
                        <td>
                            <form action="editUser.jsp" method="get" style="display:inline;">
                                <input type="hidden" name="userID" value="<%= userID %>">
                                <input type="hidden" name="role" value="<%= role %>">
                                <button type="submit" class="btn-submit">Edit</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
        </section>


        <!-- Chart Section -->
        <%
            int totalResidents = 0, totalGuards = 0, totalAdmins = 0;
            try {
                conn = DBConnection.createConnection();
                stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM resident");
                rs = stmt.executeQuery();
                if (rs.next()) totalResidents = rs.getInt("total");

                stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM guard");
                rs = stmt.executeQuery();
                if (rs.next()) totalGuards = rs.getInt("total");

                stmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM admin");
                rs = stmt.executeQuery();
                if (rs.next()) totalAdmins = rs.getInt("total");
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>

        <script>
            const labels = ['Residents', 'Guards', 'Admins'];
            const data = {
                labels: labels,
                datasets: [{
                    label: 'Total Count',
                    data: [<%= totalResidents %>, <%= totalGuards %>, <%= totalAdmins %>],
                    backgroundColor: [
                        'rgba(0, 123, 255, 0.2)',  // Blue
                        'rgba(153, 102, 255, 0.2)',  // Purple
                        'rgba(255, 159, 64, 0.2)'   // Orange
                    ],
                    borderColor: [
                        'rgba(0, 123, 255, 1)',  // Blue
                        'rgba(153, 102, 255, 1)',  // Purple
                        'rgba(255, 159, 64, 1)'   // Orange
                    ],
                    borderWidth: 1
                }]
            };

            const config = {
                type: 'bar',
                data: data,
                options: { responsive: true, scales: { y: { beginAtZero: true } } }
            };

            const myChart = new Chart(document.getElementById('myChart'), config);
        </script>
    </div>
</div>
</body>
</html>
