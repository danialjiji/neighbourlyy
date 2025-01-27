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
    String remark;
    double payFee;

    public FeeBean (int feeType, double amount, Date dateFee, String receipt, String remark, double payFee) {
        this.feeType = feeType;
        this.amount = amount;
        this.dateFee = dateFee;
        this.receipt = receipt;
        this.remark = remark;
        this.payFee = payFee;
    }

    public FeeBean() {
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

    public String getRemark() {
        return remark;
    }

    public double getPayFee() {
        return payFee;
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

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setPayFee(double payFee) {
        this.payFee = payFee;
    }

    
    
}
