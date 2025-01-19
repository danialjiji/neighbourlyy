<%-- 
    Document   : login
    Created on : Jan 5, 2025, 7:42:10 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>  
<html lang="en">  
    <head>  
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link rel="stylesheet" href="style.css">
        <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
        
         <style>  
        * {  
            box-sizing: border-box;  
            margin: 0;  
            padding: 0;  
        }  

        body {  
            display: flex;  
            justify-content: center;  
            align-items: center;  
            height: 100vh;  
            background-color: #f4f4f4; /* Light background color */  
        }  
        
        </style>
    </head>

    <body>
      <div class="login-container">
         <div class="logo-container">  
            <img src="assets/images/logo1.png" alt="logo">  
            <h1>Neighbourly</h1>  
        </div>
       
        <p><b>Hello! Let's get started</b></p>  
        <p>Sign in to continue.</p> 
        <br>
        
        <form action="LoginServlet" method="post"> 
            <p style="text-align: left"><b>Username: </b></p> 
            <input type="text" placeholder="Username" name="username" required><br>

            <p style="text-align: left; margin-top: 10px;"><b>Password: </b></p> 
            <input type="password" placeholder="Password" name="password" required><br>

            <button type="submit">SIGN IN</button>  
        </form>
      </div>  
    </body>
</html>