# Documentation: `pages/database/cities.php`

## 1. Overview and Objectives
The `cities.php` page manages the second tier of the geographical hierarchy in the MES architecture. It allows administrators to define cities and link them relationally to previously defined Countries. This structured approach is essential for mapping physical manufacturing plants to specific geographical locations for reporting and logistical purposes.

## 2. Use Cases
*   **System Initialization**: After creating countries, the admin sets up the specific cities where the company operates facilities.
*   **Facility Relocation**: If a plant is moved or a new one opens in a new city, the admin adds the city to the database.
*   **Data Refinement**: Adding or updating postal codes for logistical integration with ERP systems.
*   **Data Filtering**: A manager wants to view all operating cities within a specific country (e.g., "Show me all cities in Germany").

## 3. Program Flow & Logic
1.  **Security & Instantiation**: Checks for the `admin` role via `IsAdmin.php`. Instantiates both `CityManager` and `CountryManager` (to populate dropdowns).
2.  **Filter Processing**:
    *   Reads `GET['filter_country']` (integer) and `GET['search']` (string) parameters.
    *   Calls `$cityManager->listAll($filterCountry, $search)` to fetch filtered city records. This query employs a `LEFT JOIN country co ON c.CountryID = co.CountryID` to retrieve the parent country's name and ISO code.
    *   Calls `$countryManager->listAll()` to populate the `<select>` options for adding/editing and filtering.
3.  **POST Request Handling (CRUD)**:
    *   **Create**: Calls `$cityManager->create($name, $countryId, $postalCode)`.
    *   **Edit**: Calls `$cityManager->update($cityId, $name, $countryId, $postalCode)`.
    *   **Delete**: Calls `$cityManager->delete($cityId)`.
    *   Implements the Post/Redirect/Get pattern to append success messages to the URL upon completion.

## 4. User Experience (UX) Flow
1.  **Viewing & Filtering**: The user arrives at the page and sees a list of cities alongside their parent country tags. A filter panel at the top allows them to select a specific country from a dropdown or type a search string.
2.  **Adding a City**: Clicking "Add City" opens a modal. The user types the city name, selects the parent country from a dynamically populated dropdown, optionally enters a postal code, and saves.
3.  **Editing/Deleting**: Standard table row actions (edit modal, delete confirmation prompt) are provided, identical in UX to the Countries page.

## 5. Required and Optional Inputs
### Create/Edit Form
*   **City Name** (`name` / `edit_name`): **Required**. Type: String. Example: "Berlin".
*   **Country** (`country_id` / `edit_country_id`): **Required**. Type: Integer (Foreign Key pointing to `country.CountryID`). Enforced via HTML `<select>` required attribute.
*   **Postal Code** (`postal_code` / `edit_postal_code`): *Optional*. Type: String.

### Database Output
*   Action: **INSERT / UPDATE / DELETE**
*   Target Table: `city`
*   Mapped Columns: `CityID` (Auto-increment), `Name`, `CountryID`, `PostalCode`.

## 6. Theoretical Example Use Cases
### Example 1: Creating a City linked to a Country
*   **Action**: User adds a city.
*   **Inputs**:
    *   `name`: "Munich"
    *   `country_id`: 1 (Assuming 1 is the ID for Germany)
    *   `postal_code`: "80331"
*   **Processing**: `CityManager->create("Munich", 1, "80331")` executes an `INSERT INTO city (Name, CountryID, PostalCode)` query.
*   **Output**: The row is added. The table view updates, showing "Munich", the Country name ("Germany") fetched via the SQL JOIN, and the postal code.

### Example 2: Filtering by Country
*   **Action**: User selects "Germany" from the filter dropdown and clicks "Filter".
*   **Processing**: The URL updates to `?filter_country=1`. The PHP script reads `$_GET['filter_country']` and passes `1` to `CityManager->listAll(1, null)`. The SQL query appends `AND c.CountryID = 1`.
*   **Output**: The table refreshes to display only rows where the parent country is Germany.

## 7. Scientific Conclusion and Evaluation

**Effectiveness and Implementation Quality:**
The `cities.php` interface successfully demonstrates the management of a one-to-many relationship (Country -> City). The implementation of a dropdown populated by foreign key relations ensures referential integrity at the UI level—users cannot create a city for a non-existent country. The `listAll` method efficiently uses a `LEFT JOIN` to retrieve human-readable country names rather than displaying cryptic Foreign Key integers.

**Areas for Improvement (Research Gap):**
1.  **Postal Code Validation**: The `PostalCode` field accepts any string. Depending on the geographical scope of the MES, implementing regex validation based on the selected country's postal format would improve data quality.
2.  **Cascading Deletion Risks**: If a country is deleted, the database schema dictates what happens to the cities. If `ON DELETE CASCADE` is set on the foreign key in `sql/schema_mariadb.sql`, deleting a country silently deletes all associated cities. If `ON DELETE RESTRICT` is set, it throws an error. The UI does not currently warn the user about potential cascading data loss.
3.  **UI Feedback on Errors**: Similar to `countries.php`, database errors (like a failed foreign key constraint) are swallowed by an empty `catch` block in `CityManager`, resulting in a generic "Error creating city" message. More precise error bubbling would improve the developer and admin experience.

**Main Contributions:**
This page operationalizes the relational database design, moving the system from abstract data storage to a usable interface for defining the physical topology of the manufacturing organization.