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
    <title>Register</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
</head>

<style>  
      
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
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, Danial</h3>
                
            </div>
            
            
            <nav class="menu">
                    <ul>
                        <li><a href="../dashboardAdmin.jsp">Dashboard</a></li>
                        <li><a href="Visitor.jsp">Visitor</a></li>
                        <li><a href="Fee.jsp">Fee</a></li>
                        <li><a href="Report.jsp">Report</a></li>
                        <li><a href="Complaint.jsp">Complaints</a></li>  
                        <li><a href="registerGuard.jsp">Registeration</a></li>
                        <li  class="active"><a href="userllist1.jsp">User List</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Dashboard</h1>
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
              
              <form action="EditServlet" method="post">
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

   
     </main>
   </div>
</body>
</html>

