# 🏥 Hospital Management System (AJT Project)

A full-stack Java Web Application built using **Java Servlets, JSP, JDBC, MySQL, and Bootstrap 5**, following the **Model-View-Controller (MVC)** and **Data Access Object (DAO)** architectural patterns. Developed as part of the **Advance Java Technology (01CE0308)** coursework at **Marwadi University**.

---

## 📋 Table of Contents
- [Project Overview](#-project-overview)
- [Key Features & Modules](#-key-features--modules)
- [Tech Stack & Architecture](#-tech-stack--architecture)
- [Database Schema](#-database-schema)
- [Project Directory Structure](#-project-directory-structure)
- [Setup & Installation Guide](#-setup--installation-guide)
- [Default Login Credentials](#-default-login-credentials)
- [Team Members](#-team-members)

---

## 🔍 Project Overview
The **Hospital Management System** digitizes and streamlines core hospital administrative workflows. It replaces manual record-keeping with a centralized, session-protected web dashboard that manages patient registrations, doctor directories, appointment scheduling, ward admissions, department allocations, and patient billing.

---

## ✨ Key Features & Modules

1. **Authentication & Session Management (`LoginServlet`, `LogoutServlet`)**
   - Role-based staff login backed by `HttpSession`.
   - Unauthorized access prevention: unauthenticated requests to any servlet or JSP route automatically redirect to `login.jsp`.
   - Clean session invalidation on logout.

2. **Patients Management (`PatientServlet`, `PatientDAO`)**
   - Full **CRUD** operations (Register, View, Update, Delete).
   - Real-time multi-parameter search filter (by Name, Phone Number, or Diagnosis).
   - Client-side (HTML5 pattern/range) and Server-side input validation.
   - Print-ready individual **Patient Medical Slip** (`patient-report.jsp`) and full directory print support.

3. **Doctors Directory (`DoctorServlet`, `DoctorDAO`)**
   - Manage specialist doctor profiles, contact numbers, and department mappings.
   - Quick-add and delete functionality integrated with the MySQL `doctors` table.

4. **Appointments Scheduling (`AppointmentServlet`, `AppointmentDAO`)**
   - Interactive appointment booking linking registered patients and doctors with date and time slots.
   - One-click status workflow (`Pending` $\rightarrow$ `Confirmed`) and cancellation support.

5. **Ward Admissions, Billing & Departments (`HospitalExtraServlet`, `HospitalExtraDAO`)**
   - **Ward Admissions:** Assign room numbers to patients and record automated discharge dates (`CURDATE()`).
   - **Billing & Invoices:** Generate itemized patient bills and track payment status (`Pending` / `Paid`).
   - **Departments:** Manage hospital departments and block locations.

---

## 🛠 Tech Stack & Architecture

| Layer | Technology |
| :--- | :--- |
| **Backend** | Java (JDK 17+), Jakarta Servlets, JSP |
| **Frontend** | HTML5, CSS3, Bootstrap 5.3 |
| **Database** | MySQL (XAMPP / phpMyAdmin) |
| **Connectivity** | JDBC (`mysql-connector-j-9.7.0`) with `PreparedStatement` |
| **Server** | Apache Tomcat 10.1+ |
| **IDE** | Apache NetBeans |
| **Design Pattern** | Layered MVC + DAO Pattern |

---

## 🗄 Database Schema
The application connects to a relational MySQL database named `hospital_management` consisting of **6 core tables**:
1. `patients` (`patient_id`, `name`, `age`, `gender`, `phone`, `address`, `disease`)
2. `doctors` (`doctor_id`, `doctor_name`, `specialization`, `phone`, `department_id`)
3. `appointments` (`appointment_id`, `patient_id`, `doctor_id`, `appointment_date`, `appointment_time`, `status`)
4. `departments` (`department_id`, `department_name`, `location`)
5. `admissions` (`admission_id`, `patient_id`, `room_number`, `admission_date`, `discharge_date`)
6. `billing` (`bill_id`, `patient_id`, `amount`, `payment_status`, `bill_date`)

---

## 📂 Project Directory Structure

```text
HospitalManagementWeb/
├── hospital_management.sql          # MySQL database schema & sample data dump
├── Web Pages/
│   ├── index.html                   # Entry redirect to login
│   ├── login.jsp                    # Staff login interface
│   ├── patient-list.jsp             # Main patients directory & search dashboard
│   ├── patient-form.jsp             # Add/Edit patient form with validation
│   ├── patient-report.jsp           # Printable outpatient/inpatient medical slip
│   ├── doctor-list.jsp              # Doctors directory & registration
│   ├── appointment-list.jsp         # Appointment booking & status management
│   └── hospital-operations.jsp      # Admissions, Billing & Departments dashboard
└── Source Packages/
    ├── connection/
    │   └── DBConnection.java        # Centralized JDBC connection utility
    ├── controller/
    │   ├── LoginServlet.java        # Session authentication handler
    │   ├── LogoutServlet.java       # Session termination handler
    │   ├── PatientServlet.java      # Patient CRUD & validation controller
    │   ├── DoctorServlet.java       # Doctor management controller
    │   ├── AppointmentServlet.java  # Appointment scheduling controller
    │   └── HospitalExtraServlet.java# Admissions, Billing & Dept controller
    ├── dao/
    │   ├── PatientDAO.java          # Patient SQL operations
    │   ├── DoctorDAO.java           # Doctor SQL operations
    │   ├── AppointmentDAO.java      # Appointment SQL operations
    │   └── HospitalExtraDAO.java    # Admissions, Billing & Dept SQL operations
    └── model/
        ├── Patient.java             # Patient JavaBean
        ├── Doctor.java              # Doctor JavaBean
        ├── Appointment.java         # Appointment JavaBean
        ├── Department.java          # Department JavaBean
        ├── Admission.java           # Admission JavaBean
        └── Billing.java             # Billing JavaBean
