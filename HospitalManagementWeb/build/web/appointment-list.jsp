<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Appointment" %>
<%@ page import="model.Patient" %>
<%@ page import="model.Doctor" %>
<!DOCTYPE html>
<html>
<head>
    <title>Appointments Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded px-3 mb-4">
        <span class="navbar-brand fw-bold text-primary">City Hospital</span>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="patient?action=list">Patients</a></li>
                <li class="nav-item"><a class="nav-link" href="doctor">Doctors</a></li>
                <li class="nav-item"><a class="nav-link active fw-semibold" href="appointment">Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="hospital-ops">Departments, Admissions & Billing</a></li>
            </ul>
            <span class="navbar-text me-3 text-light">Staff: <strong><%= session.getAttribute("user") %></strong></span>
            <a href="logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </nav>

    <h3 class="mb-3">Book & Manage Appointments</h3>

    <!-- Book New Appointment Form -->
    <form action="appointment" method="post" class="row g-2 card card-body bg-light mb-4">
        <div class="col-md-3">
            <select name="patientId" class="form-select" required>
                <option value="">-- Select Patient --</option>
                <%
                    List<Patient> patients = (List<Patient>) request.getAttribute("patientList");
                    if (patients != null) {
                        for (Patient p : patients) {
                %>
                    <option value="<%= p.getPatientId() %>">#<%= p.getPatientId() %> - <%= p.getName() %></option>
                <%      }
                    } %>
            </select>
        </div>
        <div class="col-md-3">
            <select name="doctorId" class="form-select" required>
                <option value="">-- Select Doctor --</option>
                <%
                    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctorList");
                    if (doctors != null) {
                        for (Doctor d : doctors) {
                %>
                    <option value="<%= d.getDoctorId() %>"><%= d.getDoctorName() %> (<%= d.getSpecialization() %>)</option>
                <%      }
                    } %>
            </select>
        </div>
        <div class="col-md-2">
            <input type="date" name="appointmentDate" class="form-control" required>
        </div>
        <div class="col-md-2">
            <input type="time" name="appointmentTime" class="form-control" required>
        </div>
        <div class="col-md-2">
            <input type="hidden" name="status" value="Pending">
            <button type="submit" class="btn btn-success w-100">Book Slot</button>
        </div>
    </form>

    <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
            <tr>
                <th>Appt ID</th>
                <th>Patient ID</th>
                <th>Doctor ID</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Appointment> appts = (List<Appointment>) request.getAttribute("appointmentList");
                if (appts != null && !appts.isEmpty()) {
                    for (Appointment a : appts) {
            %>
                <tr>
                    <td>#<%= a.getAppointmentId() %></td>
                    <td>Patient #<%= a.getPatientId() %></td>
                    <td>Doctor #<%= a.getDoctorId() %></td>
                    <td><%= a.getAppointmentDate() %></td>
                    <td><%= a.getAppointmentTime() %></td>
                    <td>
                        <span class="badge <%= "Confirmed".equalsIgnoreCase(a.getStatus()) ? "bg-success" : "bg-warning text-dark" %>">
                            <%= a.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <% if (!"Confirmed".equalsIgnoreCase(a.getStatus())) { %>
                            <a href="appointment?action=confirm&id=<%= a.getAppointmentId() %>" class="btn btn-success btn-sm">Confirm</a>
                        <% } %>
                        <a href="appointment?action=delete&id=<%= a.getAppointmentId() %>" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Cancel this appointment?');">Cancel</a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="7" class="text-center text-muted py-3">No appointments scheduled.</td></tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>