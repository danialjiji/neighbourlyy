<%@page import="util.DBConnection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Report</title>
        <link rel="stylesheet" href="../style.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="dashboard-container">
        <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return;
            }

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
                    <li class="active"><a href="#">Dashboard</a></li>
                    <li><a href="#">Basic UI Elements</a></li>
                    <li><a href="#">Icons</a></li>
                    <li><a href="#">Forms</a></li>
                    <li><a href="#">Charts</a></li>
                    <li><a href="#">Tables</a></li>
                    <li><a href="#">Sample Pages</a></li>
                    <li><a href="#" class="btn-add-project">+ Add a Project</a></li>
                </ul>
            </nav>
        </aside>
        
        <main class="main-content">
        <h1>List Rounding Report</h1>

            <section class="data-table">
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
                            String query = "SELECT * FROM report WHERE userid = ?";
                            PreparedStatement stmt = conn.prepareStatement(query);
                            stmt.setInt(1, userid);
                            ResultSet rs = stmt.executeQuery();

                            while (rs.next()) {
                                int reportID = rs.getInt("reportid");
                                Date dateOfVisit = rs.getDate("dateofvisit");
                                String location = rs.getString("location");
                                String remarks = rs.getString("remarks");
                                Blob attachmentBlob = rs.getBlob("attachment");

                                // Format the date
                                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                String onlyDate = dateFormat.format(dateOfVisit);

                                // For demonstration, you can extract BLOB size or display download link
                                String attachmentLink = attachmentBlob != null 
                                    ? "<a href='downloadAttachment?id=" + reportID + "'>Download</a>" 
                                    : "No Attachment";
                    %>
                    <tbody
                        <tr>
                            <td><%= reportID %></td>
                            <td><%= onlyDate %></td>
                            <td><%= location %></td>
                            <td><%= remarks %></td>
                            <td><%= attachmentLink %></td>
                            <td><a href="securityController?accessType=deleteReport&id=<%= reportID %>" class="btn-submit">Delete</a></td>
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
        </main>
        </div>
    </body>
</html>
