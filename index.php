<?php
if (!file_exists(__DIR__ . '/includes/Database.php')) {
    header('Location: install.php');
    exit;
}

require_once __DIR__ . '/includes/Database.php';

// --- DATABASE AUTO-HEAL START ---
$sqlFile = __DIR__ . '/sql/schema_mariadb.sql'; 

if (file_exists($sqlFile) && isset($pdo)) {
    try {
        $stmt = $pdo->query("SHOW TABLES");
        $existingTables = $stmt->fetchAll(PDO::FETCH_COLUMN);
        
        $sqlContent = file_get_contents($sqlFile);
        preg_match_all('/CREATE TABLE (IF NOT EXISTS )?`([a-zA-Z0-9_]+)`/i', $sqlContent, $matches);
        $requiredTables = $matches[2] ?? [];
        
        $missingTables = array_diff($requiredTables, $existingTables);
        
        if (!empty($missingTables)) {
            $pdo->exec("SET FOREIGN_KEY_CHECKS = 0;");
            
            $lines = file($sqlFile);
            $query = '';
            
            foreach ($lines as $line) {
                $trimLine = trim($line);
                
                if (empty($trimLine) || strpos($trimLine, '--') === 0 || strpos($trimLine, '/*') === 0) {
                    continue;
                }
                
                $query .= $line;
                
                if (substr(rtrim($query), -1) === ';') {
                    $execute = false;
                    
                    if (preg_match('/CREATE TABLE `([a-zA-Z0-9_]+)`/i', $query, $match)) {
                        if (in_array($match[1], $missingTables)) $execute = true;
                    } 
                    elseif (preg_match('/ALTER TABLE `([a-zA-Z0-9_]+)`/i', $query, $match)) {
                        if (in_array($match[1], $missingTables)) $execute = true;
                    }
                    
                    if ($execute) {
                        $pdo->exec($query);
                    }
                    
                    $query = ''; 
                }
            }
            $pdo->exec("SET FOREIGN_KEY_CHECKS = 1;");
        }
    } catch (PDOException $e) {
        error_log("Auto-heal database error: " . $e->getMessage());
    }
}
// --- DATABASE AUTO-HEAL END ---

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