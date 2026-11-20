<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patients Record</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4">

    <!-- Top Hospital Management Modules Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark rounded px-3 mb-4">
        <span class="navbar-brand fw-bold text-primary">City Hospital</span>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold" href="patient?action=list">Patients</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="doctor">Doctors</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="appointment">Appointments</a>
                </li>
                <li class="nav-item"><a class="nav-link" href="hospital-ops">Departments, Admissions & Billing</a></li>
            </ul>
            <span class="navbar-text me-3 text-light">
                Staff: <strong><%= session.getAttribute("user") %></strong>
            </span>
            <a href="logout" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </nav>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h2 class="mb-0">Hospital Patients Directory</h2>
            <small class="text-muted">Staff: <strong><%= session.getAttribute("user") %></strong></small>
        </div>
        <div>
            <button onclick="window.print()" class="btn btn-outline-secondary me-2">Print Directory</button>
            <a href="patient?action=new" class="btn btn-success me-2">+ Add Patient</a>
            <a href="logout" class="btn btn-outline-danger">Logout</a>
        </div>
    </div>

    <!-- Search Bar -->
    <form action="patient" method="get" class="row g-2 mb-4">
        <input type="hidden" name="action" value="search">
        <div class="col-md-9">
            <input type="text" name="keyword" class="form-control" 
                   placeholder="Search by name, phone number, or disease..." 
                   value="<%= request.getAttribute("searchKeyword") != null ? request.getAttribute("searchKeyword") : "" %>">
        </div>
        <div class="col-md-3 d-flex gap-2">
            <button type="submit" class="btn btn-primary w-100">Search</button>
            <a href="patient?action=list" class="btn btn-secondary">Reset</a>
        </div>
    </form>

    <table class="table table-bordered table-hover align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Disease</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Patient> list = (List<Patient>) request.getAttribute("patientList");
                if (list != null && !list.isEmpty()) {
                    for (Patient p : list) {
            %>
                <tr>
                    <td><%= p.getPatientId() %></td>
                    <td><%= p.getName() %></td>
                    <td><%= p.getAge() %></td>
                    <td><%= p.getGender() %></td>
                    <td><%= p.getPhone() %></td>
                    <td><%= p.getAddress() %></td>
                    <td><span class="badge bg-info text-dark"><%= p.getDisease() %></span></td>
                    <td>
                        <a href="patient?action=report&id=<%= p.getPatientId() %>" class="btn btn-outline-primary btn-sm">Report</a>
                        <a href="patient?action=edit&id=<%= p.getPatientId() %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="patient?action=delete&id=<%= p.getPatientId() %>" 
                           class="btn btn-danger btn-sm" 
                           onclick="return confirm('Kya aap is record ko delete karna chahte hain?');">Delete</a>
                    </td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="8" class="text-center text-muted py-4">Koi matching record nahi mila.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>