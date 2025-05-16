# Unified Portfolio Management System

A complete end-to-end system for managing and analyzing financial portfolios.  
Combines a **data engineering backend** with a **web-based portfolio management frontend**.

---

## 🧩 Project Components

### 1. 📊 Integrated Financial Data System (Python + SQL)

- `FMPS_Master_Full_Setup.sql`: Defines user, portfolio, asset, and transaction schemas
- `FMPS_Master_Python_Loader.py`: Loads financial data into MySQL
- `Simulated_Market_Data.csv`: Sample stock/asset data used for simulation and forecasting

### 2. 🌐 Web Portfolio Management App (PHP + MySQL)

- `PORTFOLIO_MANAGEMENT_SYSTEM.sql`: SQL schema for portfolio web app
- `.php` files: Frontend and backend PHP files for login, watchlist, transactions, etc.
- `URS Portfolio Management.pdf`: Requirements and functionality scope
- ER Diagrams: Help understand entity relationships and schema design

---

## 🛠️ Technologies Used

| Backend | Frontend | Data |
|--------|----------|------|
| MySQL  | PHP      | CSV (simulated) |
| Python | HTML/CSS | SQL |
| pandas | Bootstrap (optional) | Jupyter for preprocessing |

---

## 🚀 Setup Instructions

### Step 1: Database Setup
1. Create MySQL database instances:
   - `portfolio_web` – for the web app (use `PORTFOLIO_MANAGEMENT_SYSTEM.sql`)
   - `portfolio_data` – for simulation (use `FMPS_Master_Full_Setup.sql`)

2. Load data:
```bash
python FMPS_Master_Python_Loader.py
```

### Step 2: PHP Web App
1. Host on local server (e.g., XAMPP)
2. Place files from `Portfolio-Management-System-main/` into `htdocs`
3. Set DB config in `config.php`

### Step 3: Explore
- Visualize ER Diagram for schema understanding
- Use web interface to add transactions and simulate portfolios

---

## 📈 Business Value

- Track assets, transactions, and returns
- Simulate market outcomes with historical data
- Provide user-specific dashboards (via PHP)
- Automate data loading with Python for ongoing simulations

---

## 📄 License
This repository is licensed under the MIT License.

---

## 🙌 Credits
Created by combining backend engineering and frontend development efforts to build a scalable investment tracking and simulation platform.
