<%-- 
    Document   : registerGuard1
    Created on : Jan 19, 2025, 3:18:14 AM
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
            <header>
                <h1>Dashboard</h1>
                <span>Overview</span>
            </header>     
        
            <div class="form-container">
              <h3>Registeration New Guard</h3>
              <p>Please fill all the field required</p>
              
              <form action="RegisterGuardServlet" method="post">
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

                <label for="shift">Shift</label>
                <input type="text" name="shift" placeholder="Shift" required><br>  

                <label for="postLocation">Post Location</label>
                <input type="text" name="postLocation" placeholder="Post Location" required><br>  


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

