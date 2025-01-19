/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;
import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;

/**
 *
 * @author junmee
 */
public class FeeBean implements Serializable {
    
    int feeType;
    double amount;
    Date dateFee;
    String receipt;

    public FeeBean (int feeType, double amount, Date dateFee, String receipt) {
        this.feeType = feeType;
        this.amount = amount;
        this.dateFee = dateFee;
        this.receipt = receipt;
    }

    public FeeBean() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public int getFeeType() {
        return feeType;
    }

    public double getAmount() {
        return amount;
    }

    public Date getDateFee() {
        return dateFee;
    }

    public String getReceipt() {
        return receipt;
    }

    public void setFeeType(int feeType) {
        this.feeType = feeType;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setDateFee(Date dateFee) {
        this.dateFee = dateFee;
    }

    public void setReceipt(String receipt) {
        this.receipt = receipt;
    }

    
    
    
    
    
}
