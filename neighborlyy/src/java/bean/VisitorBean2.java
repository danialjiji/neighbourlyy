/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.Serializable;

/**
 *
 * @author Dean Ardley
 */
public class VisitorBean2 implements Serializable{
    private String userID;
    private String visitor_name;
    private String visitor_ic;
    private String no_plate;
    private String entryTime;
    private String exitTime;
    private String dateOfVisit;
    private String purposeOfVisit;
    private String visitor_phonenum;
    
    public VisitorBean2(){
        
    }
    
    public VisitorBean2(String userID, String visitor_name, String visitor_ic, String no_plate, String entryTime, String exitTime, String dateOfVisit, String purposeOfVisit, String visitor_phonenum){
        this.userID = userID;
        this.visitor_name = visitor_name;
        this.visitor_ic = visitor_ic;
        this.no_plate = no_plate;
        this.entryTime = entryTime;
        this.exitTime = exitTime;
        this.dateOfVisit = dateOfVisit;
        this.purposeOfVisit = purposeOfVisit;
        this.visitor_phonenum = visitor_phonenum;
    }
    
    public void setUserID(String userID){
        this.userID = userID;
    }
    
    public void setVisitorName(String visitor_name){
        this.visitor_name = visitor_name;
    }
    
    public void setVisitorIC(String visitor_ic){
        this.visitor_ic = visitor_ic;
    }
    
    public void setNoPlate(String no_plate){
        this.no_plate = no_plate;
    }
    
    public void setEntryTime(String entryTime){
        this.entryTime = entryTime;
    }
    
    public void setExitTime(String exitTime){
        this.exitTime = exitTime;
    }
    
    public void setDateOfVisit(String dateOfVisit){
        this.dateOfVisit = dateOfVisit;
    }
    
    public void setPurposeOfVisit(String purposeOfVisit){
        this.purposeOfVisit = purposeOfVisit;
    }
    
    public void setVisitorPhoneNum(String visitor_phonenum){
        this.visitor_phonenum = visitor_phonenum;
    }
    
    public String getUserID(){
        return this.userID;
    }
    
    public String getVisitorName(){
        return this.visitor_name;
    }
    
    public String getVisitorIC(){
        return this.visitor_ic;
    }
    
    public String getNoPlate(){
        return this.no_plate;
    }
    
    public String getEntryTime(){
        return this.entryTime;
    }
    
    public String getExitTime(){
        return this.exitTime;
    }
    
    public String getDateOfVisit(){
        return this.dateOfVisit;
    } 
    
    public String getPurposeOfVisit(){
        return this.purposeOfVisit;
    }
    
    public String getVisitorPhoneNum(){
        return this.visitor_phonenum;
    }
    
    
    
}
