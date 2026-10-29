
# HEC University Connect — Data Warehouse

A collaborative academic Data Warehouse project integrating operational data from **5 public universities** (MUET, KU, QAU, NUST, NED) into a centralized analytical warehouse.

---

## Repository Structure

```text
hec-university-connect-dw/
│
├── data/                          # Raw operational database dumps from universities
│   └── universities/
│       ├── MUET/                  # Mehran University of Engineering and Technology
│       ├── KU/                    # University of Karachi
│       ├── QAU/                   # Quaid-i-Azam University
│       ├── NUST/                  # National University of Sciences and Technology
│       └── NED/                   # NED University of Engineering and Technology
│
├── core/                          # Shared warehouse standards and reference materials
│   ├── seed/                      # Data dictionary and naming conventions
│   ├── dimensions/                # Conformed shared dimension layer (after integration)
│   └── integration/               # Cross-team merge and integration scripts
│
├── docs/                          # Project documentation
│   └── INSTRUCTIONS.md            # Team workflow guide and topic assignments
│
├── teams/                         # Individual team workspaces
│   ├── team-01/                   # Students & Admissions
│   ├── team-02/                   # Academic Programs
│   ├── team-03/                   # Faculty Directory
│   ├── team-04/                   # Course Enrolment
│   ├── team-05/                   # Exams & Grades
│   ├── team-06/                   # Tuition Fees
│   ├── team-07/                   # Scholarships
│   ├── team-08/                   # Research & Publications
│   ├── team-09/                   # Campus & Hostels
│   └── team-10/                   # Alumni & Employment
│       ├── 01_staging/            # Raw ingested tables from university data dumps
│       ├── 02_clean/              # SQL cleaning and transformation scripts
│       ├── 03_model/              # Dimension and Fact table DDL & population scripts
│       ├── 04_tests/              # Data quality and integrity validation queries
│       ├── dashboard/             # Looker Studio / Power BI dashboard files
│       └── docs/                  # Team-specific documentation and data dictionary
│
└── README.md
```

---

## Source Data — University Operational Dumps

Each university folder under `data/universities/<UNI_CODE>/` contains **24 raw operational CSV tables** exported from that university's enterprise systems (ERP, LMS, Student Information System, etc.).

| University | Code | Location | City |
| :--- | :--- | :--- | :--- |
| Mehran University of Engineering and Technology | `MUET` | `data/universities/MUET/` | Jamshoro, Sindh |
| University of Karachi | `KU` | `data/universities/KU/` | Karachi, Sindh |
| Quaid-i-Azam University | `QAU` | `data/universities/QAU/` | Islamabad |
| National University of Sciences and Technology | `NUST` | `data/universities/NUST/` | Islamabad |
| NED University of Engineering and Technology | `NED` | `data/universities/NED/` | Karachi, Sindh |

**Tables available in each university folder:**

| File | Team Owner | Content |
| :--- | :--- | :--- |
| `applicants.csv` | Team 01 | Student admission applications (dirty: mixed casing, 3 date formats) |
| `admission_status.csv` | Team 01 | Admitted / Rejected / Waiting decisions with merit numbers |
| `programs.csv` | Team 02 | Degree programs (dirty: inconsistent credit hours format) |
| `university_programs.csv` | Team 02 | Year-wise seats, enrolled count, and courses offered per program |
| `faculty.csv` | Team 03 | Faculty profiles (dirty: salary as text with commas, missing designations) |
| `faculty_yearly.csv` | Team 03 | Year-wise salary, courses taught, years of experience |
| `course_sections.csv` | Team 04 | Course sections with assigned faculty and semester |
| `enrollments.csv` | Team 04 | Student-section enrolment with attendance (dirty: %, >100, mixed dates) |
| `exam_marks.csv` | Team 05 | Midterm, final, and assignment marks (dirty: blanks, out-of-range values) |
| `grade_scale.csv` | Team 05 | Grade letter to grade point mapping (A+ to F) |
| `fee_types.csv` | Team 06 | Fee category reference lookup |
| `fee_challans.csv` | Team 06 | Fee vouchers issued to students (dirty: amounts with commas) |
| `bank_payments.csv` | Team 06 | Bank payment records (only ~85% of challans have matching payments) |
| `scholarship_programs.csv` | Team 07 | Available scholarship schemes and funders |
| `scholarship_awards.csv` | Team 07 | Student scholarship award records (dirty: mixed statuses, mixed dates) |
| `journals.csv` | Team 08 | Academic journal reference list with quartile rankings |
| `publications.csv` | Team 08 | Published research papers (dirty: citations with text, missing impact factor) |
| `paper_authors.csv` | Team 08 | Bridge table: paper-to-faculty many-to-many author links |
| `facility_types.csv` | Team 09 | Campus facility type reference list |
| `facilities.csv` | Team 09 | Year-wise facility snapshot: capacity vs occupied |
| `hostel_occupancy.csv` | Team 09 | Hostel-level rooms, capacity and students living count |
| `employers.csv` | Team 10 | Employer reference lookup with industry and size |
| `graduates.csv` | Team 10 | Graduate records with graduation year and final CGPA |
| `employment_survey.csv` | Team 10 | Alumni employment status, salary, and time-to-job (dirty: salary as text) |

---

## Team Workflow

```
data/universities/<UNI>/       (Source)
         │
         ▼
teams/team-XX/01_staging/      Step 1: Ingest raw tables into staging schema
         │
         ▼
teams/team-XX/02_clean/        Step 2: Write SQL to fix dirty data (dates, casing, types, duplicates)
         │
         ▼
teams/team-XX/03_model/        Step 3: Build Dimension + Fact table DDL per Data Model Catalog
         │
         ▼
teams/team-XX/04_tests/        Step 4: Validate integrity (primary keys, FK checks, range checks)
         │
         ▼
teams/team-XX/dashboard/       Step 5: Build analytical dashboard in Looker Studio or Power BI
```

> **Project Documentation & Guides:**
> - [Team Domain Instructions & Mapping](docs/INSTRUCTIONS.md)
> - [Git & GitHub Beginner's Guide (CLI + VS Code / Desktop App)](docs/GIT_GUIDE.md)
> - [Core Team Operations & Review Playbook](docs/CORE_TEAM_PLAYBOOK.md)
> - [Data Dictionary & Shared Keys](core/seed/DATA_DICTIONARY.md)
