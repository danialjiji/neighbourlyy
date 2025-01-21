package bean;

public class VisitorBean {
    String visitorname;
    String icpassport;
    String plateno;
    String entrytime;
    String exittime;
    String datevisit;
    String purposevisit;
    String phoneno;
    
    public VisitorBean(){}

    public VisitorBean(String visitorname, String icpassport, String plateno, String entrytime, String exittime, String datevisit, String purposevisit, String phoneno) {
        this.visitorname = visitorname;
        this.icpassport = icpassport;
        this.plateno = plateno;
        this.entrytime = entrytime;
        this.exittime = exittime;
        this.datevisit = datevisit;
        this.purposevisit = purposevisit;
        this.phoneno = phoneno;
    }

    public String getVisitorname() {
        return visitorname;
    }

    public void setVisitorname(String visitorname) {
        this.visitorname = visitorname;
    }

    public String getIcpassport() {
        return icpassport;
    }

    public void setIcpassport(String icpassport) {
        this.icpassport = icpassport;
    }

    public String getPlateno() {
        return plateno;
    }

    public void setPlateno(String plateno) {
        this.plateno = plateno;
    }

    public String getEntrytime() {
        return entrytime;
    }

    public void setEntrytime(String entrytime) {
        this.entrytime = entrytime;
    }

    public String getExittime() {
        return exittime;
    }

    public void setExittime(String exittime) {
        this.exittime = exittime;
    }

    public String getDatevisit() {
        return datevisit;
    }

    public void setDatevisit(String datevisit) {
        this.datevisit = datevisit;
    }

    public String getPurposevisit() {
        return purposevisit;
    }

    public void setPurposevisit(String purposevisit) {
        this.purposevisit = purposevisit;
    }

    public String getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(String phoneno) {
        this.phoneno = phoneno;
    }
    
    
}
