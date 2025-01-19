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
public class UserBean  implements Serializable{  
    private int userID;  
    private String username;  
    private String name;  
    private String ic_passport;  
    private String phoneNum;  
    private String email;  
    private String plate_id;  
    private String userType; // New field to store user type  
    private String salary; // Specific field for admin  
    private String shift; // Specific field for guard  
    private String postLocation; // Specific field for guard 
    private String unitHouse; // Specific field for resident  

    
     public UserBean(){
         
     }

    public UserBean(int userID, String username, String name, String ic_passport, String phoneNum, String email, String plate_id, String userType, String salary, String shift, String postLocation, String unitHouse) {
        this.userID = userID;
        this.username = username;
        this.name = name;
        this.ic_passport = ic_passport;
        this.phoneNum = phoneNum;
        this.email = email;
        this.plate_id = plate_id;
        this.userType = userType;
        this.salary = salary;
        this.shift = shift;
        this.postLocation = postLocation;
        this.unitHouse = unitHouse;
    }
    
    // Getters and Setters for all fields  
    public int getUserID() {  
        return userID;  
    }  
    public void setUserID(int userID) {  
        this.userID = userID;  
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
    public String getIc_passport() {  
        return ic_passport;  
    }  
    public void setIc_passport(String ic_passport) {  
        this.ic_passport = ic_passport;  
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
    public String getPlate_id() {  
        return plate_id;  
    }  
    public void setPlate_id(String plate_id) {  
        this.plate_id = plate_id;  
    }  
    public String getUserType() {  
        return userType;  
    }  
    public void setUserType(String userType) {  
        this.userType = userType;  
    }  

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
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

    public String getUnitHouse() {
        return unitHouse;
    }

    public void setUnitHouse(String unitHouse) {
        this.unitHouse = unitHouse;
    }
    
}
