# Team 09 Beginner Friendly Guide (Campus & Hostels)

## 1) Team 09 ka topic kya hai?
Team 09 ka domain **Campus & Hostels** hai.

Hum in 3 source files par kaam karte hain (har university se):
- `facility_types.csv`
- `facilities.csv`
- `hostel_occupancy.csv`

Humari final outputs:
- `dim_facility_type`
- `fact_facility_snapshot`
- `v_facility_ratios`

---

## 2) Data Warehouse concept (simple words)
Data Warehouse ka matlab hai:
- Multiple universities ka data aik jagah lana
- Data ko clean aur standard format mein convert karna
- Reports aur dashboard ke liye ready tables banana

Team 09 ke case mein:
- **Dimension table (`dim_facility_type`)**: facility type ki details (jaise Lab, Library, Hostel type)
- **Fact table (`fact_facility_snapshot`)**: numbers/measures (capacity, occupied, year, etc.)
- **View (`v_facility_ratios`)**: utilization ratio nikalna (occupied vs capacity)

---

## 3) Aap ka kaam (Leader: Muhammad Daniyal)
Aapka role coordination + quality control ka hai.

### Leader tasks
1. Team ka weekly plan banana (staging -> clean -> model -> test -> dashboard).
2. Har member ko clear task dena aur deadline track karna.
3. Sab SQL scripts review karna (naming, keys, consistency).
4. Final files integrate karna in folders:
   - `01_staging/`
   - `02_clean/`
   - `03_model/`
   - `04_tests/`
5. Final QA/sign-off dena aur docs complete karna.

---

## 4) Members ka kaam

## Khatija (Staging + Profiling)
1. 5 universities se raw files collect karo.
2. `01_staging/` mein load scripts banao.
3. Raw data ko without transformation load karo.
4. Basic profiling banao:
   - row counts
   - missing values
   - duplicate signals
5. Profiling report Farhan aur Zahid ko do.

## Farhan (Cleaning)
1. `02_clean/` mein cleaning SQL likho.
2. Text/casing standardize karo.
3. Null ya invalid capacity/occupancy values handle karo.
4. Duplicates remove karo.
5. Data types normalize karo (numeric/date).

## Zahid (Modeling)
1. `03_model/` mein `dim_facility_type` banao.
2. `fact_facility_snapshot` banao with proper keys/measures.
3. `v_facility_ratios` view create karo.
4. Fact table grain clearly define karo.
5. Model scripts Sajjad ko testing ke liye handover karo.

## Sajjad (Testing + Dashboard Support)
1. `04_tests/` mein SQL tests likho:
   - PK unique/non-null
   - FK integrity
   - capacity/occupancy range checks
2. Row counts reconcile karo (clean layer vs fact).
3. `v_facility_ratios` logic validate karo.
4. Dashboard KPIs ke liye ready query outputs do.

---

## 5) Task complete karne ka practical flow
1. **Collect**: Khatija raw data staging mein load kare.
2. **Clean**: Farhan dirty values fix kare.
3. **Model**: Zahid final warehouse tables/view banaye.
4. **Test**: Sajjad quality checks chalaye.
5. **Lead Review**: Daniyal final review + integration + submission kare.

Agar kisi step mein issue aaye, leader issue log maintain kare aur next member ko clean handoff de.
