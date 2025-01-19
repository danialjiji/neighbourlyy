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
import java.sql.*;  
import java.util.ArrayList;  
import java.util.List;  
import bean.UserBean;
import util.DBConnection;

public class UserDao {  

    // Update the method to get all users with specific fields from child tables  
    public List<UserBean> getAllUsers() {  
        List<UserBean> users = new ArrayList<>();  
        String query = "SELECT u.userID, u.username, u.\"name\", u.ic_passport, u.phoneNum, u.email, u.plate_id, u.user_type, "  
                + "a.salary, g.shift,g.post_location, r.unit "  
                + "FROM users u "  
                + "LEFT JOIN admin a ON u.userID = a.userID "  
                + "LEFT JOIN guard g ON u.userID = g.userID "  
                + "LEFT JOIN resident r ON u.userID = r.userID";  

        try (Connection conn = DBConnection.createConnection();  
             PreparedStatement stmt = conn.prepareStatement(query);  
             ResultSet rs = stmt.executeQuery()) {  

            while (rs.next()) {  
                UserBean user = new UserBean();  
                user.setUserID(rs.getInt("userID"));  
                user.setUsername(rs.getString("username"));  
                user.setName(rs.getString("name"));  
                user.setIc_passport(rs.getString("ic_passport"));  
                user.setPhoneNum(rs.getString("phoneNum"));  
                user.setEmail(rs.getString("email"));  
                user.setPlate_id(rs.getString("plate_id"));  
                user.setUserType(rs.getString("user_type")); // Add user type field to your UserBean  

                // Load specific fields based on user type  
                if ("admin".equalsIgnoreCase(user.getUserType())) {  
                    user.setSalary(rs.getString("salary"));  
                } else if ("guard".equalsIgnoreCase(user.getUserType())) {  
                    user.setShift(rs.getString("shift")); 
                    user.setPostLocation(rs.getString("postLocation"));  
                } else if ("resident".equalsIgnoreCase(user.getUserType())) {  
                    user.setUnitHouse(rs.getString("unitHouse"));  
                }  

                users.add(user);  
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return users;  
    }  

    // Update methods to handle updates and deletions for all user types  
    public boolean updateUser(UserBean user) {  
        String userUpdateQuery = "UPDATE users SET username = ?, \"name\" = ?, ic_passport = ?, phoneNum = ?, email = ?, plate_id = ? WHERE userID = ?";  
        
        try (Connection conn = DBConnection.createConnection(); 
            PreparedStatement stmt = conn.prepareStatement(userUpdateQuery)) {  
            
            stmt.setString(1, user.getUsername());  
            stmt.setString(2, user.getName());  
            stmt.setString(3, user.getIc_passport());  
            stmt.setString(4, user.getPhoneNum());  
            stmt.setString(5, user.getEmail());  
            stmt.setString(6, user.getPlate_id());  
            stmt.setInt(7, user.getUserID());  
            stmt.executeUpdate();  

            switch (user.getUserType()) {  
                case "admin":  
                    // Update admin specific fields if available  
                    String adminUpdateQuery = "UPDATE admin SET salary = ? WHERE userID = ?";  
                    try (PreparedStatement adminStmt = conn.prepareStatement(adminUpdateQuery)) {  
                        adminStmt.setString(1, user.getSalary());  
                        adminStmt.setInt(2, user.getUserID());  
                        adminStmt.executeUpdate();  
                    }  
                    break;  
                case "guard":  
                    String guardUpdateQuery = "UPDATE guard SET shift = ?, post_location = ? WHERE userID = ?";  
                    try (PreparedStatement guardStmt = conn.prepareStatement(guardUpdateQuery)) {  
                        guardStmt.setString(1, user.getShift()); 
                        guardStmt.setString(2, user.getPostLocation()); 
                        guardStmt.setInt(3, user.getUserID());  
                        guardStmt.executeUpdate();  
                    }  
                    break;  
                case "resident":  
                    String residentUpdateQuery = "UPDATE resident SET unit = ? WHERE userID = ?";  
                    try (PreparedStatement residentStmt = conn.prepareStatement(residentUpdateQuery)) {  
                        residentStmt.setString(1, user.getUnitHouse());  
                        residentStmt.setInt(2, user.getUserID());  
                        residentStmt.executeUpdate();  
                    }  
                    break;  
            }  
            return true;  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return false;  
    }  

    public boolean deleteUser(int userID) {  
        // First delete specific types  
        String deleteAdmin = "DELETE FROM admin WHERE userID = ?";  
        String deleteGuard = "DELETE FROM guard WHERE userID = ?";  
        String deleteResident = "DELETE FROM resident WHERE userID = ?";  
        String deleteUser = "DELETE FROM users WHERE userID = ?";  

        try (Connection conn = DBConnection.createConnection()) {  
            // Remove the specific user type records first  
            try (PreparedStatement stmtAdmin = conn.prepareStatement(deleteAdmin)) {  
                stmtAdmin.setInt(1, userID);  
                stmtAdmin.executeUpdate();  
            }  
            try (PreparedStatement stmtGuard = conn.prepareStatement(deleteGuard)) {  
                stmtGuard.setInt(1, userID);  
                stmtGuard.executeUpdate();  
            }  
            try (PreparedStatement stmtResident = conn.prepareStatement(deleteResident)) {  
                stmtResident.setInt(1, userID);  
                stmtResident.executeUpdate();  
            }  
            // Finally, delete from users table  
            try (PreparedStatement stmtUser = conn.prepareStatement(deleteUser)) {  
                stmtUser.setInt(1, userID);  
                return stmtUser.executeUpdate() > 0;  
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return false;  
    }  
    
    public UserBean getUserById(int userID) {  
    String query = "SELECT u.userID, u.username, u.name, u.ic_passport, u.phoneNum, "  
                 + "u.email, u.plate_id, u.user_type, "  
                 + "a.admin_specific_field, g.guard_specific_field, r.resident_specific_field "  
                 + "FROM users u "  
                 + "LEFT JOIN admin a ON u.userID = a.userID "  
                 + "LEFT JOIN guard g ON u.userID = g.userID "  
                 + "LEFT JOIN resident r ON u.userID = r.userID "  
                 + "WHERE u.userID = ?";  

    UserBean user = null;  
    try (Connection conn = DBConnection.createConnection();  
         PreparedStatement stmt = conn.prepareStatement(query)) {  
        stmt.setInt(1, userID);  
        try (ResultSet rs = stmt.executeQuery()) {  
            if (rs.next()) {  
                user = new UserBean();  
                user.setUserID(rs.getInt("userID"));  
                user.setUsername(rs.getString("username"));  
                user.setName(rs.getString("name"));  
                user.setIc_passport(rs.getString("ic_passport"));  
                user.setPhoneNum(rs.getString("phoneNum"));  
                user.setEmail(rs.getString("email"));  
                user.setPlate_id(rs.getString("plate_id"));  
                user.setUserType(rs.getString("user_type"));  

                // Load specific fields based on user type  
                if ("admin".equalsIgnoreCase(user.getUserType())) {  
                    user.setSalary(rs.getString("salary"));  
                } else if ("guard".equalsIgnoreCase(user.getUserType())) {  
                    user.setShift(rs.getString("shift")); 
                    user.setPostLocation(rs.getString("postLocation"));  
                } else if ("resident".equalsIgnoreCase(user.getUserType())) {  
                    user.setUnitHouse(rs.getString("unitHouse"));  
                }  
            }  
        }  
    } catch (SQLException e) {  
        e.printStackTrace();  
    }  
    return user;  
}  
}