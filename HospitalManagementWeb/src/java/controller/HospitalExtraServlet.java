package controller;

import dao.HospitalExtraDAO;
import dao.PatientDAO;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/hospital-ops")
public class HospitalExtraServlet extends HttpServlet {
    private HospitalExtraDAO extraDAO;
    private PatientDAO patientDAO;

    @Override
    public void init() {
        extraDAO = new HospitalExtraDAO();
        patientDAO = new PatientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("discharge".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            extraDAO.dischargePatient(id);
            response.sendRedirect("hospital-ops");
            return;
        } else if ("pay".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            extraDAO.markBillPaid(id);
            response.sendRedirect("hospital-ops");
            return;
        }

        request.setAttribute("departmentList", extraDAO.getAllDepartments());
        request.setAttribute("admissionList", extraDAO.getAllAdmissions());
        request.setAttribute("billingList", extraDAO.getAllBills());
        request.setAttribute("patientList", patientDAO.getAllPatients());
        request.getRequestDispatcher("hospital-operations.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String formType = request.getParameter("formType");

        if ("department".equals(formType)) {
            String name = request.getParameter("departmentName");
            String location = request.getParameter("location");
            extraDAO.addDepartment(name, location);
        } else if ("admission".equals(formType)) {
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            String room = request.getParameter("roomNumber");
            Date admDate = Date.valueOf(request.getParameter("admissionDate"));
            extraDAO.addAdmission(patientId, room, admDate);
        } else if ("billing".equals(formType)) {
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String status = request.getParameter("paymentStatus");
            Date billDate = Date.valueOf(request.getParameter("billDate"));
            extraDAO.addBill(patientId, amount, status, billDate);
        }

        response.sendRedirect("hospital-ops");
    }
}