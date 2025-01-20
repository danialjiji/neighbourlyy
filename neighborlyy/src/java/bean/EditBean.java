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

public class EditBean implements Serializable {  
    private int userID;  
    private String username;  
    private String name;  
    private String icPassport;  
    private String phoneNum;  
    private String email; 
    private String plateNumber;
    private double salary;  
    private String shift;
    private String postlocation;
    private String unit;  

    public EditBean(){
        
    }

    public EditBean(int userID, String username, String name, String icPassport, String phoneNum, String email, String plateNumber, double salary, String shift, String postlocation, String unit) {
        this.userID = userID;
        this.username = username;
        this.name = name;
        this.icPassport = icPassport;
        this.phoneNum = phoneNum;
        this.email = email;
        this.plateNumber = plateNumber;
        this.salary = salary;
        this.shift = shift;
        this.postlocation = postlocation;
        this.unit = unit;
    }
   
    
    // Getters and Setters  
    public int getUserID() { return userID; }  
    public void setUserID(int userID) { this.userID = userID; }  
    
    public String getUsername() { return username; }  
    public void setUsername(String username) { this.username = username; }  

    public String getName() { return name; }  
    public void setName(String name) { this.name = name; }  

    public String getIcPassport() { return icPassport; }  
    public void setIcPassport(String icPassport) { this.icPassport = icPassport; }  

    public String getPhoneNum() { return phoneNum; }  
    public void setPhoneNum(String phoneNum) { this.phoneNum = phoneNum; }  

    public String getEmail() { return email; }  
    public void setEmail(String email) { this.email = email; }  

    public double getSalary() { return salary; }  
    public void setSalary(double salary) { this.salary = salary; }  

    public String getShift() { return shift; }  
    public void setShift(String shift) { this.shift = shift; }  

    public String getUnit() { return unit; }  
    public void setUnit(String unit) { this.unit = unit; } 

    public String getPostlocation() {
        return postlocation;
    }

    public void setPostlocation(String postlocation) {
        this.postlocation = postlocation;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }
    
    
    
}
