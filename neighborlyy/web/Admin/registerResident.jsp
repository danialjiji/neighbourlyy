<%-- 
    Document   : registerResident1
    Created on : Jan 20, 2025, 3:33:33 AM
    Author     : USER
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
</head>
<style>  
        .switch-button {  
            position: absolute;  
            top: 0;  
            left: 50%;  
            width: 50%;  
            height: 100%;  
            background: linear-gradient(45deg, #d65bb2, #a25cc5);
            border-radius: 20px;  
            transition: transform 0.3s ease;  
        }  
    </style>  

 <script>  
        function slideLeft() {  
            const button = document.getElementById('switchButton');  
            button.style.transform = 'translateX(0)';  
            window.location.href = 'registerGuard1.jsp'; // Redirect to index.jsp  
        }  

        function slideRight() {  
            const button = document.getElementById('switchButton');  
            button.style.transform = 'translateX(100%)';  
            window.location.href = 'registerResident1.jsp'; // Redirect to index2.jsp  
        }  
    </script> 
    
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
            <header>
                <h1>Dashboard</h1>
                <span>Overview</span>
            </header>
            
            <div class="switch" id="toggleSwitch">  
                <div class="switch-button" id="switchButton"></div>  
                <div class="label" onclick="slideLeft()">Register New Guard</div>  
                <div class="label" style="float: right;" onclick="slideRight()">Register New Resident</div>  
            </div> 
            
            <div class="form-container">
              <h3>Registeration New Resident</h3>
              <p>Please fill all the field required</p>
              
              <form action="/neighborlyy/RegisterResidentServlet" method="post">
                <label for="name">Name</label>
                <input type="text" name="name" placeholder="Name" required><br>  

                <label for="email">Email Address</label> 
                <input type="email" name="email" placeholder="Email" required><br> 
            
                <label for="icNumber">Identification Number</label>   
                <input type="text" name="icNumber" placeholder="IC / Passport Number" required><br> 

                <label for="phoneNumbee">Phone Number</label>
                <input type="text" name="phoneNumber" placeholder="Phone Number" required><br> 

                <label for="plateNumber">Plate Number</label>
                <input type="text" name="plateNumber" placeholder="Vehicle Plate Number" required><br>  

                <label for="Username">Username</label>
                <input type="text" name="username" placeholder="Username" required><br>  

                <label for="password">Password</label>
                <input type="password" name="password" placeholder="Passowrd" required><br>  

                <label for="confirmpassword">Confirm Password</label>
                <input type="password" name="confirmpassword" placeholder="Confirm Password" required><br>  

                <label for="shift">Unit House</label>
                <input type="text" name="unitHouse" placeholder="Unit House" required><br>  

                <div class="btn-container">
                    <button type="submit" class="btn-submit">Submit</button>
                    <button type="button" class="btn-cancel">Cancel</button>
                </div>
            </form>
        </div>

   
     </main>
   </div>
</body>
</html>


