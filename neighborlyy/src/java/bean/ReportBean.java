package bean;

public class ReportBean {
    String dateofvisit;
    String location;
    String remarks;
    String attachment;
    int userid;

    public ReportBean(String dateofvisit, String location, String remarks, String attachment, int userid) {
        this.dateofvisit = dateofvisit;
        this.location = location;
        this.remarks = remarks;
        this.attachment = attachment;
        this.userid = userid;
    }

    public ReportBean() {
    }

    public String getDateofvisit() {
        return dateofvisit;
    }

    public void setDateofvisit(String dateofvisit) {
        this.dateofvisit = dateofvisit;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }
    
    
}
