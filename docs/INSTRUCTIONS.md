# HEC University Connect - Project Execution & Team Instructions

Welcome to the **HEC University Connect Data Warehouse** project.

This document serves as the master instructional guide for all student teams (**Team 01 to Team 10**) and the **Core Team** on how to ingest, clean, model, and integrate data from the 5 participating public universities into a centralized analytical data warehouse.

---

## 1. Source Data Organization

Operational database dumps from all 5 participating universities have been placed in the `data/universities/` directory:

```text
data/universities/
├── MUET/   # Mehran University of Engineering and Technology (Jamshoro)
├── KU/     # University of Karachi (Karachi)
├── QAU/    # Quaid-i-Azam University (Islamabad)
├── NUST/   # National University of Sciences and Technology (Islamabad)
└── NED/    # NED University of Engineering and Technology (Karachi)
```

Each university folder contains the operational transactional tables exported from that university's enterprise database systems (e.g. `applicants.csv`, `enrollments.csv`, `exam_marks.csv`, `fee_challans.csv`, etc.).

---

## 2. Team Topic Assignment & Source File Mapping

Each team owns one specific business process domain. To begin work, team members must inspect the source tables from each university corresponding to their assigned topic:

| Team | Domain / Topic | Tables to Ingest from Each University (`data/universities/<UNI>/`) | Target Warehouse Tables to Build |
| :--- | :--- | :--- | :--- |
| **Team 01** | Students & Admissions | `applicants.csv`, `admission_status.csv` | `dim_student` *(Shared)*<br>`fact_admission` |
| **Team 02** | Academic Programs | `programs.csv`, `university_programs.csv` | `dim_program` *(Shared)*<br>`fact_program_offering` |
| **Team 03** | Faculty Directory | `faculty.csv`, `faculty_yearly.csv` | `dim_faculty` *(Shared)*<br>`fact_faculty_year` |
| **Team 04** | Course Enrolment | `course_sections.csv`, `enrollments.csv` | `dim_course`<br>`fact_enrollment` |
| **Team 05** | Exams & Grades | `exam_marks.csv`, `grade_scale.csv` | `dim_grade`<br>`fact_exam_result` |
| **Team 06** | Tuition Fees | `fee_types.csv`, `fee_challans.csv`, `bank_payments.csv` | `dim_fee_type`<br>`fact_fee_payment` |
| **Team 07** | Scholarships | `scholarship_programs.csv`, `scholarship_awards.csv` | `dim_scholarship`<br>`fact_scholarship_award` |
| **Team 08** | Research & Publications | `journals.csv`, `publications.csv`, `paper_authors.csv` | `dim_journal`<br>`fact_publication`<br>`bridge_paper_author` |
| **Team 09** | Campus & Hostels | `facility_types.csv`, `facilities.csv`, `hostel_occupancy.csv` | `dim_facility_type`<br>`fact_facility_snapshot`<br>`v_facility_ratios` (View) |
| **Team 10** | Alumni & Jobs | `employers.csv`, `graduates.csv`, `employment_survey.csv` | `dim_employer`<br>`fact_alumni_placement` |

---

## 3. Step-by-Step Team Workflow

### Step 1: Ingestion & Staging (`01_staging/`)
1. Navigate to your team workspace under `teams/team-XX/`.
2. Fetch your assigned domain tables from all 5 university directories in `data/universities/`.
3. Load the raw tables into your team staging schema (`tNN_stg`) without modifying them.
4. Keep the raw data in its native form to preserve the original state for auditability.

### Step 2: Data Profiling & Cleaning (`02_clean/`)
Operational exports contain standard real-world data quality issues that each team must identify and resolve using SQL scripts stored in `02_clean/`:
- **Inconsistent String Formats**: Trimming leading/trailing whitespaces and standardizing mixed casing (e.g., student names, city names, degree labels).
- **Gender Codes**: Standardizing variants (`m`, `f`, `Male`, `Female`, `MALE`) into conformed categories (`Male`, `Female`).
- **Date Formatting**: Parsing mixed date formats (`DD/MM/YYYY`, `YYYY-MM-DD`, `DD-Mon-YYYY`) into standard SQL `DATE` types (`YYYY-MM-DD`).
- **Data Type Casting**: Converting numeric values formatted with strings/commas (e.g., salaries `"180,000"`, fees `"75,000"`, attendance `"88%"`) into appropriate `INT64` or `NUMERIC` types.
- **Deduplication**: Identifying and removing duplicate transactional submissions.
- **Handling Incomplete Records**: Addressing missing final exam marks (absent students), unpaid fee vouchers (challans without payments), and missing designations.

### Step 3: Dimensional Modeling (`03_model/`)
Using the cleaned data in `tNN_dev`, construct your team's star schema tables:
1. **Dimension Table**: Create your descriptive dimension table (`dim_<entity>`) with proper primary keys. Teams 01, 02, and 03 must also expose their conformed shared dimensions (`dim_student`, `dim_program`, `dim_faculty`).
2. **Fact Table**: Create your event/measurement ledger (`fact_<process>`) containing foreign keys linking to the shared dimensions, along with numeric measures. Document the single-sentence grain of your fact table.

### Step 4: Quality & Integrity Testing (`04_tests/`)
Write validation SQL queries to verify your models:
- Verify primary keys are unique and non-null.
- Verify every foreign key finds a matching record in the dimension table (no orphan keys).
- Verify numeric metrics are within realistic ranges (e.g., marks between 0–100, attendance between 0–100%, amounts ≥ 0).
- Confirm row counts and financial totals match the source data.

### Step 5: Analytics & Dashboards (`dashboard/` & `docs/`)
- Write analytical SQL queries to answer your assigned business questions.
- Connect your modeled tables to Looker Studio or Power BI to build your domain dashboard.
- Document your tables and column definitions in `teams/team-XX/docs/`.

---

## 4. Shared Key Standards

To ensure that fact tables join cleanly across all teams in the final warehouse:
- **University Code (`uni_code`)**: `MUET`, `KU`, `QAU`, `NUST`, `NED`.
- **Student Identifier (`student_id`)**: Standardized as `UNI-YY-NNNNN` (e.g. `MUET-24-00001`).
- **Faculty Identifier (`faculty_id`)**: Standardized as `UNI-F-NNNN` (e.g. `KU-F-0012`).
- **Program Identifier (`program_code`)**: Standard codes: `BSCS`, `BSEE`, `BBA`, `BSME`, `BSSE`, `BSCE`.
- **Date Key (`date_key`)**: Standard format `YYYYMMDD` (Unknown member key: `19000101`).
