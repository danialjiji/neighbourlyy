/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;
import bean.LoginBean;

public class LoginDao {

    // Method to authenticate user credentials
    public String authenticateUser(LoginBean loginBean) {
        String username = loginBean.getUsername();
        String password = loginBean.getPassword();

        String query = "SELECT * FROM users WHERE username=? AND \"password\"=?";
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return "SUCCESS"; // Credentials are valid
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "Invalid user credentials"; // Credentials are invalid
    }

    // Method to retrieve user ID based on username
    public int getUserId(String username) {
        int userId = -1; // Default value for invalid user
        String query = "SELECT userID FROM users WHERE username=?";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("userID"); // Retrieve user ID from the result set
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId; // Returns -1 if user ID is not found
    }
    
     public boolean isAdmin(int userId) {
        boolean isAdmin = false;
        Connection con = DBConnection.createConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String query = "SELECT COUNT(*) FROM admin WHERE userid = ?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                isAdmin = resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isAdmin;
    }

    public boolean isGuard(int userId) {
        boolean isGuard = false;
        Connection con = DBConnection.createConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String query = "SELECT COUNT(*) FROM guard WHERE userid = ?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                isGuard = resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        return isGuard;
    }

    public boolean isResident(int userId) {
        boolean isResident = false;
        Connection con = DBConnection.createConnection();
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            String query = "SELECT COUNT(*) FROM resident WHERE userid = ?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                isResident = resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } 

        return isResident;
    }
}
