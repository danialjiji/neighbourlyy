<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession"%> 
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complaint</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
     <link rel="stylesheet" href="../styless.css">
     <style>
         .dashboard-container{
             background-color: #f4f4f9;
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
                    <a href="./profile.jsp">Profile</a>
                    <a class="active" href="./complaint.jsp">Complaint</a>
                    <a href="./fee.jsp">Fee</a>
                    <a href="/neighborlyy/LogoutServlet">Log Out</a>
            </div>
        </aside>

        <!-- Main Content -->
       <div class="content">
            <header class="cardheader">
                <h1>Complaint</h1>
            </header>
            <div class="form-container">
                <h3>Complaint Form</h3><br>
                <p>Please Fill in the Form to Complaint to Management</p>
                <form action="/neighborlyy/residentController" method="POST" enctype="multipart/form-data">
                <label for="gender">Complaint Type</label>
                <select id="complaintType"name="complaintType">
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
                <input type="text" id="Location" placeholder="Location" name="location">

                <label for="email">Description</label>
                <input type="text" id="Description" placeholder="Description" name="description"> 
                
                <label for="receipt">Attachment</label>
                <input type="file" id="receipt" name="attachment" required/>

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
                            <th>Attachment</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
               <%

                            try {
                                Connection conn = DBConnection.createConnection();
                                String query = "SELECT c.COMPLAINTID, s.STATUS_DESCRIPTION, ct.COMP_TYPE_NAME, c.COMPLAINT_DESCRIPTION, " +
                                               "c.COMPLAINT_DATE, c.COMPLAINT_LOCATION, c.COMPLAINT_ATTACHMENT " +
                                               "FROM COMPLAINT c " +
                                               "JOIN COMPLAINT_TYPE ct ON c.COMPLAINT_TYPE_ID = ct.COMPLAINT_TYPE_ID " +
                                               "JOIN STATUS s ON c.STATUSID = s.STATUSID " +
                                               "WHERE c.USERID = ?";

                                PreparedStatement stmt = conn.prepareStatement(query);
                                stmt.setInt(1, userid);
                                ResultSet rs = stmt.executeQuery();
                                
                                // Iterate through the result set and display data
                                while (rs.next()) {
                                    int complaintID = rs.getInt("complaintid");
                                    String complaintType = rs.getString("comp_type_name");
                                    String complaintDescription = rs.getString("complaint_description");
                                    Date complaintDate = rs.getDate("complaint_date");
                                    String complaintLocation = rs.getString("complaint_location");
                                    String statusDesc = rs.getString ("status_description");
                                    String attachment = rs.getString("complaint_attachment");
                        %>
                        <tr>
                            <td><%= complaintID %></td>
                            <td><%= complaintType %></td>
                            <td><%= complaintDescription %></td>
                            <td><%= complaintDate %></td>
                            <td><%= complaintLocation %></td>
                            
                             <td>
                                <% if (attachment != null && !attachment.isEmpty()) { %>
                                    <a href="attachmentfile/<%= attachment %>">View</a>
                                <% } else { %>
                                    No Attachment
                                <% } %>
                            </td>
                        <td><%= statusDesc %></td>
                            <td><a href="/neighborlyy/residentController?accessType=deleteComplaint&id=<%= complaintID %>" class="btn-submit">Delete</a></td-->
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        %>
            </tbody>
        </table>
    </section>
     </div>
   </div>
</body>
</html>
