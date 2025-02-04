<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
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
                    <a class="active" href="./profile.jsp">Profile</a>
                    <a href="./complaint.jsp">Complaint</a>
                    <a href="./fee.jsp">Fee</a>
                    <a href="/neighborlyy/LogoutServlet">Log Out</a>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="content">
            <header class="cardheader">
                <h1>Profile</h1>
              
            </header>
            
           <section class="data-table">
               
                <div class="profile-container">
                    <h1>User Profile</h1>
                    <div class="profile-box">
                        <%
                            // Database connection parameters
                            String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
                            String dbUser = "neighborly";
                            String dbPassword = "system"; // Replace with your actual password

                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;

                            try {
                                // Load Oracle JDBC Driver
                                Class.forName("oracle.jdbc.OracleDriver");

                                // Establish connection
                                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                                // SQL query to fetch user profile based on session userID
                                String query = "SELECT u.username, u.\"name\", u.ic_passport, r.unit, u.phoneNum, u.email, u.plate_id " +
                                               "FROM users u " +
                                               "LEFT JOIN resident r ON u.userID = r.userID " +
                                               "WHERE u.userID = ?";

                                // Execute query with session userID
                                int sessionUserId = Integer.parseInt(session.getAttribute("userid").toString());
                                pstmt = conn.prepareStatement(query);
                                pstmt.setInt(1, sessionUserId);
                                rs = pstmt.executeQuery();

                                if (rs.next()) {
                                  
                                    String fullName = rs.getString("name");
                                    String icNumber = rs.getString("ic_passport");
                                    String address = rs.getString("unit") != null ? rs.getString("unit") : "N/A";
                                    String contact = rs.getString("phoneNum");
                                    String email = rs.getString("email");
                                    String plateId = rs.getString("plate_id");
                        %>
                        <!-- Profile Display -->
                        <table class="profile-table">
                            <tr>
                                <th>Username:</th>
                                <td><%= username %></td>
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
                                <th>Address:</th>
                                <td><%= address %></td>
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
                                <th>Vehicle Number Plate:</th>
                                <td><%= plateId %></td>
                            </tr>
                        </table>
                        <br>
                        <div class="profile-actions">
                            <form action="updateProfile.jsp" method="post">
                                <input type="hidden" name="userID" value="<%= sessionUserId %>" />
                                <button type="submit" class="btn-submit" href="updateProfile.jsp">Update Profile</button>
                            </form>
                        </div>
                        <%
                                } else {
                        %>
                        <p>No user profile found.</p>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<p>Error: " + e.getMessage() + "</p>");
                            } finally {
                                // Close resources
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </div>
                </div>
            </section>
        </div>
     </div>
   </body>
</html>