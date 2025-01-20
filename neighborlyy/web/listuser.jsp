<%-- 
    Document   : listuser
    Created on : Jan 19, 2025, 11:50:40 PM
    Author     : USER
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:setDataSource var="myDatasource" 
driver="oracle.jdbc.OracleDriver"
url="jdbc:oracle:thin:@localhost:1521:XE" user="proj_neighborly" password="system"/>
<!DOCTYPE html>  
<html>  
<head>  
    <meta charset="UTF-8">  
    <title>User List</title>  
</head>  
<body>  
    <h1>User List</h1>  
    
    <table border="1">  
        <tr>  
            <th>User ID</th>  
            <th>Username</th>  
            <th>Name</th>  
            <th>IC/Passport</th>  
            <th>Phone Number</th>  
            <th>Email</th>  
            <th>Plate ID</th>   
            <th>Actions</th>  
        </tr>  
        <c:forEach var="user" items="${users}">  
            <tr>  
                <td>${user.userID}</td>  
                <td>${user.username}</td>  
                <td>${user.name}</td>  
                <td>${user.ic_passport}</td>  
                <td>${user.phoneNum}</td>  
                <td>${user.email}</td>  
                <td>${user.plate_id}</td>   
                <td>  
                    <form action="listUsers" method="post" style="display:inline;">  
                        <input type="hidden" name="userID" value="${user.userID}" />  
                        <input type="hidden" name="action" value="edit" />  
                        <input type="submit" value="Edit" />  
                    </form>  
                    <form action="listUsers" method="post" style="display:inline;">  
                        <input type="hidden" name="userID" value="${user.userID}" />  
                        <input type="hidden" name="action" value="delete" />  
                        <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this user?');" />  
                    </form>  
                </td>  
            </tr>  
        </c:forEach>  
    </table>  
    
    <sql:query var="result" dataSource="${myDatasource}">      
            SELECT * FROM users
        </sql:query>
                          
        <table border="1">
            <!-- column headers -->
            <tr>              
                <c:forEach var="columnName" items="${result.columnNames}">
                    <th><c:out value="${columnName}"/></th>                           
                </c:forEach>                 
            </tr>
            <!-- column data -->
            <c:forEach var="row" items="${result.rowsByIndex}">
                <tr>
                    <c:forEach var="column" items="${row}">
                        <td><c:out value="${column}"/></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table> 
</body>  
</html>