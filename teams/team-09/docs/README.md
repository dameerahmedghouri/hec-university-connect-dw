# Team 09 - Campus & Hostels Task Distribution

## Team 09 Work Summary
Team 09 is responsible for the **Campus & Hostels** domain in this data warehouse project.

### Assigned source files (from each university)
- `facility_types.csv`
- `facilities.csv`
- `hostel_occupancy.csv`

### Team 09 target outputs
- `dim_facility_type`
- `fact_facility_snapshot`
- `v_facility_ratios` (view)

### Workflow coverage
- `01_staging/`: ingest raw files for all 5 universities
- `02_clean/`: standardize and clean domain data
- `03_model/`: build dimension, fact, and analytical view
- `04_tests/`: run quality and integrity checks
- `dashboard/`: create analytics visuals and KPIs
- `docs/`: maintain Team 09 documentation

## Team Structure
- **Team Leader:** Muhammad Daniyal
- **Members:**
  1. Khatija
  2. Farhan
  3. Zahid
  4. Sajjad

## Task Distribution
| Person | Responsibility Area | Main Deliverables |
|---|---|---|
| Muhammad Daniyal (Leader) | Planning, coordination, integration, review | Work plan, merge-ready SQL package, final QA sign-off, documentation review |
| Khatija | Staging and profiling | Raw ingestion scripts, profiling report for facility and hostel fields |
| Farhan | Cleaning and standardization | Cleaning SQL for nulls, casing, duplicates, and numeric/date formatting |
| Zahid | Dimensional modeling | `dim_facility_type`, `fact_facility_snapshot`, and load scripts |
| Sajjad | Testing and dashboard support | Validation SQL checks, ratio query validation, dashboard KPI mapping |

## File Map
- `leader_muhammad_daniyal.md`
- `member_khatija.md`
- `member_farhan.md`
- `member_zahid.md`
- `member_sajjad.md`
- `beginner_guide_team09.md`
