package controller;

import dao.PatientDAO;
import model.Patient;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/patient")
public class PatientServlet extends HttpServlet {
    private PatientDAO dao;

    @Override
    public void init() {
        dao = new PatientDAO();
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
        if (action == null) action = "list";

        switch (action) {
            case "new":
                request.getRequestDispatcher("patient-form.jsp").forward(request, response);
                break;
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Patient existing = dao.getPatientById(editId);
                request.setAttribute("patient", existing);
                request.getRequestDispatcher("patient-form.jsp").forward(request, response);
                break;
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                dao.deletePatient(deleteId);
                response.sendRedirect("patient?action=list");
                break;
            case "search":
                String keyword = request.getParameter("keyword");
                List<Patient> results = (keyword != null && !keyword.trim().isEmpty()) 
                        ? dao.searchPatients(keyword.trim()) 
                        : dao.getAllPatients();
                request.setAttribute("patientList", results);
                request.setAttribute("searchKeyword", keyword);
                request.getRequestDispatcher("patient-list.jsp").forward(request, response);
                break;
            case "report":
                int repId = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("patient", dao.getPatientById(repId));
                request.getRequestDispatcher("patient-report.jsp").forward(request, response);
                break;
            case "list":
            default:
                request.setAttribute("patientList", dao.getAllPatients());
                request.getRequestDispatcher("patient-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String disease = request.getParameter("disease");

        if (name == null || name.trim().isEmpty() || phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Name and Phone are mandatory!");
            request.getRequestDispatcher("patient-form.jsp").forward(request, response);
            return;
        }

        int age;
        try {
            age = Integer.parseInt(ageStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Age must be numeric!");
            request.getRequestDispatcher("patient-form.jsp").forward(request, response);
            return;
        }

        if (idStr == null || idStr.trim().isEmpty()) {
            dao.addPatient(new Patient(name, age, gender, phone, address, disease));
        } else {
            int id = Integer.parseInt(idStr);
            dao.updatePatient(new Patient(id, name, age, gender, phone, address, disease));
        }

        response.sendRedirect("patient?action=list");
    }
}