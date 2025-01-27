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
public class ComplaintBean2 {
    private String userID;
    private String statusID;
    private String complaint_type_ID;
    private String complaint_description;
    private String complaint_date;  
    private String complaint_location;
    private String complaint_attachment;
    
    public ComplaintBean2(){
        
    }
    
    public ComplaintBean2(String userID, String statusID, String complaint_type_ID, String complaint_description, String complaint_date, String complaint_location, String complaint_attachment){
        this.userID = userID;
        this.statusID = statusID;
        this.complaint_type_ID = complaint_type_ID;
        this.complaint_description = complaint_description;
        this.complaint_date = complaint_date;       
        this.complaint_location = complaint_location;
        this.complaint_attachment = complaint_attachment;
    }
    
    public String getUserID(){
        return this.userID;
    }
    
    public String getStatusID(){
        return this.statusID;
    }
    
    public String getComplaintTypeID(){
        return this.complaint_type_ID;
    }
    
    public String getComplaintDescription(){
        return this.complaint_description;
    }
    
    public String getComplaintDate(){
        return this.complaint_date;
    }   
    
    public String getComplaintLocation(){
        return this.complaint_location;
    }
    
    public String getComplaintAttachment(){
        return this.complaint_attachment;
    }
    
    public void setUserID(String userID){
        this.userID = userID;
    }
    
    public void setStatusID(String statusID){
        this.statusID = statusID;
    }
    
    public void setComplaintTypeID(String complaintTypeID){
        this.complaint_type_ID = complaint_type_ID;
    }
    
    public void setComplaintDescription(String complaintDescription){
        this.complaint_description = complaint_description;
    }
    
    public void setComplaintDate(String complaint_date){
        this.complaint_date = complaint_date;
    }   
    
    public void setComplaintLocation(String complaint_location){
        this.complaint_location = complaint_location;
    }
    
    public void setComplaintAttachment(String complaint_attachment){
        this.complaint_attachment = complaint_attachment;
    }
       
}
