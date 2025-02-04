<%-- 
    Document   : editUser1
    Created on : Jan 20, 2025, 4:18:49 AM
    Author     : USER
--%>
<%@ page import="java.sql.*" %>  
<%@ page import="bean.EditBean" %>  
<%@ page import="dao.EditDao" %>  
<%@ page import="util.DBConnection" %>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
    <link rel="stylesheet" href="../styless.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
</head>

<style>  
        div.content{
            height:100vh;
        }
    
        /* Input Fields */  
        .form-container input[type="number"] {  
            width: 100%;  
            padding: 10px 15px;  
            margin-bottom: 20px;  
            border: 1px solid #eaeaea;  
            border-radius: 5px;  
            background-color: #ffffff;  
            font-size: 14px;  
            color: #333;  
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
            Integer useridss = (Integer) session.getAttribute("userid"); // Use implicit session
            String usernamess = (String) session.getAttribute("username");
        %>
        
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="../assets/images/profile1.png" alt="logo"> 
                <h3>Hi, Danial</h3>
                
            </div>
            
            <div>
                <ul>
                    <a href="../dashboardAdmin.jsp">Dashboard</a>
                    <a href="Visitor.jsp">Visitor</a>
                    <a href="Fee.jsp">Fee</a>
                    <a href="Report.jsp">Report</a>
                    <a href="Complaint.jsp">Complaints</a>
                    <a href="registerGuard.jsp">Registration</a>
                    <a class="active" href="userllist1.jsp">User List</a>
                    <a href="../LogoutServlet">Logout</a>
                </ul>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="content">
            <header class="cardheader">
                <h1>User List</h1>
                <span>Overview</span>
            </header>     

            <%  
                String userIDParam = request.getParameter("userID");  
                String role = request.getParameter("role"); 
                if (userIDParam == null) {  
                    out.println("<h3>Error: User ID is missing.</h3>");  
                    return; // Stop further processing  
                }  

                int userID = Integer.parseInt(userIDParam);  
                EditDao editDao = new EditDao();  
                EditBean user = editDao.getUserById(userID);  

                if (user == null) {  
                    out.println("<h3>Error: User not found.</h3>");  
                    return; // Stop further processing  
                }  
            %> 
            
           <div class="form-container">
              <h3>Edit User Details</h3>
              <p>Please fill all the field required</p>
              
              <form action="/neighborlyy/EditServlet" method="post">
               <input type="hidden" name="userID" value="<%= user.getUserID() %>">  
             
                <label for="Username">Username</label>
                 <input type="text" name="username" value="<%= user.getUsername() %>" required><br>  
                
                <label for="name">Name</label>
                <input type="text" name="name" value="<%= user.getName() %>" required><br>  

                <label for="icNumber">Identification Number</label>   
                <input type="text" name="ic_passport" value="<%= user.getIcPassport() %>" required><br>  

                <label for="phoneNumbee">Phone Number</label>
                <input type="text" name="phoneNum" value="<%= user.getPhoneNum() %>" required><br>  
                
                <label for="email">Email Address</label> 
                 <input type="email" name="email" value="<%= user.getEmail() %>" required><br>
                
                <label for="plateNumber">Plate Number</label>
                <input type="text" name="plateNumber" value="<%= user.getPlateNumber() %>" required><br>  
                
                 <%-- Conditionally display fields based on user type --%>  
                <%  
                    String userType = role; // Assuming this method exists in EditBean  
                    if ("admin".equalsIgnoreCase(userType)) {  
                %>  
                   <label for="salary">Salary</label>
                   <input type="number" name="salary" value="<%= user.getSalary() %>" required><br>  
                <%  
                    } else if ("guard".equalsIgnoreCase(userType)) {  
                %>  
                    <label for="shift">Shift</label> 
                    <input type="text" name="shift" value="<%= user.getShift() %>" required><br>  
                    
                    <label for="postlocation">Post Location</label> 
                    <input type="text" name="postlocation" value="<%= user.getPostlocation() %>" required><br> 
                    
                    <label for="salary">Salary</label>
                   <input type="number" name="salary" value="<%= user.getSalary() %>" required><br>
                <%  
                    } else if ("resident".equalsIgnoreCase(userType)) {  
                %>  
                
                <label for="unit">House Unit</label>   
                <input type="text" name="unit" value="<%= user.getUnit() %>" required><br>  
                <%  
                    }  
                %>  
                            <input type="hidden" name="action" value="update">  
                                  
                <div class="btn-container">
                    <button type="submit" class="btn-submit"value="Update User">Update User</button>
                    <button type="button" class="btn-cancel" onclick="window.location.href='userllist1.jsp';">Cancel</button>
                </div>
            </form>
        </div>

   
     </div>
   </div>
</body>
</html>

