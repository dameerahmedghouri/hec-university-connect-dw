# Git Guide — Teams & Members Ke Liye

Yeh guide sab team members ke liye hai taake Git aur GitHub par kaam karte waqt koi confusion na ho aur kisi ka code zaya na ho.

---

### Sab Se Zaroori Baat (Pehle Yeh Parh Lo)
- **Har team ka apna folder hai:** Agar aap **Team 04** mein ho, to aapko sirf `teams/team-04/` ke andar kaam karna hai.
- Bahar root folder par ya kisi doosri team ke folder mein koi file nahi banani.
- **Har team ki apni branch hai:** Maslan `team-01`, `team-02`, waghera. Main branch par direct kaam koi nahi karega.

---

## 1. VS Code Se Kaam Kaise Karna Hai (Sab Se Asaan Tareeqa)

Agar aapko terminal commands se darr lagta hai to VS Code se direct karo, koi command likhne ki zaroorat nahi hai:

### Step 1: Apni Team Ki Branch Par Aao
1. VS Code ke bilkul niche left side par dekho, wahan branch ka naam likha hoga (jaise `main`).
2. Us par click karo.
3. Upar search box aayega, wahan apni team ki branch select karo (jaise `team-03`). Agar pehle se nahi bani hui to wahan `team-03` likh kar enter kar do.

### Step 2: Kaam Shuru Karne Se Pehle Latest Code Lo (Pull)
1. VS Code ke left side par **Source Control** icon par jao (jahan 3 dots jaisa nishan hota hai).
2. Upar `...` (three dots) par click karo -> **Pull** par click karo.
*(Is se agar aapki team ke kisi doosre dost ne koi kaam push kiya hoga to wo aapke paas aa jayega).*

### Step 3: Apni File Banao Aur Kaam Karo
- Apne folder `teams/team-XX/` mein jao.
- Maslan `02_clean/` ke andar apni SQL file banao, kaam karo aur save karo (`Ctrl + S`).

### Step 4: GitHub Par Bhejo (Commit & Push)
1. Left side par wapis **Source Control** icon kholo. Wahan aapki edited files dikh rahi hongi.
2. Upar message box mein likho ke aapne kya kaam kiya (jaise: `added clean script for admissions`).
3. **Commit** ka button dabao.
4. Niche blue button aayega **Sync Changes** ya **Push**, us par click kar do.  
Bas! Aapka kaam GitHub par chala gaya.

---

## 2. Terminal Se Kaam Kaise Karna Hai (Command Prompt / Bash)

Agar aap terminal use karte ho to bas yeh 4 steps yaad rakho:

```bash
# 1. Apni team ki branch par aao
git checkout team-03

# 2. Hamesha kaam shuru karne se pehle pull karo
git pull origin team-03

# 3. Kaam karne ke baad sirf apna team folder add aur commit karo
git add teams/team-03/
git commit -m "added cleaning sql"

# 4. Push kar do
git push origin team-03
```

---

## 3. Sab Ka Common Sawal: "Agar Kisi Aur Ne Push Kar Diya Aur Maine Baad Mein Kiya To Mera Code Chala Jayega?"

**Jawab: Nahi bhai, Git aapka code delete nahi karta.**

Lekin masle se bachne ka seedha tareeqa yeh hai:

### Golden Rule: Team Ke Log Files Aapas Mein Baant Lein
Kaam shuru karne se pehle aapas mein tay kar lo:
- Ek banda `clean_applicants.sql` banaye.
- Doosra banda `clean_status.sql` banaye.
- Teesra banda `tests.sql` banaye.

**Jab sab log alag alag files par kaam karenge, to kabhi koi clash ya masla aayega hi nahi.** Dono ka kaam aram se merge ho jayega.

### Agar Doosre Ne Pehle Push Kar Diya Ho Aur Aapka Push Rok Diya Jaye:
Agar aap push karo aur error aa jaye ke *"Updates were rejected because the remote contains work..."*, to ghabrana nahi hai:

1. **Pehle apna code commit karo** (taake aapka kaam save ho jaye):
   ```bash
   git add teams/team-XX/
   git commit -m "mera kaam"
   ```
2. **Phir pull karo** (taake sathi ka kaam bhi aa jaye):
   ```bash
   git pull origin team-XX
   ```
3. **Ab push karo**:
   ```bash
   git push origin team-XX
   ```
*(VS Code mein bas Commit karne ke baad **Sync Changes** dabane se yeh kaam automatically ho jata hai).*

---

## 4. Kaam Mukammal Hone Ke Baad Kya Karna Hai? (Pull Request / PR)

Jab aapki team ka task ya milestone complete ho jaye:
1. Browser mein GitHub repo kholo.
2. Upar ek yellow patti aayegi: **"Compare & pull request"**, us par click karo.
3. Check karo:
   - `base: main`
   - `compare: team-XX`
4. Title mein likho: `Team XX Complete Cleaning & Model`.
5. **Create pull request** par click kar do.
6. Core Team aapka code check karegi aur usko `main` warehouse mein daal degi.

---

## 5. Agar Koi Ghalti Ho Jaye To Kya Karein?

- **Ghalti se file bahar root folder mein ban gayi?**
  Usko apne folder mein move kar lo:
  ```bash
  git mv ghalti_wali_file.sql teams/team-XX/02_clean/
  git commit -m "moved file to correct folder"
  git push origin team-XX
  ```

- **Koi fazol file commit ho gayi?**
  Git se remove kar do:
  ```bash
  git rm -r --cached unwanted_file
  git commit -m "removed unwanted file"
  git push origin team-XX
  ```
