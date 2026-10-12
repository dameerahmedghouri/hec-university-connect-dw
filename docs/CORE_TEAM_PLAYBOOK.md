# HEC University Connect — Core Team Operations & Governance Playbook

This document defines the operational standards, Git branching hierarchy, PR review protocols, folder governance, and integration workflows for the **Core Team (4 Members)**.

---

## 1. Core Team Composition & Key Responsibilities

| Role | Primary Responsibility | Daily / Weekly Execution |
| :--- | :--- | :--- |
| **C1: Project Lead & Architect** | Overall architecture, timelines, schema arbitration | Resolves naming conflicts, manages delivery milestones, owns `core/dimensions`. |
| **C2: Data Steward** | ID conformance, master seeds, data dictionary | Ensures every team follows universal key formats (`UNI-YY-NNNNN`, etc.), updates dictionary. |
| **C3: Platform Admin (Cloud & Git)** | Repository protection, dataset permissions, IAM | Maintains BigQuery datasets (`seed`, `dw`, `bi`), branch protection rules, `.gitignore`. |
| **C4: QA & Integration Lead** | Pull Request reviews, gate validation, data merges | Reviews code before merging to `main`, executes verified SQL in BigQuery `dw`. |

---

## 2. Git Branching Hierarchy & Workflow

```text
       [ student branches ] (e.g. t01-ali-clean, t04-sara-model)
               │  (PR reviewed by Team Lead)
               ▼
       [ team branches ]    (team-01, team-02 ... team-10)
               │  (PR reviewed strictly by Core Team QA)
               ▼
         [ main ]           (PROTECTED — Production Data Warehouse)
```

### Branch Rules:
1. **`main` (Protected)**:
   - Direct pushes and force pushes are strictly **BLOCKED**.
   - Only receives code through approved Pull Requests from official `team-XX` branches.
   - Only Core Team administrators have merge authority on `main`.
2. **`team-01` through `team-10` (10 long-lived branches)**:
   - Each team owns exactly one long-lived branch (`team-01`, `team-02`, etc.).
   - Maintained by the respective Team Lead.
3. **Student Branches (Short-lived)**:
   - Named pattern: `t<team_no>-<name>-<task>` (e.g., `t01-ali-clean`, `t05-bilal-exams`).
   - Created from `team-XX`, merged into `team-XX` via Team Lead review, then deleted.

---

## 3. Strict Folder Isolation & Allowed Structure

Every team has an isolated sandbox inside the repository. **Teams are strictly prohibited from editing anything outside their designated folder.**

```text
hec-university-connect-dw/
├── core/                       ← CORE TEAM ONLY (seed, shared dimensions, integration)
├── data/                       ← READ-ONLY for teams (University database dumps)
├── docs/                       ← CORE TEAM ONLY (Instruction guides, catalogs)
└── teams/
    ├── team-01/                ← TEAM 01 ONLY
    ├── team-02/                ← TEAM 02 ONLY
    │   ...
    └── team-10/                ← TEAM 10 ONLY
        ├── 01_staging/         # Only raw ingestion scripts & table definitions
        ├── 02_clean/           # Only SQL transformation & cleaning queries
        ├── 03_model/           # Only DDL and logic for Dimension & Fact tables
        ├── 04_tests/           # Only validation & data quality SQL tests
        ├── dashboard/          # Looker Studio / Power BI configs and SQL views
        └── docs/               # Team data dictionary and documentation
```

---

## 4. Handling Misplaced Folders & Junk / Stray Files

### Rule 1: A Team Creates Files Outside Their Folder (Root directory or another team's folder)
**Action:** **REJECT the Pull Request immediately.**
Do not accept PRs where files exist in the repository root or outside `teams/team-XX/`.

**Feedback to give the team lead:**
> *"PR rejected. You have created files outside your assigned folder. Please move all your files inside `teams/team-XX/<subfolder>/` and update the PR."*

**Git command to give them to fix it:**
```bash
# Move file to the correct subfolder:
git mv misplaced_script.sql teams/team-XX/02_clean/02_clean_script.sql
git commit -m "fix(chore): move files into teams/team-XX/"
git push origin team-XX
```

---

### Rule 2: Junk / Fazol / Temporary Files in Pull Requests
Teams might accidentally commit unnecessary files such as:
- Python cache (`__pycache__/`, `*.pyc`)
- OS files (`.DS_Store`, `Thumbs.db`)
- Scratch scripts (`test.py`, `temp.csv`, `dummy.sql`)
- Duplicate data dumps (re-uploading full university CSV dumps inside their folder)

**Action:**
1. Instruct the team to delete the files using `git rm`:
   ```bash
   git rm -r --cached __pycache__/
   git rm scratch_test.csv
   git commit -m "chore: remove unwanted junk files"
   git push origin team-XX
   ```
2. Verify that `.gitignore` in the repository root properly ignores:
   ```gitignore
   # Temporary and local IDE files
   .DS_Store
   Thumbs.db
   __pycache__/
   *.py[cod]
   *.log
   *.tmp
   scratch/
   .vscode/
   .idea/
   ```

---

## 5. Core Team PR Review Checklist (Gate Check)

Before clicking **Merge** on any PR coming from `team-XX` to `main`, the Core QA Lead must verify this 5-point checklist:

- [ ] **1. Folder Boundary Check:** Did the PR modify *only* files inside `teams/team-XX/`? (Zero changes in `core/`, `data/`, or root).
- [ ] **2. File Naming Standard:** Are SQL files named with execution sequence prefix?
  - `01_stg_*.sql`
  - `02_clean_*.sql`
  - `03_dim_*.sql` / `03_fact_*.sql`
  - `04_test_*.sql`
- [ ] **3. Conformed Keys Verification:** Did the team use universal standard business keys?
  - `student_id`: `UNI-YY-NNNNN` (e.g., `MUET-24-00001`)
  - `faculty_id`: `UNI-F-NNNN` (e.g., `KU-F-0012`)
  - `uni_code`: `MUET`, `KU`, `QAU`, `NUST`, `NED`
  - `date_key`: `YYYYMMDD` (unknown member: `19000101`)
- [ ] **4. No Raw Data Overwrites:** Did they maintain ELT principles? (Raw data remains untouched; all transformations done via SQL into clean/modeled tables).
- [ ] **5. Test Execution:** Are there at least 5 validation queries in `04_tests/` with passing results documented in their PR description?

---

## 6. How Core Team Merges and Deploys to BigQuery

### Step 1: Merging on GitHub
1. Open the Pull Request on GitHub (`team-XX` -> `main`).
2. Review the diff using the **Files Changed** tab.
3. If all checks pass, select **Merge pull request** (or **Squash and merge** for cleaner history).
4. Add merge comment: `Approved by Core Team QA (Gate X Passed)`.

### Step 2: Deployment in BigQuery
Once code hits `main`, Platform Admin / QA Lead executes the approved SQL scripts in BigQuery:
1. **Staging / Dev verification**: Verify team's `tNN_stg` and `tNN_dev` datasets.
2. **Publishing to `dw`**: Run the verified DDL / DML to publish the official dimension or fact table into the production **`dw`** dataset.
3. **Cross-table Integrity Test**:
   ```sql
   -- Example: Ensure no orphan foreign keys exist in the fact table
   SELECT COUNT(*) AS orphan_students
   FROM `dw.fact_enrollment` f
   LEFT JOIN `dw.dim_student` d ON f.student_id = d.student_id
   WHERE d.student_id IS NULL;
   -- Must return 0 orphans!
   ```

---

## 7. Troubleshooting & Emergency Protocols

| Scenario | Resolution Protocol |
| :--- | :--- |
| **Team 01 / 02 / 03 is late with Shared Dimensions** | Core Team deploys a fallback dimension directly into `dw` using the seed master list (`core/seed/`), allowing dependent teams (04, 05, 06, etc.) to continue without blocking. |
| **Merge conflict between two teams** | Impossible if folder isolation is respected. If a conflict occurs, it means someone edited a file outside their team folder. Revert the unauthorized change. |
| **Accidental table drop in BigQuery** | BigQuery stores history. Run `FOR SYSTEM_TIME AS OF` or re-execute the version-controlled SQL script from GitHub `main`. |
