package model;

import java.sql.Date;

public class Billing {
    private int billId;
    private int patientId;
    private double amount;
    private String paymentStatus;
    private Date billDate;

    public Billing() {}

    public Billing(int billId, int patientId, double amount, String paymentStatus, Date billDate) {
        this.billId = billId;
        this.patientId = patientId;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
        this.billDate = billDate;
    }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }
}