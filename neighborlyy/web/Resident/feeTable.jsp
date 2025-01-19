<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fee Information</title>
</head>
<body>
    <%
        if (session == null || session.getAttribute("userid") == null) {
    %>
        <p>Session expired or not logged in. Please <a href="login.jsp">log in</a>.</p>
    <%
            return;
        }
        
        // Get the logged-in user's ID from the session
        int loggedInUserId = (Integer) session.getAttribute("userid");
    %>
    <h1>Your Fee Information</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Fee Type</th>
                <th>Amount</th>
                <th>Date</th>
                <th>Payment Receipt</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Database connection parameters
                String jdbcURL = "jdbc:oracle:thin:@localhost:1521:XE";
                String dbUser = "neighborly";
                String dbPassword = "system"; // Replace with your actual password

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Load Oracle JDBC Driver
                    Class.forName("oracle.jdbc.OracleDriver");

                    // Establish connection
                    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    // Create SQL query with a WHERE clause
                    String query = "SELECT fc.fee_category_name, f.fee_amount, f.fee_date, f.attachment " +
                                   "FROM fee f " +
                                   "JOIN fee_category fc ON f.fee_category_ID = fc.fee_category_ID " +
                                   "WHERE f.userID = ?";

                    // Prepare statement
                    pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, loggedInUserId);

                    // Execute query
                    rs = pstmt.executeQuery();

                    // Iterate through the result set and display data
                    while (rs.next()) {
                        String feeType = rs.getString("fee_category_name");
                        double feeAmount = rs.getDouble("fee_amount");
                        Date feeDate = rs.getDate("fee_date");
                        String attachment = rs.getString("attachment");
            %>
            <tr>
                <td><%= feeType %></td>
                <td><%= feeAmount %></td>
                <td><%= feeDate %></td>
                <td>
                    <% if (attachment != null && !attachment.isEmpty()) { %>
                        <a href="<%= attachment %>" target="_blank">View Receipt</a>
                    <% } else { %>
                        N/A
                    <% } %>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    // Close resources
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>
</body>
</html>
