<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Departments, Admissions & Billing</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded px-3 mb-4">
        <span class="navbar-brand fw-bold text-primary">City Hospital</span>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="patient?action=list">Patients</a></li>
                <li class="nav-item"><a class="nav-link" href="doctor">Doctors</a></li>
                <li class="nav-item"><a class="nav-link" href="appointment">Appointments</a></li>
                <li class="nav-item"><a class="nav-link active fw-semibold" href="hospital-ops">Departments, Admissions & Billing</a></li>
            </ul>
            <span class="navbar-text me-3 text-light">Staff: <strong><%= session.getAttribute("user") %></strong></span>
            <a href="logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </nav>

    <%
        List<Patient> patients = (List<Patient>) request.getAttribute("patientList");
        List<Department> depts = (List<Department>) request.getAttribute("departmentList");
        List<Admission> adms = (List<Admission>) request.getAttribute("admissionList");
        List<Billing> bills = (List<Billing>) request.getAttribute("billingList");
    %>

    <!-- 1. ADMISSIONS SECTION -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-primary text-white fw-bold">Ward Admissions Management</div>
        <div class="card-body">
            <form action="hospital-ops" method="post" class="row g-2 mb-3">
                <input type="hidden" name="formType" value="admission">
                <div class="col-md-4">
                    <select name="patientId" class="form-select" required>
                        <option value="">-- Select Patient --</option>
                        <% if (patients != null) for (Patient p : patients) { %>
                            <option value="<%= p.getPatientId() %>">#<%= p.getPatientId() %> - <%= p.getName() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="text" name="roomNumber" class="form-control" placeholder="Room (e.g. A101)" required>
                </div>
                <div class="col-md-3">
                    <input type="date" name="admissionDate" class="form-control" required>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-success w-100">Admit Patient</button>
                </div>
            </form>

            <table class="table table-bordered table-sm align-middle mb-0">
                <thead class="table-light">
                    <tr><th>ID</th><th>Patient ID</th><th>Room</th><th>Admission Date</th><th>Discharge Date</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <% if (adms != null) for (Admission a : adms) { %>
                        <tr>
                            <td>#<%= a.getAdmissionId() %></td>
                            <td>Patient #<%= a.getPatientId() %></td>
                            <td><span class="badge bg-secondary"><%= a.getRoomNumber() %></span></td>
                            <td><%= a.getAdmissionDate() %></td>
                            <td><%= a.getDischargeDate() != null ? a.getDischargeDate() : "Admitted" %></td>
                            <td>
                                <% if (a.getDischargeDate() == null) { %>
                                    <a href="hospital-ops?action=discharge&id=<%= a.getAdmissionId() %>" class="btn btn-warning btn-sm">Discharge Today</a>
                                <% } else { %>
                                    <span class="text-success fw-semibold">Discharged</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 2. BILLING SECTION -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-success text-white fw-bold">Patient Billing & Invoices</div>
        <div class="card-body">
            <form action="hospital-ops" method="post" class="row g-2 mb-3">
                <input type="hidden" name="formType" value="billing">
                <div class="col-md-3">
                    <select name="patientId" class="form-select" required>
                        <option value="">-- Select Patient --</option>
                        <% if (patients != null) for (Patient p : patients) { %>
                            <option value="<%= p.getPatientId() %>">#<%= p.getPatientId() %> - <%= p.getName() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="number" step="0.01" name="amount" class="form-control" placeholder="Amount (INR)" required>
                </div>
                <div class="col-md-2">
                    <select name="paymentStatus" class="form-select">
                        <option value="Pending">Pending</option>
                        <option value="Paid">Paid</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="date" name="billDate" class="form-control" required>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">Generate Bill</button>
                </div>
            </form>

            <table class="table table-bordered table-sm align-middle mb-0">
                <thead class="table-light">
                    <tr><th>Bill ID</th><th>Patient ID</th><th>Amount</th><th>Status</th><th>Bill Date</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <% if (bills != null) for (Billing b : bills) { %>
                        <tr>
                            <td>#<%= b.getBillId() %></td>
                            <td>Patient #<%= b.getPatientId() %></td>
                            <td>₹ <%= b.getAmount() %></td>
                            <td>
                                <span class="badge <%= "Paid".equalsIgnoreCase(b.getPaymentStatus()) ? "bg-success" : "bg-danger" %>">
                                    <%= b.getPaymentStatus() %>
                                </span>
                            </td>
                            <td><%= b.getBillDate() %></td>
                            <td>
                                <% if (!"Paid".equalsIgnoreCase(b.getPaymentStatus())) { %>
                                    <a href="hospital-ops?action=pay&id=<%= b.getBillId() %>" class="btn btn-success btn-sm">Mark Paid</a>
                                <% } else { %>
                                    <span class="text-muted">Settled</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 3. DEPARTMENTS SECTION -->
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white fw-bold">Hospital Departments</div>
        <div class="card-body">
            <form action="hospital-ops" method="post" class="row g-2 mb-3">
                <input type="hidden" name="formType" value="department">
                <div class="col-md-5">
                    <input type="text" name="departmentName" class="form-control" placeholder="Department Name (e.g. Oncology)" required>
                </div>
                <div class="col-md-5">
                    <input type="text" name="location" class="form-control" placeholder="Location (e.g. Block F)" required>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-dark w-100">+ Add Dept</button>
                </div>
            </form>

            <table class="table table-bordered table-sm align-middle mb-0">
                <thead class="table-light">
                    <tr><th>Dept ID</th><th>Department Name</th><th>Location</th></tr>
                </thead>
                <tbody>
                    <% if (depts != null) for (Department d : depts) { %>
                        <tr>
                            <td><%= d.getDepartmentId() %></td>
                            <td><strong><%= d.getDepartmentName() %></strong></td>
                            <td><%= d.getLocation() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>