<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Doctor" %>
<!DOCTYPE html>
<html>
<head>
    <title>Doctors Directory</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded px-3 mb-4">
        <span class="navbar-brand fw-bold text-primary">City Hospital</span>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="patient?action=list">Patients</a></li>
                <li class="nav-item"><a class="nav-link active fw-semibold" href="doctor">Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="appointment">Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="hospital-ops">Departments, Admissions & Billing</a></li>
            </ul>
            <span class="navbar-text me-3 text-light">Staff: <strong><%= session.getAttribute("user") %></strong></span>
            <a href="logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </nav>

    <h3 class="mb-3">Doctors Directory</h3>

    <!-- Quick Add Doctor Form -->
    <form action="doctor" method="post" class="row g-2 card card-body bg-light mb-4">
        <div class="col-md-3">
            <input type="text" name="doctorName" class="form-control" placeholder="Doctor Name (e.g. Dr. Mehta)" required>
        </div>
        <div class="col-md-3">
            <input type="text" name="specialization" class="form-control" placeholder="Specialization" required>
        </div>
        <div class="col-md-2">
            <input type="tel" name="phone" class="form-control" pattern="[0-9]{10}" placeholder="10-digit Phone" required>
        </div>
        <div class="col-md-2">
            <input type="number" name="departmentId" class="form-control" placeholder="Dept ID (1-5)" min="1" max="5" required>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-success w-100">+ Add Doctor</button>
        </div>
    </form>

    <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Doctor Name</th>
                <th>Specialization</th>
                <th>Phone</th>
                <th>Department ID</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Doctor> list = (List<Doctor>) request.getAttribute("doctorList");
                if (list != null && !list.isEmpty()) {
                    for (Doctor d : list) {
            %>
                <tr>
                    <td><%= d.getDoctorId() %></td>
                    <td><strong><%= d.getDoctorName() %></strong></td>
                    <td><span class="badge bg-primary"><%= d.getSpecialization() %></span></td>
                    <td><%= d.getPhone() %></td>
                    <td>Dept #<%= d.getDepartmentId() %></td>
                    <td>
                        <a href="doctor?action=delete&id=<%= d.getDoctorId() %>" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Delete this doctor record?');">Delete</a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr><td colspan="6" class="text-center text-muted py-3">No doctors found in database.</td></tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>