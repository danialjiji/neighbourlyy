/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author USER
 */
  
import java.sql.Connection; 
import java.sql.ResultSet; 
import java.sql.PreparedStatement; 
import bean.EditBean;
import util.DBConnection;
import java.sql.SQLException;  

public class EditDao {  

    public boolean updateUser(EditBean user) {  
        boolean isSuccess = false;  
        Connection conn = null;  
        PreparedStatement pstmt = null;  

        try {  
            conn = DBConnection.createConnection();  

            // Start transaction  
            conn.setAutoCommit(false);   

            // Update user in the users table  
            String sqlUser = "UPDATE users SET username = ?, \"name\" = ?, ic_passport = ?, phoneNum = ?, email = ?, plate_id=? " +  
                             "WHERE userID = ?";  
            pstmt = conn.prepareStatement(sqlUser);  
            pstmt.setString(1, user.getUsername());  
            pstmt.setString(2, user.getName());  
            pstmt.setString(3, user.getIcPassport());  
            pstmt.setString(4, user.getPhoneNum());  
            pstmt.setString(5, user.getEmail());
            pstmt.setString(6, user.getPlateNumber()); 
            pstmt.setInt(7, user.getUserID());  
            pstmt.executeUpdate(); // No need to check rowCount here because we rely on the transaction for success  

            // Check which table to update based on the existence of records  
            if (user.getSalary() > 0) {  
                // Update in admin table if exists  
                String sqlAdmin = "UPDATE admin SET salary = ? WHERE userID = ?";  
                pstmt = conn.prepareStatement(sqlAdmin);  
                pstmt.setDouble(1, user.getSalary());  
                pstmt.setInt(2, user.getUserID());  
                pstmt.executeUpdate();  
            }  

            if (user.getShift() != null && !user.getShift().isEmpty() && user.getPostlocation() != null && !user.getPostlocation().isEmpty()) {  
                // Update in guard table if exists  
                String sqlGuard = "UPDATE guard SET shift = ? post_location = ? WHERE userID = ?";  
                pstmt = conn.prepareStatement(sqlGuard);  
                pstmt.setString(1, user.getShift()); 
                pstmt.setString(2, user.getPostlocation());  
                pstmt.setInt(3, user.getUserID());  
                pstmt.executeUpdate();  
            }  

            if (user.getUnit() != null && !user.getUnit().isEmpty()) {  
                // Update in resident table if exists  
                String sqlResident = "UPDATE resident SET unit = ? WHERE userID = ?";  
                pstmt = conn.prepareStatement(sqlResident);  
                pstmt.setString(1, user.getUnit());  
                pstmt.setInt(2, user.getUserID());  
                pstmt.executeUpdate();  
            }  

            // Commit the transaction if all updates succeeded  
            conn.commit();  
            isSuccess = true; // Changes are successful  
        } catch (SQLException e) {  
            if (conn != null) {  
                try {  
                    conn.rollback(); // Rollback in case of error  
                } catch (SQLException rollbackEx) {  
                    rollbackEx.printStackTrace();  
                }  
            }  
            e.printStackTrace();  
        } finally {  
            if (pstmt != null) {  
                try {   
                    pstmt.close();   
                } catch (SQLException e) {   
                    e.printStackTrace();   
                }  
            }  
            if (conn != null) {  
                try {   
                    conn.close();   
                } catch (SQLException e) {   
                    e.printStackTrace();   
                }  
            }  
        }  
        return isSuccess;  
    }  

    
    public EditBean getUserById(int userID) {  
    EditBean user = null;  
    Connection conn = null;  
    PreparedStatement pstmt = null;  
    ResultSet rs = null;  

    try {  
        conn = DBConnection.createConnection();  
        String sql = "SELECT u.userID, u.username, u.\"name\", u.ic_passport, u.phoneNum, u.email, u.plate_id, " +  
                        "NVL(a.salary, 0) AS salary, " +  
                        "NVL(g.shift, '-') AS shift, " +  
                        "NVL(g.post_location, '-') AS post_location, " +  
                        "NVL(r.unit, '-') AS unit, " +  
                        "CASE " +  
                        "WHEN a.userID IS NOT NULL THEN 'Admin' " +  
                        "WHEN g.userID IS NOT NULL THEN 'Guard' " +  
                        "WHEN r.userID IS NOT NULL THEN 'Resident' " +  
                        "END AS role " +  
                        "FROM users u " +  
                        "LEFT JOIN admin a ON u.userID = a.userID " +  
                        "LEFT JOIN guard g ON u.userID = g.userID " +  
                        "LEFT JOIN resident r ON u.userID = r.userID " +  
                        "WHERE u.userID = ? " +  // Add the placeholder for userID  
                        "AND (g.shift IS NULL OR REGEXP_LIKE(g.shift, '^[0-9]+(\\.[0-9]+)?$')) " +  
                        "AND (r.unit IS NULL OR REGEXP_LIKE(r.unit, '^[0-9]+(\\.[0-9]+)?$'))";
        
        pstmt = conn.prepareStatement(sql);  
        pstmt.setInt(1, userID);  
        rs = pstmt.executeQuery();  

        if (rs.next()) {  
            user = new EditBean();  
            user.setUserID(rs.getInt("userID"));  
            user.setUsername(rs.getString("username"));  
            user.setName(rs.getString("name"));  
            user.setIcPassport(rs.getString("ic_passport"));  
            user.setPhoneNum(rs.getString("phoneNum"));  
            user.setEmail(rs.getString("email")); 
            user.setPlateNumber(rs.getString("plate_id"));  
            user.setSalary(rs.getDouble("salary"));  
            user.setShift(rs.getString("shift"));  
            user.setUnit(rs.getString("unit"));  
        }  
    } catch (SQLException e) {  
        e.printStackTrace();  
    } finally {  
        if (rs != null) try { rs.close(); } catch (SQLException e) {}  
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}  
        if (conn != null) try { conn.close(); } catch (SQLException e) {}  
    }  
    return user;  
}
}