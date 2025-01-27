<%@ page import="java.sql.*" %>  
<%@ page import="java.util.*" %>  
<%@ page import="util.DBConnection" %>   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>User List</title>
   <link rel="stylesheet" href="../styless.css">
   <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
</head>
<style>  
   .body {
       height: 100%;
   }
    div.content {
         height: 100vh; /* Set a medium height */
     }   
</style>  
<body>
   <%
       if (session == null || session.getAttribute("userid") == null) {
   %>
       <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
   <%
           return;
       }

       String username = (String) session.getAttribute("username");
       String searchKeyword = request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword").trim() : "";
   %>
   <div class="dashboard-container">
       <!-- Sidebar -->
       <aside style="height: 100vh;" class="sidebar">
           <div class="profile">
               <img style="height:60px; width:60px; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
               <h3>Hi, <%= username %></h3>
           </div>
           <div>
               <a href="/neighborlyy/dashboardGuard.jsp">Dashboard</a>
               <a href="profileGuard.jsp">Profile</a>
               <a href="RoundingReport.jsp">Rounding Report</a>
               <a href="VisitorForm.jsp">Visitor Form</a>
               <a href="userlist.jsp" class="active">Users List</a>
               <a href="../LogoutServlet">Logout</a>
           </div>
       </aside>

       <!-- Main Content -->
       <div class="content">  
           <header class="cardheader">
               <h1>User List</h1>  
               <span>Overview of Users</span> 
           </header>
        <div class="form-container">
          <h3>Search Users</h3>
            <form action="userlist.jsp" method="GET">
                <input 
                    type="text" 
                    id="searchKeyword" 
                    name="searchKeyword" 
                    placeholder="Enter name, ic/passport, plate number or phone number" 
                    value="<%= request.getParameter("searchKeyword") != null ? request.getParameter("searchKeyword") : "" %>">
                <button type="submit" class="btn-submit">Search</button>
                <button><a href="userlist.jsp" class="btn-submit">Reset</a></button>
            </form>
        </div>
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
                           PreparedStatement stmt = null;  
                           ResultSet rs = null;  

                           try {  
                               conn = DBConnection.createConnection();

                               String sql = "SELECT u.userid, u.\"name\", u.ic_passport, u.phonenum, u.email, u.plate_id, r.unit " +  
                                            "FROM users u " +  
                                            "JOIN resident r ON u.userid = r.userid ";

                               if (!searchKeyword.isEmpty()) {
                                   sql += "WHERE LOWER(u.\"name\") LIKE ? OR LOWER(u.ic_passport) LIKE ? OR LOWER(r.unit) LIKE ? OR u.PHONENUM LIKE ?";
                               }

                               stmt = conn.prepareStatement(sql);

                               if (!searchKeyword.isEmpty()) {
                                   String keywordPattern = "%" + searchKeyword.toLowerCase() + "%";
                                   stmt.setString(1, keywordPattern);
                                   stmt.setString(2, keywordPattern);
                                   stmt.setString(3, keywordPattern);
                                   stmt.setString(4, keywordPattern);
                               }

                               rs = stmt.executeQuery();

                               while (rs.next()) {  
                                   int userID = rs.getInt("userid");  
                                   String name = rs.getString("name");    
                                   String icPassport = rs.getString("ic_passport");  
                                   String phoneNum = rs.getString("phonenum");  
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
       </div>  
   </div>  
</body>  
</html>
