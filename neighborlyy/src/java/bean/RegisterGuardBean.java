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
public class RegisterGuardBean implements Serializable {
    private String name;
    private String email;
    private String icNumber;
    private String phoneNumber;
    private String plateNumber;
    private String username;
    private String password;
    private String shift;
    private String postlocation;
    private Double salary;

    public RegisterGuardBean(){
        
    }
    
    public RegisterGuardBean(String name, String email, String icNumber, String phoneNumber, String plateNumber, String username, String password, String shift, String postlocation, Double salary) {
        this.name = name;
        this.email = email;
        this.icNumber = icNumber;
        this.phoneNumber = phoneNumber;
        this.plateNumber = plateNumber;
        this.username = username;
        this.password = password;
        this.shift = shift;
        this.postlocation = postlocation;
        this.salary = salary;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIcNumber() {
        return icNumber;
    }

    public void setIcNumber(String icNumber) {
        this.icNumber = icNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public void setPlateNumber(String plateNumber) {
        this.plateNumber = plateNumber;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getShift() {
        return shift;
    }

    public void setShift(String shift) {
        this.shift = shift;
    }

    public String getPostlocation() {
        return postlocation;
    }

    public void setPostlocation(String postlocation) {
        this.postlocation = postlocation;
    }

    public Double getSalary() {
        return salary;
    }

    public void setSalary(Double salary) {
        this.salary = salary;
    }
    
}
