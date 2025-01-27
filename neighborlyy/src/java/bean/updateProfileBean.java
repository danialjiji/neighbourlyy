/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author junmee
 */
public class updateProfileBean {
    
    String email;
    String phoneNum;
    int userid;

    public updateProfileBean(String email, String phoneNum, int userid) {
        this.email = email;
        this.phoneNum = phoneNum;
        this.userid = userid;
    }

    public updateProfileBean() {
    }
    
    public String getEmail() {
        return email;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public int getUserid() {
        return userid;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }
    
    
}
