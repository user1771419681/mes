<?php
if (!file_exists(__DIR__ . '/includes/Database.php')) {
    header('Location: install.php');
    exit;
}

require_once __DIR__ . '/includes/Database.php';
$sqlFile = __DIR__ . '/sql/schema_mariadb.sql'; 

if (file_exists($sqlFile) && isset($pdo)) {
    try {
        $stmt = $pdo->query("SHOW TABLES");
        $existingTables = $stmt->fetchAll(PDO::FETCH_COLUMN);
        
        $sqlContent = file_get_contents($sqlFile);
        preg_match_all('/CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?\`?([a-zA-Z0-9_]+)\`?/i', $sqlContent, $matches);
        $requiredTables = $matches[1] ?? [];
        
        $missingTables = array_diff($requiredTables, $existingTables);
        
        if (!empty($missingTables)) {
            error_log("[MES-Check] Tabele lipsă detectate: " . implode(', ', $missingTables));
            header('Location: install.php?action=heal');
            exit;
        }
    } catch (PDOException $e) {
        error_log("[MES-Check] Eroare Bază de date (Posibil ștearsă complet): " . $e->getMessage());
        header('Location: install.php?action=heal');
        exit;
    }
} else {
    error_log("[MES-Check] Avertisment: schema_mariadb.sql lipsește sau \$pdo nu e setat.");
}
// --- CHECK DEPENDENCIES END ---

session_start();

if (isset($_SESSION['user_id'])) {
    $roles = explode(';', $_SESSION['roles']);
    if (in_array('admin', $roles)) {
        header('Location: dashboard.php');
        exit;
    }
} else {
    header('Location: login.php');
    exit;
}
?>