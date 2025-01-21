<%@page import="util.DBConnection"%>
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
    <div class="dashboard-container">
        <!-- Sidebar -->
            <aside class="sidebar">
                <div class="profile">
                    <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                    <h3>Hi, <%= username %></h3>

                </div>


                <nav class="menu">
                    <ul>
                        <li><a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a></li>
                        <li><a href="RoundingReport.jsp">Rounding Report</a></li>
                        <li><a href="RoundingReportTable.jsp">Rounding Report List</a></li>
                        <li><a href="VisitorForm.jsp">Visitor Form</a></li>
                        <li><a href="VisitorTable.jsp">Visitor List</a></li>
                        <li><a href="/neighborlyy/LogoutServlet.java" class="btn-add-project">Logout</a></li>
                    </ul>
                </nav>
            </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Profile</h1>
                <span>Overview</span>
            </header>
            
           <section class="data-table">
                <h3>Complaints List</h3>
                <div class="profile-container">
                    <h1>User Profile</h1>
                    <div class="profile-box">
                        <%

                        try {
                            Connection conn = DBConnection.createConnection();
                            String query = "SELECT u.username, u.\"name\", u.ic_passport, g.shift, g.post_location, u.phoneNum, u.email" +
                            "FROM users u " +
                            "LEFT JOIN guard g ON u.userID = g.userID " +
                            "WHERE u.userID = ?";
                            PreparedStatement stmt = conn.prepareStatement(query);
                            stmt.setInt(1, userid);
                            ResultSet rs = stmt.executeQuery();
 

                                if (rs.next()) {
                                    String userName = rs.getString("username");
                                    String fullName = rs.getString("name");
                                    String icNumber = rs.getString("ic_passport");
                                    String contact = rs.getString("phoneNum");
                                    String email = rs.getString("email");
                                    String shift = rs.getString("shift");
                                    String postlocation = rs.getString("post_location");
                        %>
                        <!-- Profile Display -->
                        <table class="profile-table">
                            <tr>
                                <th>Username:</th>
                                <td><%= userName %></td>
                            </tr>
                            <tr>
                                <th>Full Name:</th>
                                <td><%= fullName %></td>
                            </tr>
                            <tr>
                                <th>IC Number:</th>
                                <td><%= icNumber %></td>
                            </tr>
                            <tr>
                                <th>Contact:</th>
                                <td><%= contact %></td>
                            </tr>
                            <tr>
                                <th>Email:</th>
                                <td><%= email %></td>
                            </tr>
                            <tr>
                                <th>Shift:</th>
                                <td><%= shift %></td>
                            </tr>
                            <tr>
                                <th>Post Location:</th>
                                <td><%= postlocation %></td>
                            </tr>
                        </table>
                        <%
                                } else {
                        %>
                        <p>No user profile found.</p>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<p>Error: " + e.getMessage() + "</p>");
                            }
                        %>
                    </div>
                </div>
            </section>
     </main>
   </div>
</body>
</html>
