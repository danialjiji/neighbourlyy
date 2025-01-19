<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <script>
        var message = "<%= request.getAttribute("message") %>";
        var errorType = "<%= request.getAttribute("errorType") %>";
        alert(message);
        if (errorType === "addReport") {
            window.location.href = "RoundingReport.jsp";
        } else if (errorType === "addVisitor") {
            // Redirect to editform.jsp with the id
            window.location.href = "VisitorForm.jsp";
        } else {
            window.location.href = "complaint.jsp";
        }
    </script>
</head>
<body>
</body>
</html>