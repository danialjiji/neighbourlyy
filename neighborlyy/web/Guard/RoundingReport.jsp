<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rounding Report Form</title>
    </head>
    <body>
        <form action="securityController" method="POST" enctype="multipart/form-data">
            <p>Date of Report</p>
                <input type="date" id="dateReport" name ="dateReport" placeholder="YYYY-MM-DD"/><br>
            <p>Location</p>
                <input type="text" id="location" name="location"/><br>
            <p>Remarks</p>
                <input type="text" id="remarks" name="remarks"/><br>
            <p>Attachment</p>
            <input type="file" id="attachment" name="attachment"/><br>
            <button type="submit" value="Submit" >Submit</button>
            <button type="reset" >Cancel</button>
            <input type="hidden" name="accessType" value="add">
            <input type="hidden" name="userid" value="10001">
        </form>
    </body>
</html>
