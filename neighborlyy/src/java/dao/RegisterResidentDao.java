/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import bean.RegisterResidentBean;  
import util.DBConnection;  
import java.sql.Connection;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;
import java.sql.SQLException;  

public class RegisterResidentDao {  

    private Connection connection;  

    public RegisterResidentDao() {  
        connection = DBConnection.createConnection();  
    }  

  public boolean registerUser(RegisterResidentBean registerBean) {
    String insertUserSQL = "INSERT INTO users (username, \"password\", \"name\", ic_passport, phonenum, email, plate_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
    String insertChildSQL = "INSERT INTO resident (userID, unit) VALUES (?, ?)";

    try {
        // Inserting into the users table
        PreparedStatement statementUser = connection.prepareStatement(insertUserSQL, new String[] { "userID" });
        statementUser.setString(1, registerBean.getUsername());
        statementUser.setString(2, registerBean.getPassword()); // Ensure you hash the password before storing it
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

                // Inserting into the resident table
                try (PreparedStatement statementResident = connection.prepareStatement(insertChildSQL)) {
                    statementResident.setInt(1, userId);
                    statementResident.setString(2, registerBean.getUnitHouse());
                    return statementResident.executeUpdate() > 0; // Return true if resident added successfully
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false; // Registration failed
}


}
