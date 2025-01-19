<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Display Complaints</title>
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
    <h1>Complaints List</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Complaint ID</th>
                <th>User ID</th>
                <th>Complaint Type</th>
                <th>Complaint Description</th>
                <th>Complaint Date</th>
                <th>Complaint Location</th>
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
                    String query = "SELECT c.complaintID, c.userID, ct.comp_type_name, c.complaint_description, " +
                                   "c.complaint_date, c.complaint_location " +
                                   "FROM complaint c " +
                                   "JOIN complaint_type ct ON c.complaint_type_id = ct.complaint_type_id " +
                                   "WHERE c.userID = ?";
                    // Execute query
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    // Iterate through the result set and display data
                    while (rs.next()) {
                        int complaintID = rs.getInt("complaintID");
                        int userID = rs.getInt("userID");
                        String complaintType = rs.getString("comp_type_name");
                        String complaintDescription = rs.getString("complaint_description");
                        Date complaintDate = rs.getDate("complaint_date");
                        String complaintLocation = rs.getString("complaint_location");
            %>
            <tr>
                <td><%= complaintID %></td>
                <td><%= userID %></td>
                <td><%= complaintType %></td>
                <td><%= complaintDescription %></td>
                <td><%= complaintDate %></td>
                <td><%= complaintLocation %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
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
