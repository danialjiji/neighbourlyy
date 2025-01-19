<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rounding Report Form</title>
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
            // Retrieve the userid and username safely
            Integer userid = (Integer) session.getAttribute("userid"); // Use implicit session
        %>
        
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

            <main class="main-content">
                <div class="form-container">
                    <h3>Visitor Form</h3>
                    <p>Please fill all informations</p>
                    <form action="securityController" method="POST" enctype="multipart/form-data">
                        <label for="dateReport">Date of Report</label>
                        <input type="date" name ="dateReport" placeholder="YYYY-MM-DD"/>
                        <p></p>
                        <label for="location">Location</location>
                        <input type="text" name="location" placeholder="Location"/>
                        
                        <label for="remarks">Remarks</label>
                        <input type="text" name="remarks" placeholder="Remarks"/>
                        
                        <label for="attachment">Attachment</label>
                        <input type="file" name="attachment"/>
                        <button type="button" class="upload-btn">Upload</button>
                        
                        <div class="btn-container">
                            <button type="submit" value="Submit" class="btn-submit" >Submit</button>
                            <button type="reset" class="btn-cancel" >Cancel</button>
                        </div>
                        <input type="hidden" name="accessType" value="addReport">
                        <input type="hidden" name="userid" value="<%= userid %>">
                    </form>
        </div>
    </body>
</html>
