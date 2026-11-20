package model;

import java.sql.Date;

public class Admission {
    private int admissionId;
    private int patientId;
    private String roomNumber;
    private Date admissionDate;
    private Date dischargeDate;

    public Admission() {}

    public Admission(int admissionId, int patientId, String roomNumber, Date admissionDate, Date dischargeDate) {
        this.admissionId = admissionId;
        this.patientId = patientId;
        this.roomNumber = roomNumber;
        this.admissionDate = admissionDate;
        this.dischargeDate = dischargeDate;
    }

    public int getAdmissionId() { return admissionId; }
    public void setAdmissionId(int admissionId) { this.admissionId = admissionId; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public Date getAdmissionDate() { return admissionDate; }
    public void setAdmissionDate(Date admissionDate) { this.admissionDate = admissionDate; }

    public Date getDischargeDate() { return dischargeDate; }
    public void setDischargeDate(Date dischargeDate) { this.dischargeDate = dischargeDate; }
}