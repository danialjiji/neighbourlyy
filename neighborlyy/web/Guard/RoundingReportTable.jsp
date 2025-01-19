<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<sql:setDataSource var="myDatasource"
    driver="oracle.jdbc.OracleDriver"
    url="jdbc:oracle:thin:@localhost:1521:XE"
    user="neighborly"
    password="system"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Report</title>
    </head>
    <body>
        <h1>List Rounding Report</h1>
        <sql:query var="result" dataSource="${myDatasource}">
             SELECT * FROM NEIGHBORLY.REPORT
        </sql:query>

        <table border="1">
            <!-- column headers -->
            <tr>
                <c:forEach var="columnName" items="${result.columnNames}">
                    <th><c:out value="${columnName}"/></th>
                    </c:forEach>
                    <th></th>
            </tr>
             <!-- column data -->
             <c:forEach var="row" items="${result.rowsByIndex}">
                 <tr>
                     <c:forEach var="column" items="${row}">
                         <td><c:out value="${column}"/></td>
                     </c:forEach>
                    <td><a href="securityController?accessType=delete&id=${row[0]}">Delete</a></td>
                 </tr>
             </c:forEach>
        </table>    
    </body>
</html>
