/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;
import java.io.Serializable;
import java.time.LocalDate;
import java.sql.Date;

public class ComplaintBean implements Serializable {
    
    int complaintType;
    String description;
    Date dateComplaint;
    String location;
    String attachment;

    public ComplaintBean(int complaintType, String description, Date date, String location, String attachment) {
        this.complaintType = complaintType;
        this.description = description;
        this.dateComplaint = dateComplaint;
        this.location = location;
        this.attachment = attachment;
    }

    public ComplaintBean() {

    }

    public int getComplaintType() {
        return complaintType;
    }

    public String getDescription() {
        return description;
    }

    public Date getDateComplaint() {
        return dateComplaint;
    }

    public String getLocation() {
        return location;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setComplaintType(int complaintType) {
        this.complaintType = complaintType;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDateComplaint(Date date) {
        this.dateComplaint = dateComplaint;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }
    
    
   
    
}