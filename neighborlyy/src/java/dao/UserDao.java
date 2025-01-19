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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;
import bean.UserBean;

public class UserDao {

    // Retrieve all users based on category (admin, guard, resident)
    public static List<UserBean> getUsersByCategory(String category) {
        List<UserBean> users = new ArrayList<>();
        String query = "";

        // Define query based on the category
        switch (category.toLowerCase()) {
            case "admin":
                query = "SELECT u.user_id, u.username, u.name, u.phone_num, u.email, a.salary " +
                        "FROM users u JOIN admin a ON u.user_id = a.user_id";
                break;
            case "guard":
                query = "SELECT u.user_id, u.username, u.name, u.phone_num, u.email, g.shift, g.post_location " +
                        "FROM users u JOIN guard g ON u.user_id = g.user_id";
                break;
            case "resident":
                query = "SELECT u.user_id, u.username, u.name, u.phone_num, u.email, r.unit " +
                        "FROM users u JOIN resident r ON u.user_id = r.user_id";
                break;
            default:
                throw new IllegalArgumentException("Invalid category: " + category);
        }

        // Execute the query
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                UserBean user = new UserBean();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setPhoneNum(rs.getString("phone_num"));
                user.setEmail(rs.getString("email"));

                // Set category-specific fields
                switch (category.toLowerCase()) {
                    case "admin":
                        user.setSalary(rs.getDouble("salary"));
                        break;
                    case "guard":
                        user.setShift(rs.getString("shift"));
                        user.setPostLocation(rs.getString("post_location"));
                        break;
                    case "resident":
                        user.setUnit(rs.getString("unit"));
                        break;
                }

                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Retrieve user details by ID and category
    public static UserBean getUserByIdAndCategory(int userId, String category) {
        UserBean user = null;
        String query = "";

        // Define query based on the category
        switch (category.toLowerCase()) {
            case "admin":
                query = "SELECT u.user_id, u.username, u.name, u.phone_num, u.email, a.salary " +
                        "FROM users u JOIN admin a ON u.user_id = a.user_id WHERE u.user_id = ?";
                break;
            case "guard":
                query = "SELECT u.user_id, u.username, u.name, u.phone_num, u.email, g.shift, g.post_location " +
                        "FROM users u JOIN guard g ON u.user_id = g.user_id WHERE u.user_id = ?";
                break;
            case "resident":
                query = "SELECT u.user_id, u.username, u.name, u.phone_num, u.email, r.unit " +
                        "FROM users u JOIN resident r ON u.user_id = r.user_id WHERE u.user_id = ?";
                break;
            default:
                throw new IllegalArgumentException("Invalid category: " + category);
        }

        // Execute the query
        try (Connection conn = DBConnection.createConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new UserBean();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setName(rs.getString("name"));
                    user.setPhoneNum(rs.getString("phone_num"));
                    user.setEmail(rs.getString("email"));

                    // Set category-specific fields
                    switch (category.toLowerCase()) {
                        case "admin":
                            user.setSalary(rs.getDouble("salary"));
                            break;
                        case "guard":
                            user.setShift(rs.getString("shift"));
                            user.setPostLocation(rs.getString("post_location"));
                            break;
                        case "resident":
                            user.setUnit(rs.getString("unit"));
                            break;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // Update or Delete User
    public static boolean updateOrDeleteUser(int userId, UserBean user, boolean delete, String category) {
        String query;

        if (delete) {
            String deleteCategoryQuery;
            switch (category.toLowerCase()) {
                case "admin":
                    deleteCategoryQuery = "DELETE FROM admin WHERE user_id = ?";
                    break;
                case "guard":
                    deleteCategoryQuery = "DELETE FROM guard WHERE user_id = ?";
                    break;
                case "resident":
                    deleteCategoryQuery = "DELETE FROM resident WHERE user_id = ?";
                    break;
                default:
                    throw new IllegalArgumentException("Invalid category: " + category);
            }

            // Delete user data from `users` table
            query = "DELETE FROM users WHERE user_id = ?";

            try (Connection conn = DBConnection.createConnection();
                 PreparedStatement psCategory = conn.prepareStatement(deleteCategoryQuery);
                 PreparedStatement psUsers = conn.prepareStatement(query)) {

                // Delete from category table first
                psCategory.setInt(1, userId);
                psCategory.executeUpdate();

                // Delete from users table
                psUsers.setInt(1, userId);
                int affectedRows = psUsers.executeUpdate();

                return affectedRows > 0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            // Update user data
            query = "UPDATE users SET username = ?, name = ?, phone_num = ?, email = ? WHERE user_id = ?";

            try (Connection conn = DBConnection.createConnection();
                 PreparedStatement ps = conn.prepareStatement(query)) {

                ps.setString(1, user.getUsername());
                ps.setString(2, user.getName());
                ps.setString(3, user.getPhoneNum());
                ps.setString(4, user.getEmail());
                ps.setInt(5, user.getUserId());

                int affectedRows = ps.executeUpdate();
                return affectedRows > 0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return false;
    }
}

