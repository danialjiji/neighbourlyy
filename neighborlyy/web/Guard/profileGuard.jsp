<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
     <link rel="stylesheet" href=".../styless.css">
     <style>
         div.content{
             height:100vh;
         }
     </style>
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
                    <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                    <h3>Hi, <%= username %></h3>

                </div>
                    <ul>
                        <a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a>
                        <a href="profileGuard.jsp" class="active">Profile</a>
                        <a href="RoundingReport.jsp">Rounding Report</a>
                        <a href="VisitorForm.jsp">Visitor Form</a>
                        <a href="userlist.jsp">Users List</a>
                        <a href="../LogoutServlet">Logout</a>
                    </ul>
            </aside>

        <!-- Main Content -->
        <div class="content">
            <header class="cardheader">
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
                            String query = "SELECT u.username, u.\"name\", u.ic_passport, g.shift, g.post_location, u.phonenum, u.email, g.salary " +
                            "FROM users u " +
                            "JOIN guard g ON u.userid = g.userid " +
                            "WHERE u.userid = ?";
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
                                    String salary = rs.getString("salary");
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
                            <tr>
                                <th>Salary:</th>
                                <td><%= salary %></td>
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
     </div>
   </div>
</body>
</html>
