package dao;

import connection.DBConnection;
import model.Admission;
import model.Billing;
import model.Department;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HospitalExtraDAO {

    // --- DEPARTMENTS ---
    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT * FROM departments";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Department(
                    rs.getInt("department_id"),
                    rs.getString("department_name"),
                    rs.getString("location")
                ));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addDepartment(String name, String location) {
        String sql = "INSERT INTO departments (department_name, location) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, location);
            return ps.executeUpdate() > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- ADMISSIONS ---
    public List<Admission> getAllAdmissions() {
        List<Admission> list = new ArrayList<>();
        String sql = "SELECT * FROM admissions ORDER BY admission_id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Admission(
                    rs.getInt("admission_id"),
                    rs.getInt("patient_id"),
                    rs.getString("room_number"),
                    rs.getDate("admission_date"),
                    rs.getDate("discharge_date")
                ));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addAdmission(int patientId, String room, Date admDate) {
        String sql = "INSERT INTO admissions (patient_id, room_number, admission_date) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            ps.setString(2, room);
            ps.setDate(3, admDate);
            return ps.executeUpdate() > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean dischargePatient(int admissionId) {
        String sql = "UPDATE admissions SET discharge_date = CURDATE() WHERE admission_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, admissionId);
            return ps.executeUpdate() > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // --- BILLING ---
    public List<Billing> getAllBills() {
        List<Billing> list = new ArrayList<>();
        String sql = "SELECT * FROM billing ORDER BY bill_id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Billing(
                    rs.getInt("bill_id"),
                    rs.getInt("patient_id"),
                    rs.getDouble("amount"),
                    rs.getString("payment_status"),
                    rs.getDate("bill_date")
                ));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addBill(int patientId, double amount, String status, Date billDate) {
        String sql = "INSERT INTO billing (patient_id, amount, payment_status, bill_date) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            ps.setDouble(2, amount);
            ps.setString(3, status);
            ps.setDate(4, billDate);
            return ps.executeUpdate() > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean markBillPaid(int billId) {
        String sql = "UPDATE billing SET payment_status = 'Paid' WHERE bill_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, billId);
            return ps.executeUpdate() > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}