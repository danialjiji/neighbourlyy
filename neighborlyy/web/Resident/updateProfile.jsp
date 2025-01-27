<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page import="javax.servlet.http.HttpSession"%> 
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
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
            
            <div class="form-container">
                <h3>Update Profile</h3><br>
                <p>Please Fill in the Form to Update Profile to Management</p>
                <form action="/neighborlyy/updateServlet" method="POST" enctype="multipart/form-data">
              
                <label for="email">Email</label>
                <input type="email" id="Email" placeholder="Email" name="email">

                <label for="phoneNum">Phone Number</label>
                <input type="text" id="phoneNum" placeholder="Phone Number" name="phoneNum"> 
                
                <div class="btn-container">
                    <button type="submit" class="btn-submit">Submit</button>
                    <button type="button" class="btn-cancel">Cancel</button>
                     <input type="hidden" name="accessType" value="updateProfile">
                    <input type="hidden" name="userid" value="<%= userid %>">
                </div>
            </form>
        </div>
      </div>
    </div>
   </body>
</html>