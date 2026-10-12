# HEC University Connect — Git & GitHub Beginners Guide (Aasan Tareeqa)

Yeh guide un tamam students aur teams ke liye hai jinhon ne project par kaam karna hai. Isme bilkul aasan tareeqe se samjhaya gaya hai ke **Push**, **Pull**, aur **Branch** par kaam kaise karna hai — **Terminal (Commands)** se bhi aur **VS Code / GitHub Desktop (Direct GUI Apps)** ke zariye bhi!

---

## Golden Rule (Hamesha Yaad Rakhein)
> **Sirf Apne Folder Mein Kaam Karein!**  
> Aapki team ka jo number hai (maslan Team 04), aapko sirf `teams/team-04/` ke andar hi files banani aur edit karni hain. Root directory ya doosri team ke folder ko touch nahi karna.

---

## Tareeqa 1: VS Code App Ke Zariye (Sab Se Asaan — Zero Commands)

Agar aapko terminal ya commands use nahi karni, to VS Code ke interface se direct kaam karein:

### Step 1: Apni Team Branch Par Switch Karein
1. VS Code ke **niche baen kone (bottom-left corner)** par branch ka naam dikhta hai (jaise `main`).
2. Us par click karein.
3. Upar ek search bar khulega:
   - Agar aapki team ki branch already list mein hai (jaise `origin/team-04`), to us par click karein.
   - Agar nayi banani hai, to type karein `team-04` aur **"Create new branch..."** select karein.

### Step 2: Kaam Shuru Karne Se Pehle Pull Karein (Latest Code Lena)
- Niche left corner mein circular arrows 🔄 (Sync icon) par click karein, ya:
- Left panel par **Source Control** icon (3 dots wala icon) par click karein -> Upar 3 dots `...` par click karein -> **Pull** select karein.

### Step 3: Files Edit / Add Karein
- Apne folder `teams/team-XX/` ke andar apni SQL ya documentation files banayein aur save karein (`Ctrl + S`).

### Step 4: Commit Aur Push Karein
1. Left side bar par **Source Control** icon par click karein (wahan aapki changed files dikhengi).
2. Upar message box mein chota sa message likhein (e.g. `Team 04: added clean sql for attendance`).
3. **Commit** button dabayein.
4. **Sync Changes / Push** ka button aayega, us par click karein.
   *(Aapka kaam direct GitHub par aapki team branch mein chala gaya!)*

---

## Tareeqa 2: GitHub Desktop App Ke Zariye (Visual Interface)

Agar aap **GitHub Desktop** software use karte hain:
1. **Clone Repo**: GitHub Desktop khol kar `File` -> `Clone Repository` -> `hec-university-connect-dw` select karein.
2. **Current Branch**: Upar `Current Branch` par click karein aur apni team ki branch choose karein (e.g. `team-05`).
3. **Fetch/Pull origin**: Upar right side par **Fetch origin** par click karein taake latest code mil jaye.
4. **Kaam Karein**: Apne folder `teams/team-05/` mein files save karein.
5. **Commit**: GitHub Desktop khud hi aapki changes left side par dikhayega. Niche message likhein aur blue button **Commit to team-XX** dabayein.
6. **Push origin**: Upar **Push origin** par click kar dein. Kaam done!

---

## Tareeqa 3: Terminal / Command Prompt Ke Zariye

Agar aap terminal use karte hain, to bas yeh 5 commands aapki poori zaroorat poori kar dengi:

### Step 1: Repo Clone Karein (Sirf Pehli Baar)
```bash
git clone https://github.com/dameerahmedghouri/hec-university-connect-dw.git
cd hec-university-connect-dw
```

### Step 2: Apni Team Ki Branch Par Jayein
```bash
# Apni team ki branch par switch karein (e.g. team-03)
git checkout team-03

# Agar branch pehle se nahi bani hui to yeh karein:
git checkout -b team-03
```

### Step 3: Hamesha Kaam Se Pehle Pull Karein
Roz kaam shuru karne se pehle yeh command chalayein taake team members ka naya kaam aapke paas aa jaye:
```bash
git pull origin team-03
```

### Step 4: Kaam Karne Ke Baad Save Aur Commit Karein
Jab aap apne folder `teams/team-XX/` mein kaam complete kar lein:
```bash
# Sirf apne team folder ki changes add karein
git add teams/team-03/

# Message likhein
git commit -m "Team 03: clean faculty dataset script added"

# GitHub par push karein
git push origin team-03
```

---

## Step 5: Kaam Main Warehouse Mein Kaise Jayega? (Pull Request / PR)

Jab aapki team ka milestone ya task complete ho jaye:
1. Web browser mein repository open karein:  
   `https://github.com/dameerahmedghouri/hec-university-connect-dw`
2. Aapko upar yellow strip dikhegi: **"team-XX had recent pushes - Compare & pull request"**.
3. **Compare & pull request** par click karein.
4. Check karein:
   - **base:** `main`
   - **compare:** `team-XX`
5. Description mein likhein ke aapki team ne kya kaam kiya hai (maslan: *"Team 04 enrollment cleaning & tests complete"*).
6. **Create pull request** par click kar dein.
7. **Core Team** aapki PR review karegi aur use `main` mein merge kar degi!

---

## Aksar Aane Wale Masle Aur Unka Asaan Hal

### 1. "Push Rejected / Updates were rejected because remote contains work..."
**Waja:** Aapki team ke kisi aur member ne pehle push kar diya tha aur aapke local computer par woh code nahi hai.  
**Hal:** Pehle pull karein, phir push karein:
```bash
git pull origin team-XX
git push origin team-XX
```
*(VS Code mein bas 🔄 Sync Changes par click karein).*

---

### 2. Ghalat Jagah File Ban Gayi? (Root par ya kisi aur ke folder mein)
Aap file ko asaani se move kar sakte hain:
```bash
git mv ghalat_file.sql teams/team-XX/02_clean/
git commit -m "fix: moved file to correct team folder"
git push origin team-XX
```

---

### 3. Fazol File Commit Ho Gayi? (Cache ya scratch file)
Aap usko Git se delete kar sakte hain baghair asal computer se uraye:
```bash
git rm -r --cached unwanted_file.csv
git commit -m "chore: removed unwanted file"
git push origin team-XX
```
