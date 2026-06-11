# Documentation: `pages/database/countries.php`

## 1. Overview and Objectives
The `countries.php` page serves as the root management interface for the geographical hierarchy within the Manufacturing Execution System (MES). It allows administrators to define the top-level entity (Countries) to which downstream entities (Cities, Plants, Sections, Machines) are ultimately bound.

## 2. Use Cases
*   **Initial Setup**: An administrator logging into a fresh MES installation needs to define the countries where their manufacturing plants are located.
*   **Expansion**: The company acquires a new plant in a different country, requiring the addition of a new geographical record.
*   **Data Correction**: An administrator notices a typo in a country's name or ISO code and uses the edit function to correct it.
*   **Data Pruning**: A country operation is shut down, and the administrator removes the country (provided no dependent cities remain).

## 3. Program Flow & Logic
1.  **Authentication & Authorization Check**: The script includes `IsAdmin.php` to verify if the active session belongs to a user with the `admin` role. If not, they are likely denied access (handled within `IsAdmin.php`).
2.  **Initialization**: It instantiates the `CountryManager` class (from `includes/CountryManager.php`), injecting the global `$pdo` database connection.
3.  **Data Retrieval**:
    *   It checks for a `GET['search']` parameter.
    *   It calls `$countryManager->listAll($search)`, which executes a `SELECT * FROM country` query, applying a `LIKE` filter if a search term exists, ordered alphabetically by name.
4.  **POST Request Handling (CRUD)**: If the request method is POST and the user is an admin:
    *   **Create (`isset($_POST['create'])`)**: Calls `$countryManager->create($name, $isoCode)`.
    *   **Edit (`isset($_POST['edit'])`)**: Calls `$countryManager->update($id, $name, $isoCode)`.
    *   **Delete (`isset($_POST['delete'])`)**: Calls `$countryManager->delete($id)`.
    *   *Redirection*: Upon any successful POST action, the page redirects to itself via a `GET` request, appending a status message (e.g., `&msg=created`) to prevent form resubmission on page refresh (Post/Redirect/Get pattern).
5.  **Rendering**: The HTML is rendered using Bootstrap 5, displaying a filter bar, an "Add Country" button (if admin), and a data table. Modals are pre-rendered for adding and editing records.

## 4. User Experience (UX) Flow
1.  **Viewing**: The user navigates to the "Countries" page via the sidebar. They see a paginated (if implemented) or full list of countries.
2.  **Filtering**: The user types "Ger" into the search bar and clicks "Filter". The page reloads with only "Germany" displayed.
3.  **Adding**: The user clicks "Add Country", opening a Bootstrap modal. They fill in the form and click "Save". The page reloads, displaying a green success alert.
4.  **Editing**: The user clicks the yellow pencil icon next to a row. A modal pre-filled with the country's data appears. They modify the data and click "Save Changes".
5.  **Deleting**: The user clicks the red trash can icon. A browser-native confirmation dialog asks "Delete this country?". Upon clicking "OK", the record is deleted.

## 5. Required and Optional Inputs
### Create/Edit Country Form
*   **Country Name** (`name` / `edit_name`): **Required**. Type: String. Example: "Germany".
*   **ISO Code** (`iso_code` / `edit_iso_code`): **Required**. Type: String (3 characters max enforced via HTML `maxlength="3"`). The input is visually styled to uppercase (`text-transform:uppercase`) and programmatically converted to uppercase by `CountryManager`.

### Database Output
*   Action: **INSERT / UPDATE / DELETE**
*   Target Table: `country`
*   Mapped Columns: `CountryID` (Auto-increment), `Name`, `ISOCode`.

## 6. Theoretical Example Use Cases
### Example 1: Creating a New Country
*   **Action**: User clicks "Add Country".
*   **Inputs**:
    *   `name`: "United States"
    *   `iso_code`: "usa"
*   **Processing**: `CountryManager->create("United States", "usa")` is called. The logic converts "usa" to "USA".
*   **Output**: A new row is inserted into the `country` table: `(Name: 'United States', ISOCode: 'USA')`. Page redirects with `?msg=created`.

### Example 2: Deleting a Country with Dependencies
*   **Action**: User clicks delete on "France".
*   **Processing**: `CountryManager->delete(id)` executes `DELETE FROM country WHERE CountryID = ?`.
*   **Output**: If a City in the `city` table references France's `CountryID` (and the foreign key does not cascade delete), the PDO constraint fails. The exception is caught by the manager, returning `false`. The UI displays a red alert: "Error deleting country (might be linked to cities)."

## 7. Scientific Conclusion and Evaluation

**Effectiveness and Implementation Quality:**
The `countries.php` page successfully implements standard CRUD (Create, Read, Update, Delete) operations using a robust Manager pattern (`CountryManager`). The use of PDO prepared statements ensures protection against SQL injection. The Post/Redirect/Get (PRG) pattern prevents accidental duplicate submissions. The UI is clean, utilizing Bootstrap modals to keep the user on a single page context rather than navigating to separate form pages.

**Areas for Improvement (Research Gap):**
1.  **Pagination Strategy**: Currently, `listAll()` fetches all records. While the number of countries in the world is bounded (~195), a lack of server-side pagination could become a minor performance bottleneck in constrained environments, though practically negligible for this specific table.
2.  **Client-Side Validation vs. Server-Side Enforcement**: The HTML enforces `maxlength="3"` for the ISO code. However, the backend PHP `CountryManager` does not explicitly validate the length or format (e.g., ensuring it is exactly 2 or 3 letters) before insertion, relying entirely on the database schema's varchar limit or client-side HTML. Relying solely on client-side validation is a known security anti-pattern.
3.  **Error Handling Granularity**: When a creation fails, the UI assumes the error is due to a duplicate ISO code ("ISO Code might exist"). However, `CountryManager` catches *all* `PDOException`s and simply returns `false`. A more sophisticated implementation would inspect the exception code (e.g., checking for MySQL error 1062 for duplicates) and bubble up a specific, localized error message to the UI.

**Main Contributions:**
The primary contribution of this component is establishing the foundational geographical data layer. By enforcing structured relational data at the country level, the system ensures that downstream analytics (e.g., "OEE by Country") are reliable and unfragmented by free-text data entry.