<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Profile</title>
    </head>
    <body>
        <form action="updateServlet" method="POST" enctype="multipart/form-data">
            <p>Email</p>
                <input type="text" id="email" name="email"/><br>
            <p>Phone Number</p>
                <input type="text" id="phoneNum" name="phoneNum"/><br>
            <button type="submit" value="Submit" >Submit</button>
            <button type="reset" >Cancel</button>
            <input type="hidden" name="accessType" value="updateProfile">
            <input type="hidden" name="userid" value="10001">
        </form>
    </body>
</html>
