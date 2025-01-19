<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Success</title>
    <script>
        var message = "<%= request.getAttribute("message") %>";
        var type = "<%= request.getAttribute("type") %>";
        alert(message);
        if (type === "addReport") {
            window.location.href = "RoundingReportTable.jsp";
        }
        if (type === "addVisitor") {
            window.location.href = "VisitorTable.jsp";
        }
    </script>
</head>
<body>
</body>
</html>
