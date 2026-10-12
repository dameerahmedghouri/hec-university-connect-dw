# HEC University Connect - Raw University Data Dictionary

This document details the authentic **operational transactional datasets** exported by the 5 participating universities (**MUET, KU, QAU, NUST, NED**) and stored under:
```text
data/universities/
├── MUET/
├── KU/
├── QAU/
├── NUST/
└── NED/
```

Each university folder contains the raw tables exported directly from that university's operational databases. Each group team picks their topic's files across these 5 universities, imports them into their `teams/team-XX/01_staging/` folder, performs ETL cleaning in `02_clean/`, and builds their star schema in `03_model/`.

---

## 1. Table Inventory in Each University Folder

Every university directory (`data/universities/<UNI_CODE>/`) contains the following 24 operational tables:

| # | File Name | Topic / Team Owner | Description & Operational Columns |
| :--- | :--- | :--- | :--- |
| 1 | `applicants.csv` | Team 01 (Admissions) | `applicant_id, name, gender, dob, home_city, home_province, home_area_type, program_code, entry_test_marks, admission_date` |
| 2 | `admission_status.csv` | Team 01 (Admissions) | `applicant_id, status, merit_no` |
| 3 | `programs.csv` | Team 02 (Programs) | `program_code, program_name, department, school_name, degree_level, duration_years, total_credit_hours` |
| 4 | `university_programs.csv` | Team 02 (Programs) | `program_code, year, seats, enrolled_count, courses_offered` |
| 5 | `faculty.csv` | Team 03 (Faculty) | `faculty_id, name, gender, highest_degree, designation, department, joining_date, current_salary` |
| 6 | `faculty_yearly.csv` | Team 03 (Faculty) | `faculty_year_id, faculty_id, year, salary_pkr, courses_taught, years_experience` |
| 7 | `course_sections.csv` | Team 04 (Courses) | `section_id, course_code, course_name, program_code, credit_hours, course_type, semester_level, faculty_id, semester` |
| 8 | `enrollments.csv` | Team 04 (Courses) | `enrollment_id, student_id, section_id, attendance_percent, enroll_date` |
| 9 | `exam_marks.csv` | Team 05 (Exams) | `result_id, student_id, course_code, semester, exam_date, midterm, final, assignment` |
| 10 | `grade_scale.csv` | Team 05 (Exams) | `grade_code, min_marks, max_marks, grade_points, result_status` |
| 11 | `fee_types.csv` | Team 06 (Fees) | `fee_type_id, fee_type_name, fee_category, is_refundable_flag` |
| 12 | `fee_challans.csv` | Team 06 (Fees) | `challan_no, student_id, fee_type_id, amount_due, due_date, semester` |
| 13 | `bank_payments.csv` | Team 06 (Fees) | `payment_id, challan_no, amount_paid, payment_date, bank` |
| 14 | `scholarship_programs.csv` | Team 07 (Scholarships) | `scholarship_id, scholarship_name, scholarship_type, funder, max_amount_pkr` |
| 15 | `scholarship_awards.csv` | Team 07 (Scholarships) | `award_id, student_id, scholarship_id, amount_awarded, award_date, status` |
| 16 | `journals.csv` | Team 08 (Research) | `journal_id, journal_name, publisher, country, quartile` |
| 17 | `publications.csv` | Team 08 (Research) | `paper_id, journal_id, publication_date, paper_title, citations, impact_factor, author_count` |
| 18 | `paper_authors.csv` | Team 08 (Research) | `paper_id, faculty_id, author_order` |
| 19 | `facility_types.csv` | Team 09 (Facilities) | `facility_type_id, facility_type_name, facility_group, unit_name` |
| 20 | `facilities.csv` | Team 09 (Facilities) | `snapshot_id, facility_type_id, year, units_available, capacity, occupied` |
| 21 | `hostel_occupancy.csv` | Team 09 (Facilities) | `year, hostel_name, rooms, capacity, students_living` |
| 22 | `employers.csv` | Team 10 (Alumni) | `employer_id, employer_name, industry, city, employer_size` |
| 23 | `graduates.csv` | Team 10 (Alumni) | `student_id, graduation_year, final_cgpa` |
| 24 | `employment_survey.csv` | Team 10 (Alumni) | `placement_id, student_id, employer_id, job_start_date, start_salary, months_to_job, status` |

---

## 2. Intentional Dirty Data Profiles (For ETL Tasks)

The operational data contains real-world defects that teams must clean in `02_clean/`:
1. **Case & Space Anomalies**: Mixed casing (`muhammad ALI`, `FATIMA zahra`), leading/trailing spaces (`" bilal ahmed "`).
2. **Unstandardized Genders**: Multi-variant values (`m`, `f`, `Male`, `Female`, `MALE`, `FEMALE`, `female `, `Male `).
3. **Multiple Date Formats**: `DD/MM/YYYY`, `YYYY-MM-DD`, and `DD-Mon-YYYY`.
4. **Text / Formatted Numerics**: Salaries and fee amounts stored with commas or currency strings (`"180,000"`, `"PKR 250,000"`).
5. **City Spellings**: Slang/abbreviations (`hyd`, `KHI`, `pindi`, `SKR`, `PEW`, `FSD`, `lhr`, `isb`).
6. **Out-of-Range Measures**: Attendance percentages exceeding 100 or containing `%` signs, midterm exam scores > 30.
7. **Missing Data**: Absent exam finals (blank values), missing designations, challans with no matching payments (unpaid/pending fees).
8. **Inconsistent Degree Names**: `PhD`, `Ph.D`, `phd`, `MPhil`, `M.Phil`, `MS`.
9. **Duplicate Records**: Intentional duplicates simulating retry attempts in operational systems.

---

## 3. Team Workflow (How Each Team Uses This Data)

1. **Pick Data**: Team members browse `data/universities/` and select their topic's files from all 5 universities.
   - Example: Team 07 copies `scholarship_awards.csv` and `scholarship_programs.csv` from `MUET/`, `KU/`, `QAU/`, `NUST/`, `NED/` into `teams/team-07/01_staging/`.
2. **Stage**: Load into staging database (`tNN_stg`).
3. **Clean (`02_clean`)**: Write SQL cleaning scripts to fix casing, parse dates, cast numeric amounts, and remove duplicates.
4. **Model (`03_model`)**: Build target dimension and fact tables according to the Data Model Catalog.
5. **Test (`04_tests`)**: Run validation queries ensuring zero orphan keys and valid measurement ranges.
