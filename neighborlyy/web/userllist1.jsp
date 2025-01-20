<%-- 
    Document   : registerResident1
    Created on : Jan 20, 2025, 3:33:33 AM
    Author     : USER
--%>

<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %>  
<%@ page import="util.DBConnection" %>   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
</head>
<style>  
    .body{
        height: 100%;
    }   
</style>  


    
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside style=" height: 100vh;" class="sidebar" >
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, Danial</h3>
                
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
                            <th>Username</th>  
                            <th>Name</th>  
                            <th>Email</th>  
                            <th>Role</th>  
                            <th>Salary</th>  
                            <th>Shift</th>  
                            <th>Post Location</th>  
                            <th>House Unit</th>  
                            <th>Action</th>  
                        </tr>  
                    </thead>  
                    <tbody>  
                        <%  
                            Connection conn = null;  
                            Statement stmt = null;  
                            ResultSet rs = null;  

                            try {  
                                conn = DBConnection.createConnection();  

                                String sql = "SELECT u.userID, u.username, u.\"name\", u.ic_passport, u.phoneNum, u.email, u.plate_id, " +  
                                             "NVL(a.salary, 0) AS salary, " +  
                                             "NVL(g.shift, '-') AS shift, " +  
                                             "NVL(g.post_location, '-') AS post_location, " +  
                                             "NVL(r.unit, '-') AS unit, " +  
                                             "CASE " +  
                                             "WHEN a.userID IS NOT NULL THEN 'Admin' " +  
                                             "WHEN g.userID IS NOT NULL THEN 'Guard' " +  
                                             "WHEN r.userID IS NOT NULL THEN 'Resident' " +  
                                             "END AS role " +  
                                             "FROM users u " +  
                                             "LEFT JOIN admin a ON u.userID = a.userID " +  
                                             "LEFT JOIN guard g ON u.userID = g.userID " +  
                                             "LEFT JOIN resident r ON u.userID = r.userID " +  
                                             "WHERE (g.shift IS NULL OR REGEXP_LIKE(g.shift, '^[0-9]+(\\.[0-9]+)?$')) " +  
                                             "AND (r.unit IS NULL OR REGEXP_LIKE(r.unit, '^[0-9]+(\\.[0-9]+)?$'))";  

                                System.out.println("Executing SQL: " + sql);  

                                stmt = conn.createStatement();  
                                rs = stmt.executeQuery(sql);  

                                // Loop through the result set and display data  
                                while (rs.next()) {  
                                    // Retrieve userID as an integer  
                                    int userID = rs.getInt("userID");  

                                    // Retrieve other String values  
                                    String username = rs.getString("username");  
                                    String name = rs.getString("name");  
                                    String email = rs.getString("email");  
                                    String icPassport = rs.getString("ic_passport");  
                                    String phoneNum = rs.getString("phoneNum");  
                                    String plateNum = rs.getString("plate_id");  

                                    // Retrieve salary as a double; check for NULL  
                                    double salary = rs.getDouble("salary");  
                                    if (rs.wasNull()) {  
                                        salary = 0.0; // Handle null salary as needed  
                                    }  

                                    // Retrieve shift and unit as strings  
                                    String shift = rs.getString("shift");
                                    String postLocation = rs.getString("post_location");
                                    String unitHouse = rs.getString("unit");  
                                    String role = rs.getString("role");  

                                    // Handle additionalInfo; display salary if not zero, else show "N/A"  
                                    String additionalInfo = salary != 0.0 ? String.valueOf(salary) : "-";  
                               %>  
            
                                <tr>  
                                    <td><%= userID %></td>  
                                    <td><%= username %></td>  
                                    <td><%= name %></td>  
                                    <td><%= email %></td>  
                                    <td><%= role %></td>  
                                    <td><%= additionalInfo %></td>  
                                    <td><%= shift %></td>  
                                    <td><%= postLocation %></td>  
                                    <td><%= unitHouse %></td>  
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