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
public class FeeBean2 {
    
    private String userID;
    private String feeCategoryID;
    private String statusID;
    private String feeDate;
    private int feeAmount;
    
   
    
    public FeeBean2(){
        
    }
    
    public FeeBean2(String userID, String feeCategoryID, String statusID, String feeDate, int feeAmount){
        this.userID = userID;
        this.feeCategoryID = feeCategoryID;
        this.statusID = statusID;
        this.feeDate = feeDate;
        this.feeAmount = feeAmount;     
    }
    
    public String getUserID(){
        return this.userID;
    }
    
    public String getFeeCategoryID(){
        return this.feeCategoryID;
    }
    
    public String getStatusID(){
        return this.statusID;
    }
    
    public String getFeeDate(){
        return this.feeDate;
    }
    
    public int getFeeAmount(){
        return this.feeAmount;
    }       
    
    public void setUserID(String userID){
        this.userID = userID;
    }
    
    public void setFeeCategoryID(String feeCategoryID){
        this.feeCategoryID = feeCategoryID;
    }
    
    public void setStatusID(String statusID){
        this.statusID = statusID;
    }
    
    public void setFeeDate(String feeDate){
        this.feeDate = feeDate;
    }
    
    public void setFeeAmount(int feeAmount){
        this.feeAmount = feeAmount;
    }
       
    
}
