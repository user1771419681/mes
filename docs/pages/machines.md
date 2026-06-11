# Documentation: `pages/database/machines.php`

## 1. Overview and Objectives
The `machines.php` page is a critical component of the MES backoffice, acting as the primary asset registry. It manages the lifecycle and physical placement of manufacturing machines within the factory hierarchy (Plant -> Section). Due to the high volume of machines expected in an enterprise environment, this page employs advanced frontend techniques (DataTables, AJAX) for efficient data rendering and filtering.

## 2. Use Cases
*   **Asset Commissioning**: An engineer adds a newly purchased CNC machine to the system, assigning it to "Plant A", "Milling Section", and setting its theoretical production capacity.
*   **Maintenance Tracking**: A manager updates the "Last Maintenance Date" after a scheduled service.
*   **Status Management**: An administrator changes a machine's status from "Active" to "Maintenance" or "Inactive", which impacts downstream production planning availability.
*   **Asset Relocation**: A machine is physically moved to a different section; the admin updates its `SectionID` and grid location.

## 3. Program Flow & Logic
1.  **Backend Initialization**: The script verifies admin rights and instantiates necessary managers (`MachineManager`, `CountryManager`, `PlantManager`, `SectionManager`). It pre-fetches lists of Countries, Plants, and Sections to populate the "Add/Edit" modal `<select>` dropdowns.
2.  **POST Request Handling (CRUD)**:
    *   **Create**: Receives form data. `Capacity` is validated within `MachineManager::createMachine()` to ensure it is `> 0`. Name, Location, and Model must not be empty. Calls the manager to insert.
    *   **Edit/Delete**: Standard routing to update or remove records via `MachineManager`.
3.  **Frontend Rendering & AJAX Data Loading**:
    *   Unlike the Countries/Cities pages which render HTML table rows via a PHP `foreach` loop, `machines.php` renders an empty table skeleton.
    *   **DataTables Initialization**: On `$(document).ready()`, jQuery DataTables is initialized. It makes an asynchronous AJAX `GET` request to `api/machines-fetch.php` to retrieve the entire machine list as a JSON payload.
    *   **Dynamic UI**: The table is populated client-side. The "Status" column is dynamically styled with Bootstrap badges based on the string value (Active = green, Inactive = gray, Maintenance = yellow).
4.  **Cascading Dropdown Flow**:
    *   The page features filter dropdowns for Country, City, Plant, and Section.
    *   When a user changes a selection, the `updateCascadingOptions()` JS function fires.
    *   It sends an AJAX request to `api/get-filter-options.php` with the currently selected parameters. The API returns JSON containing valid sub-categories based on the relational hierarchy.
    *   The JS dynamically rebuilds the `<option>` elements of the subsequent dropdowns.

## 4. User Experience (UX) Flow
1.  **Initial Load**: The page loads instantly with the skeleton UI. A brief loading indicator may appear while DataTables fetches the JSON payload.
2.  **Searching**: The user types "Lathe" into the global search bar. DataTables filters the view instantaneously client-side without a page reload.
3.  **Hierarchical Filtering**: The user selects "Germany" from the Country filter. The City dropdown dynamically updates to only show cities in Germany. They select "Berlin", and the Plant dropdown updates. The table filters down to machines matching these parameters.
4.  **Inline Data Binding (Edit)**: When clicking the "Edit" button, the JS parses a JSON string embedded in the button's `data-row` attribute, instantaneously populating the edit modal fields without requiring an additional database trip.

## 5. Required and Optional Inputs
### Create/Edit Form
*   **Name** (`name`): **Required**. String. e.g., "CNC Lathe #04".
*   **Model** (`model`): **Required**. String. e.g., "Haas ST-20".
*   **Location** (`location`): **Required**. String. (Physical grid/bay). e.g., "Bay 4-B".
*   **Capacity** (`capacity`): **Required**. Float. Must be > 0. (e.g., units per hour).
*   **Status** (`status`): **Required**. Enum-like string ('Active', 'Inactive', 'Maintenance').
*   **Plant** (`plant_id`): *Optional* (can be null). Integer.
*   **Section** (`section_id`): *Optional* (can be null). Integer.
*   **Last Maintenance** (`last_maintenance_date`): *Optional*. Date string (YYYY-MM-DD).

### Database Output
*   Target Table: `machine`

## 6. Theoretical Example Use Cases
### Example 1: Creating a Machine
*   **Inputs**: Name: "Press A", Model: "StampMaster", Location: "Floor 1", Capacity: 500, Status: "Active", PlantID: 2, SectionID: 5.
*   **Processing**: `MachineManager->createMachine()` validates that Capacity > 0. Inserts into the database.
*   **Output**: A new row in `machine`. Upon page reload, DataTables fetches the updated JSON and displays the new machine with a green "Active" badge.

### Example 2: Client-Side AJAX Failure
*   **Action**: A user attempts to view the page, but their API session token has expired.
*   **Processing**: DataTables makes the AJAX request to `api/machines-fetch.php`. The server responds with a `401 Unauthorized` HTTP status.
*   **Output**: The JS `error.dt` event handler intercepts the 401 error. Instead of a standard browser alert, it un-hides the `#apiErrorAlert` banner ("Access Denied: Unable to fetch data...") and dims the table, prompting the user to log in again.

## 7. Scientific Conclusion and Evaluation

**Effectiveness and Implementation Quality:**
The `machines.php` page represents a significant architectural leap over the basic PHP loop rendering seen in the Countries and Cities pages. By decoupling the data fetching (`api/machines-fetch.php`) from the view rendering, the application achieves a modern, Single-Page Application (SPA) feel. Client-side filtering via DataTables drastically reduces server load during search operations. The implementation of cascading AJAX filters demonstrates a sophisticated approach to handling deeply nested relational hierarchies (Country -> City -> Plant -> Section).

**Areas for Improvement (Research Gap):**
1.  **Client-Side Data Volume**: While DataTables is fast, currently `api/machines-fetch.php` likely returns *all* machines in a single payload. If the factory scales to tens of thousands of assets, this initial JSON payload will become massive, increasing memory usage and load times. Transitioning DataTables to `serverSide: true` processing—where sorting, filtering, and pagination are handled by SQL `LIMIT` and `OFFSET` queries—would be required for enterprise-scale deployments.
2.  **Relational Integrity on Edit**: The edit modal allows changing the `PlantID` and `SectionID` independently. Because Sections belong to specific Plants, a user could theoretically assign a machine to "Plant A" but select a Section that physically resides in "Plant B". The UI does not currently enforce cascading validation *within the edit modal itself*, relying entirely on the user's correct selection.
3.  **Audit Trail**: Machines are critical assets. Changing a machine's capacity or status affects production planning. Currently, updates overwrite the previous state without keeping a historical ledger of changes. Implementing an audit log table for critical asset modifications would enhance traceability.

**Main Contributions:**
This page successfully integrates complex backend relational structures with a highly responsive, API-driven frontend interface. It proves the system's capability to handle complex, multi-tiered asset management scenarios required by industrial environments.