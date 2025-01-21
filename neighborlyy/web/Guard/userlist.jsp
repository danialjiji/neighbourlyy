<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %>  
<%@ page import="util.DBConnection" %>   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link rel="stylesheet" href="../style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
</head>
<style>  
    .body{
        height: 100%;
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
            
            // Retrieve the userid and username safely
            String username = (String) session.getAttribute("username");
    %>
        
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside style=" height: 100vh;" class="sidebar" >
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                <h3>Hi, <%= username %></h3>
                
            </div>
            
            
            <nav class="menu">
                    <ul>
                        <li><a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a></li>
                        <li><a href="profileGuard.jsp">Profile</a></li>
                        <li><a href="RoundingReport.jsp">Rounding Report</a></li>
                        <li><a href="RoundingReportTable.jsp">Rounding Report List</a></li>
                        <li><a href="VisitorForm.jsp">Visitor Form</a></li>
                        <li><a href="VisitorTable.jsp">Visitor List</a></li>
                        <li class="active"><a href="userlist.jsp">Users List</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
            </nav>
        </aside>

        <!-- Main Content -->  
        <main class="main-content">  
            <header class="cardheader">  
                <h1>User List</h1>  
                <span>Overview of Users</span>  
            </header>  
            <section class="data-table">  
                <h3>Recent Users</h3>  
                <table class="table">  
                    <thead>  
                        <tr>  
                            <th>UserID</th>   
                            <th>Name</th>  
                            <th>IC/Passport</th>
                            <th>Phone Number</th>
                            <th>Plate Number</th>
                            <th>Email</th>  
                            <th>House Unit</th>  
                        </tr>  
                    </thead>  
                    <tbody>  
                        <%  
                            Connection conn = null;  
                            Statement stmt = null;  
                            ResultSet rs = null;  

                            try {  
                                conn = DBConnection.createConnection();  

                                String sql = "SELECT u.userid, u.\"name\", u.ic_passport, u.phonenum, u.email, u.plate_id, r.unit " +  
                                             "FROM users u " +  
                                             "JOIN resident r ON u.userid = r.userid ";

                                System.out.println("Executing SQL: " + sql);  

                                stmt = conn.createStatement();  
                                rs = stmt.executeQuery(sql);  

                                // Loop through the result set and display data  
                                while (rs.next()) {  
                                    // Retrieve userID as an integer  
                                    int userID = rs.getInt("userid");  

                                    // Retrieve other String values  
                                    String name = rs.getString("name");    
                                    String icPassport = rs.getString("ic_passport");  
                                    String phoneNum = rs.getString("phoneNum");  
                                    String email = rs.getString("email");
                                    String plateNum = rs.getString("plate_id");  

                                    String unitHouse = rs.getString("unit");  

                               %>  
            
                                <tr>  
                                    <td><%= userID %></td>  
                                    <td><%= name %></td>
                                    <td><%= icPassport %></td>  
                                    <td><%= phoneNum %></td>
                                    <td><%= plateNum %></td>
                                    <td><%= email %></td>   
                                    <td><%= unitHouse %></td>  
                                </tr>  
                          <%  
                                }  
                            } catch (SQLException sqlException) {  
                                out.println("<h3>Error executing database query: " + sqlException.getMessage() + "</h3>");  
                                sqlException.printStackTrace();  
                            } catch (Exception e) {  
                                out.println("<h3>An unexpected error occurred: " + e.getMessage() + "</h3>");  
                                e.printStackTrace();  
                            } finally {  
                                if (rs != null) try { rs.close(); } catch (SQLException e) {}  
                                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}  
                                if (conn != null) try { conn.close(); } catch (SQLException e) {}  
                            }  
                        %>  
                    </tbody>  
                </table>  
            </section>  
        </main>  
    </div>  
</body>  
</html>