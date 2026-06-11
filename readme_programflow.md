# Experimental MES (Manufacturing Execution System) - Program Flow & Architecture

This document provides a comprehensive overview of the application's structure, standard operation flows, specific use cases, and self-healing database mechanics.

## 📁 Project Structure

The project is structured to separate concerns into specific directories for ease of maintenance:

*   **`api/`**: Contains the PHP scripts that handle backend logic. These are the endpoints accessed via AJAX/fetch requests from the frontend or external API clients.
*   **`app/`**: (If utilized) Typically holds core application logic or specific micro-components outside of standard API responses.
*   **`includes/`**: Stores core classes (e.g., `Database.php`, `UserManager.php`), managers (`MachineManager`, `CountryManager`), configuration files (`Config.php`), and shared components (like the sidebar).
*   **`pages/`**: Holds the individual views for the backoffice dashboard (e.g., managing entities like machines, articles, or users).
*   **`simulator/`**: Contains external integration simulators (like `plc-simulator.py`), used to generate dummy machine signals for testing WAGO/PLC connections.
*   **`sql/`**: Contains database schemas and SQL files. Notably, `schema_mariadb.sql` is used as the source of truth for the self-healing DB process.
*   **`styles/`**: CSS files for the backend and frontend views.
*   **`tests/`**: A custom test suite/runner (`run_tests.php`) and test cases (`*Test.php` files).
*   **`totem/`**: Contains the frontend assets (JS, CSS, images) specifically tailored for the `totem-compact.php` interface used by factory operators.

### Key Root Files:
*   **`index.php`**: The entry point for the application. It handles routing and database healing.
*   **`install.php`**: The initial setup wizard that configures the connection, creates tables, and seeds dummy data.
*   **`login.php` / `logout.php`**: Standard authentication flows.
*   **`dashboard.php`**: The main interface for the Admin backoffice.
*   **`totem-compact.php`**: The shop floor (operator) touchscreen interface.

---

## 🔄 Software Flow: From Installation to Shutdown

1.  **Environment Start (Docker/XAMPP)**: The user boots their web server environment (e.g., Apache/MySQL via XAMPP or a Docker container). The database service runs in the background.
2.  **First Access (Installation)**: The user navigates to the application URL (e.g., `http://localhost/mes/`). `index.php` detects that `includes/Database.php` does not exist and immediately redirects the user to `install.php`.
3.  **Installation Wizard (`install.php`)**: The user provides database credentials. The script creates the database structure, seeds dummy data (e.g., fake plants, machines, articles, and users), and dynamically generates `includes/Database.php` and `includes/Config.php`. After successful installation, it redirects back to `index.php`.
4.  **Application Entry (`index.php`)**: `index.php` now connects to the database, performs a self-healing check (see below), and evaluates the user session. If no valid session exists, it redirects to `login.php`.
5.  **Authentication (`login.php`)**: The user enters their credentials. Admins logging in are redirected to `dashboard.php`. Operators usually access `totem-compact.php` directly (often set as the default homepage on a factory floor tablet).
6.  **Usage**: Admins configure system entities via `dashboard.php` (routing to various `pages/`). Operators interact with machine states via `totem-compact.php` and `api/`.
7.  **Shutdown/Logout**: The user finishes their shift/session and clicks 'Logout', which triggers `logout.php`. This destroys the PHP session (`session_destroy()`) and redirects back to `login.php`.

---

## 🛠️ Application Flow & Self-Healing Database (`index.php`)

`index.php` serves as the smart router and database guardian. The flow is as follows:

1.  **Configuration Check**:
    If `includes/Database.php` is missing, redirect to `install.php`.
2.  **Self-Healing Database Routine**:
    If `includes/Database.php` is present, it attempts a connection.
    It checks for the existence of `sql/schema_mariadb.sql`. If found, it fetches a list of all existing tables in the current database (`SHOW TABLES`).
    It parses `sql/schema_mariadb.sql` using a regular expression (`/CREATE TABLE (IF NOT EXISTS )?\`([a-zA-Z0-9_]+)\`/i`) to extract all tables that *should* exist.
    It compares the required tables against the existing tables to find any `missingTables`.
    If tables are missing, it temporarily disables foreign key checks (`SET FOREIGN_KEY_CHECKS = 0;`), parses the SQL file line-by-line, and executes any `CREATE TABLE` or `ALTER TABLE` statements associated with the missing tables. Finally, it restores foreign key checks (`SET FOREIGN_KEY_CHECKS = 1;`). This ensures the app doesn't break if a user drops a core table.
3.  **Session & Routing Check**:
    It calls `session_start()`.
    If the user has an active session (`isset($_SESSION['user_id'])`):
    *   If their roles contain `admin`, they are redirected to `dashboard.php`.
    *   If not an admin, they are redirected to `login.php` (operator access is via `totem-compact.php` directly).
    If no active session exists, the user is redirected to `login.php`.

---

## 🧑‍💻 Specific Use Cases

### 1. The Operator on the Shop Floor (Totem)
*   **Flow**: An operator walks up to a touchscreen tablet stationed at a machine. The browser is permanently pointed to `totem-compact.php`.
*   **Action**: If a machine ID isn't set, they select their plant/machine from a list. Once a machine is selected, the Totem interface loads. It uses an AJAX-driven architecture, constantly polling `api/` endpoints (like `api/totem-state.php`) to fetch live machine state without page reloads.
*   **Purpose**: They can start/stop production orders, log downtime (stops), and register reject reasons for quality control.

### 2. The Plant Manager (Backoffice)
*   **Flow**: A manager logs in from their office PC via `login.php`.
*   **Action**: Because they have the `admin` role, `index.php` (or the login script) directs them to `dashboard.php`. They navigate through the left sidebar to manage entities (Countries, Plants, Sections, Machines).
*   **Purpose**: They can define the factory hierarchy, add new operators, assign API keys, and oversee production data.

### 3. API Clients & Simulation Scripts
*   **Flow**: A Python script (`simulator/plc-simulator.py`) or an external ERP system wants to push/pull data.
*   **Action**: They authenticate using an API key (generated in the Backoffice by an Admin). The key is sent via the `X-API-KEY` header to endpoints inside `api/`.
*   **Purpose**: This allows external PLCs or testing scripts to inject machine signals directly into the database or pull finished production order stats.
