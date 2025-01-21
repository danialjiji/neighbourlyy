<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession"%> 
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
     <link rel="stylesheet" href=".../style.css">
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
                <form action="/neighborlyy/residentController" method="POST" enctype="multipart/form-data">
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
                <input type="text" id="Description" placeholder="Description"> 
                
                <label for="receipt">Attachment</label>
                <input type="file" id="receipt" name="receipt" required/>

                <div class="btn-container">
                    <button type="submit" class="btn-submit">Submit</button>
                    <button type="button" class="btn-cancel">Cancel</button>
                     <input type="hidden" name="accessType" value="addComplaints">
                    <input type="hidden" name="userid" value="<%= userid %>">
                </div>
            </form>
        </div>
            
           <section class="data-table">
        <h3>Complaints List</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Complaint ID</th>
                            <th>Complaint Type</th>
                            <th>Complaint Description</th>
                            <th>Complaint Date</th>
                            <th>Complaint Location</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
               <%
                            // Database connection parameters
                            String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
                            String dbUser   = "neighborly";
                            String dbPassword = "system"; // Replace with your actual password

                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;

                            try {
                                // Load Oracle JDBC Driver
                                Class.forName("oracle.jdbc.OracleDriver");

                                // Establish connection
                                conn = DriverManager.getConnection(jdbcURL, dbUser  , dbPassword);

                                // Create SQL query
                                String query = "SELECT c.complaintID, c.userID, ct.comp_type_name, c.complaint_description, " +
                                               "c.complaint_date, c.complaint_location " +
                                               "FROM complaint c " +
                                               "JOIN complaint_type ct ON c.complaint_type_id = ct.complaint_type_id " +
                                               "WHERE c.userID = ?";
                                // Execute query
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery(query);

                                // Iterate through the result set and display data
                                while (rs.next()) {
                                    int complaintID = rs.getInt("complaintID");
                                    int userID = rs.getInt("userID");
                                    String complaintType = rs.getString("comp_type_name");
                                    String complaintDescription = rs.getString("complaint_description");
                                    Date complaintDate = rs.getDate("complaint_date");
                                    String complaintLocation = rs.getString("complaint_location");
                        %>
                        <tr>
                            <td><%= complaintID %></td>
                            <td><%= complaintType %></td>
                            <td><%= complaintDescription %></td>
                            <td><%= complaintDate %></td>
                            <td><%= complaintLocation %></td>
                            <td><a href="/neighborlyy/residentController?accessType=deleteComplaint&id=<%= complaintID %>" class="btn-submit">Delete</a></td-->
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                            } finally {
                                // Close resources
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
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
