/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author Dean Ardley
 */
public class ReportBean2 {
    private String userID;
    private String dateOfVisit;
    private String location;
    private String remarks;
    private String attachment;
    
    public ReportBean2(){
        
    }
    
    public ReportBean2(String userID, String dateOfVisit, String location, String remarks, String attachment){
        this.userID = userID;
        this.dateOfVisit = dateOfVisit;
        this.location = location;
        this.remarks = remarks;
        this.attachment = attachment;
    }
    
    public String getUserID(){
        return this.userID;
    }
    
    public String getDateOfVisit(){
        return this.dateOfVisit;
    }
    
    public String getLocation(){
        return this.location;
    }
    
    public String getRemarks(){
        return this.remarks;
    }
    
    public String getAttachment(){
        return this.attachment;
    }
    
    public void setUserID(String userID){
        this.userID = userID;
    }
    
    public void setDateOfVisit(String dateOfVisit){
        this.dateOfVisit = dateOfVisit;
    }
    
    public void setLocation(String location){
        this.location = location;
    }
    
    public void setRemarks(String remarks){
        this.remarks = remarks;
    }
    
    public void setAttachment(String attachment){
        this.attachment = attachment;
    }
}
