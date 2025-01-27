/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;  

import bean.RegisterGuardBean;  
import util.DBConnection;  
import java.sql.Connection;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;
import java.sql.SQLException;  

public class RegisterGuardDao {  

    private Connection connection;  

    public RegisterGuardDao() {  
        connection = DBConnection.createConnection();  
    }  

  public boolean registerUser(RegisterGuardBean registerBean) {  
    String insertUserSQL = "INSERT INTO users (username, \"password\", \"name\", ic_passport, phonenum, email, plate_id) VALUES (?, ?, ?, ?, ?, ?, ?)";  
    String insertChildSQL = "INSERT INTO guard (userID, shift, post_location, salary) VALUES (?, ?, ?, ?)";  
    
    try {  
        // Inserting into the users table  
        PreparedStatement statementUser = connection.prepareStatement(insertUserSQL, new String[]{"userID"});  
        statementUser.setString(1, registerBean.getUsername());  
        statementUser.setString(2, registerBean.getPassword()); // Ensure hash the password before storing it  
        statementUser.setString(3, registerBean.getName());  
        statementUser.setString(4, registerBean.getIcNumber()); 
        statementUser.setString(5, registerBean.getPhoneNumber()); 
        statementUser.setString(6, registerBean.getEmail()); 
        statementUser.setString(7, registerBean.getPlateNumber());  
        int userResult = statementUser.executeUpdate();  

        if (userResult > 0) {  
            // Retrieve the generated userID  
            ResultSet generatedKeys = statementUser.getGeneratedKeys();  
            if (generatedKeys.next()) {  
                int userId = generatedKeys.getInt(1); // Get the generated userID  
                
                // Inserting into the guard table  
                try (PreparedStatement statementGuard = connection.prepareStatement(insertChildSQL)) {  
                    statementGuard.setInt(1, userId);  
                    statementGuard.setString(2, registerBean.getShift()); // Add these fields to your RegisterBean  
                    statementGuard.setString(3, registerBean.getPostlocation());  
                    statementGuard.setDouble(4, registerBean.getSalary()); 
                    return statementGuard.executeUpdate() > 0; // Return true if guard added successfully  
                }  
            }  
        }  
    } catch (SQLException e) {  
        e.printStackTrace();  
    }  
    return false; // Registration failed  
}  

}
