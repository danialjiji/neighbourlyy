<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Information</title>
</head>
<body>
     <%
            if (session == null || session.getAttribute("userid") == null) {
        %>
            <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
        <%
                return;
            }
        %>
    <h1>User Information</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Username</th>
                <th>Full Name</th>
                <th>IC Number</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Email</th>
                <th>Vehicle Number Plate</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Database connection parameters
                String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
                String dbUser = "neighborly";
                String dbPassword = "system"; // Replace with your actual password

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load Oracle JDBC Driver
                    Class.forName("oracle.jdbc.OracleDriver");

                    // Establish connection
                    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    // Create SQL query
                    String query = "SELECT u.username, u.\"name\", u.ic_passport, r.unit, u.phoneNum, u.email, u.plate_id, u.userID " +
                                   "FROM users u " +
                                   "LEFT JOIN resident r ON u.userID = r.userID";

                    // Execute query
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    // Iterate through the result set and display data
                    while (rs.next()) {
                        String username = rs.getString("username");
                        String fullName = rs.getString("name");
                        String icNumber = rs.getString("ic_passport");
                        String address = rs.getString("unit") != null ? "Unit: " + rs.getString("unit") : "N/A";
                        String contact = rs.getString("phoneNum");
                        String email = rs.getString("email");
                        String plateId = rs.getString("plate_id");
                        int userId = rs.getInt("userID");
            %>
            <tr>
                <td><%= username %></td>
                <td><%= fullName %></td>
                <td><%= icNumber %></td>
                <td><%= address %></td>
                <td><%= contact %></td>
                <td><%= email %></td>
                <td><%= plateId %></td>
                <td>
                    <form action="updateProfile.jsp" method="post" style="margin: 0;">
                        <input type="hidden" name="userID" value="<%= userId %>" />
                        <button type="submit">Update Profile</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Close resources
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>
</body>
</html>
