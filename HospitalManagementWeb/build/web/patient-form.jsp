<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Patient" %>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Form</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-4" style="max-width: 650px;">
    <%
        Patient patient = (Patient) request.getAttribute("patient");
        String error = (String) request.getAttribute("error");
    %>

    <h3 class="mb-3"><%= patient != null ? "Update Patient" : "New Patient Registration" %></h3>

    <% if (error != null) { %>
        <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <form action="patient" method="post" class="card p-4 shadow-sm">
        <input type="hidden" name="id" value="<%= patient != null ? patient.getPatientId() : "" %>">

        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" value="<%= patient != null ? patient.getName() : "" %>" required minlength="2">
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Age</label>
                <input type="number" name="age" class="form-control" value="<%= patient != null ? patient.getAge() : "" %>" required min="1" max="120">
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Gender</label>
                <select name="gender" class="form-select">
                    <option value="Male" <%= (patient != null && "Male".equalsIgnoreCase(patient.getGender())) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= (patient != null && "Female".equalsIgnoreCase(patient.getGender())) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= (patient != null && "Other".equalsIgnoreCase(patient.getGender())) ? "selected" : "" %>>Other</option>
                </select>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="tel" name="phone" class="form-control" value="<%= patient != null ? patient.getPhone() : "" %>" pattern="[0-9]{10}" placeholder="10-digit mobile number" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Address</label>
            <textarea name="address" class="form-control" rows="2"><%= patient != null ? patient.getAddress() : "" %></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Disease / Diagnosis</label>
            <input type="text" name="disease" class="form-control" value="<%= patient != null ? patient.getDisease() : "" %>">
        </div>

        <div class="d-flex justify-content-between">
            <a href="patient?action=list" class="btn btn-secondary">Back</a>
            <button type="submit" class="btn btn-primary"><%= patient != null ? "Update Record" : "Save Record" %></button>
        </div>
    </form>
</body>
</html>