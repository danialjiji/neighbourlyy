/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author USER
 */
public class DBConnection {
    public static Connection createConnection() {
        Connection con = null;
        try {
            // Oracle Database URL
            String url = "jdbc:oracle:thin:@localhost:1521:XE";
            String username = "neighborly";
            String password = "system";
            
            // Register Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // Establish the connection
            con = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            System.out.println("Oracle JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Failed to connect to Oracle Database.");
            e.printStackTrace();
        }
        return con;
    }
}
