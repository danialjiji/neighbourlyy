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

    public updateProfileBean(String email, String phoneNum) {
        this.email = email;
        this.phoneNum = phoneNum;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }
    
    
}
