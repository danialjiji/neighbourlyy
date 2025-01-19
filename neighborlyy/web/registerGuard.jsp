<%-- 
    Document   : registerGuard
    Created on : Jan 18, 2025, 9:49:42 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<!DOCTYPE html>  
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <title>Registration Guard</title>  
    </head>  
    
    <body>  
        <h1 style="text-align: center">User Registration</h1>  
        <div style="text-align: center;">  
          
            <form action="RegisterGuardServlet" method="post">  

            <p style="text-align: center">Name: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="name" required><br>  

            <p style="text-align: center">Email: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="email" name="email" required><br> 
            
            <p style="text-align: center">Identification Number: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="icNumber" required><br> 
            
            <p style="text-align: center">Phone Number: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="phoneNumber" required><br> 
            
            <p style="text-align: center">Plate Vehicle Number: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="plateNumber" required><br>  
            
            <p style="text-align: center">Username: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="username" required><br>  

            <p style="text-align: center">Password: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="password" name="password" required><br>  
            
            <p style="text-align: center">Confirm Password: </p>   
            <input style="text-align: center; display: block; margin: 0 auto;" type="password" name="confirmpassword" required><br>  

            <p style="text-align: center">Shift: </p>  
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="shift" required><br>  
            
            <p style="text-align: center">Post Location: </p>  
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="postLocation" required><br>  

            <input style="text-align: center" type="submit" value="Confirm Registration">  
            </form>  
        </div>  
        
    </body>  
</html>
