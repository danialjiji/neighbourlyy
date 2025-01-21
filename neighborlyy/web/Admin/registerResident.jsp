<%-- 
    Document   : RegisterResidentBean
    Created on : Jan 18, 2025, 10:46:41 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<!DOCTYPE html>  
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <title>Registration Resident</title>  
    </head>  
    
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
                        <li class="active"><a href="registerGuard.jsp">Registeration</a></li>
                        <li><a href="userllist1.jsp">User List</a></li>
                        <li><a href="../LogoutServlet">Logout</a></li>
                    </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">         

                                        
             <div class="form-container">
                <h3>Register Resident</h3>
                
                <form action="RegisterResidentServlet" method="post">  

            Name: <input type="text" name="name" required><br>  

            Email: <input type="email" name="email" required><br> 
            
            Identification Number: <input type="text" name="icNumber" required><br> 
            
            Phone Number: <input type="text" name="phoneNumber" required><br> 
            
            Plate Vehicle Number: <input type="text" name="plateNumber" required><br>  
            
            Username: <input type="text" name="username" required><br>  

            Password: <input type="password" name="password" required><br>  
            
            Confirm Password:<input type="password" name="confirmpassword" required><br>  

            Unit House:<input type="text" name="unitHouse" required><br>  
            

            <div class="btn-container">
                <button type="submit" class="btn-submit" value="Confirm Registration">Confirm Registration</button>
            </div>
            </form>
               
        </div>

   
     </main>
   </div>
        
    </body>  
</html>
