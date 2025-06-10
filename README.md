## 🏥 Healthcare Database SQL Queries

### 📘 Project Overview

This repository houses a comprehensive suite of SQL queries tailored for managing and analyzing data within a relational healthcare database. The queries span various facets of hospital operations, including patient care, staff management, room assignments, appointments, and medical procedures. The primary objective is to provide efficient data retrieval and reporting capabilities for healthcare administrators, clinicians, and researchers.

### 🔑 Key Features

* **Patient Management**: Retrieve patient information, appointment details, and treatment histories.
* **Staff Management**: Access data related to physicians, nurses, and other healthcare staff, including roles and certifications.
* **Room and Facility Management**: Monitor room availability, block and floor assignments, and on-call nurse scheduling.
* **Medical Procedures and Prescriptions**: Track medical procedures, prescribed medications, and associated costs.
* **Affiliations and Certifications**: Manage physician department affiliations and training certifications.

### 📄 Sample Queries

#### 1. Retrieve Information of Unregistered Nurses

```sql
SELECT * FROM nurse WHERE registered = 'f';
```

#### 2. List Physicians and Their Affiliated Departments

```sql
SELECT p.name AS physician_name, d.name AS department_name
FROM physician p
INNER JOIN affiliated_with aw ON p.employeeid = aw.physician
INNER JOIN department d ON d.department_id = aw.department;
```

#### 3. Count of Available Rooms in Each Block

```sql
SELECT blockcode, COUNT(*) AS available_rooms
FROM room
WHERE unavailable = 'f'
GROUP BY blockcode;
```

#### 4. Patients and Their Treating Physicians

```sql
SELECT p.name AS patient_name, phy.name AS physician_name
FROM patient p
INNER JOIN appointment ap ON p.ssn = ap.patient
INNER JOIN physician phy ON ap.physician = phy.employeeid;
```

#### 5. Nurses Assigned to Room 122

```sql
SELECT n.name AS nurse_name
FROM nurse n
INNER JOIN on_call o ON n.employeeid = o.nurse
INNER JOIN room r ON o.blockfloor = r.blockfloor AND o.blockcode = r.blockcode
WHERE r.roomnumber = 122;
```

### 🗂️ Database Schema Overview

The queries interact with the following tables:

* **patient**: Stores patient details such as name, SSN, primary care physician, and admission information.
* **physician**: Contains information about physicians, including their employee ID, name, position, and department affiliations.
* **nurse**: Holds data on nurses, including their employee ID, name, registration status, and assigned rooms.
* **room**: Details about hospital rooms, including room number, block, floor, and availability status.
* **appointment**: Records patient appointments, including scheduled times, assigned physicians, and assisting nurses.
* **prescribes**: Links physicians to prescribed medications for patients.
* **procedure1**: Information on medical procedures, including codes, names, and associated costs.
* **stay**: Tracks patient admissions, including room assignments and discharge dates.
* **on\_call**: Schedules for nurses assigned to be on call for specific rooms.

### 📚 Table of Contents

1. **Nurse Management**

   * Query 1: Find unregistered nurses.
   * Query 2: Identify head nurses by department.

2. **Physician and Department Relations**

   * Query 3: List physicians heading departments.
   * Query 8: Physicians and their affiliated departments.
   * Query 9: Physicians trained for specific treatments.
   * Query 10: Physicians not yet affiliated with departments.
   * Query 11: Non-specialized physicians.

3. **Patient Appointments and Interactions**

   * Query 4: Count patients with appointments.
   * Query 12: Patients and their preliminary treatment physicians.
   * Query 13: Patients and the number of physicians they've seen.
   * Query 14: Unique patients in examination room C.
   * Query 15: Patients and their assigned treatment rooms.
   * Query 18: Patients not requiring nurse assistance.

4. **Room and Facility Management**

   * Query 5: Locate room number 212.
   * Query 6: Count available rooms.
   * Query 7: Count unavailable rooms.
   * Query 22: Available rooms per block.
   * Query 23: Available rooms per floor.
   * Query 24: Available rooms per block and floor.
   * Query 25: Unavailable rooms per block and floor.
   * Query 26: Floor with maximum available rooms.
   * Query 27: Floor with minimum available rooms.

5. **Patient Admissions and Stays**

   * Query 28: Patients and their admission details.

6. **Nurse Scheduling**

   * Query 16: Nurses and their scheduled rooms.
   * Query 29: Nurses assigned to blocks for patient calls.

7. **Medical Procedures and Prescriptions**

   * Query 19: Patients, physicians, and prescribed medications.
   * Query 20: Patients with advanced appointments and their medications.
   * Query 21: Patients without appointments and their medications.
   * Query 30: Comprehensive patient treatment report.
   * Query 31: Physicians performing uncertified procedures.
   * Query 32: Physicians, procedures, and patients for uncertified treatments.
   * Query 33: Physicians performing procedures after certification expiry.
   * Query 34: Detailed report on physicians performing expired procedures.
   * Query 36: Patients prescribed medication by their primary care physician.
   * Query 37: Patients undergoing high-cost procedures by their primary care physician.

8. **Appointment and Nurse Assistance**

   * Query 38: Patients with at least two appointments requiring registered nurse assistance.

9. **Department Leadership**

   * Query 39: Patients whose primary care is by a physician not heading any department.


