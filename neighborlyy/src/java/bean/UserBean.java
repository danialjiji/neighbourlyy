/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;
import java.io.Serializable;
/**
 *
 * @author USER
 */
public class UserBean implements Serializable {
    private int userId;
    private String username;
    private String name;
    private String phoneNum;
    private String email;

    // Admin-specific fields
    private double salary;

    // Guard-specific fields
    private String shift;
    private String postLocation;

    // Resident-specific fields
    private String unit;

    //Constructor
    public UserBean(){
        
    }
    
    public UserBean(int userId, String username, String name, String phoneNum, String email, double salary, String shift, String postLocation, String unit) {
        this.userId = userId;
        this.username = username;
        this.name = name;
        this.phoneNum = phoneNum;
        this.email = email;
        this.salary = salary;
        this.shift = shift;
        this.postLocation = postLocation;
        this.unit = unit;
    }

    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public String getShift() {
        return shift;
    }

    public void setShift(String shift) {
        this.shift = shift;
    }

    public String getPostLocation() {
        return postLocation;
    }

    public void setPostLocation(String postLocation) {
        this.postLocation = postLocation;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }
}
