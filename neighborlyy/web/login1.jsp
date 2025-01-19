<%-- 
    Document   : login1
    Created on : Jan 19, 2025, 2:09:26 AM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1a style="text-align: center">Login NEIGHBORLY</h1>
        <div style="text-align: center;">
            <form action="LoginServlet" method="post">

            <p style="text-align: center">Username: </p> 
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="username"><br>

            <p style="text-align: center">Password: </p> 
            <input style="text-align: center; display: block; margin: 0 auto;" type="text" name="password"><br>

            <input style="text-align: center" type="submit" value="Login">
            </form>
        </div>
        
    </body>
</html>
