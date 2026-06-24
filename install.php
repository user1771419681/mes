<?php
$message = '';
$status = '';
$showUploadForm = false;

$configFilePath = $_SERVER['DOCUMENT_ROOT'] . '/mes/db.properties';
$db_host = 'localhost';
$db_name = 'mes';
$db_user = 'root';
$db_pass = '';

if (file_exists($configFilePath)) {
    $lines = file($configFilePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        $line = trim($line);
        if (empty($line) || strpos($line, '#') === 0 || strpos($line, ';') === 0) {
            continue;
        }
        if (strpos($line, '=') !== false) {
            list($key, $value) = explode('=', $line, 2);
            $key = strtoupper(trim($key));
            $value = trim(trim($value), "\"'");
            
            // Intelligently map properties regardless of specific casing or prefix styles
            if (strpos($key, 'HOST') !== false) {
                $db_host = $value;
            } elseif (strpos($key, 'NAME') !== false || $key === 'DB' || $key === 'DATABASE') {
                $db_name = $value;
            } elseif (strpos($key, 'USER') !== false) {
                $db_user = $value;
            } elseif (strpos($key, 'PASS') !== false) {
                $db_pass = $value;
            }
        }
    }
} else {
    $message = "Warning: Configuration property file not found at $configFilePath. Falling back to internal defaults.";
    $status = 'warning';
}

function executeSqlFile($host, $user, $pass, $dbname, $sqlContent) {
    try {
        $pdo = new PDO("mysql:host=$host", $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"
        ]);

        if (!empty($dbname)) {
            $pdo->exec("CREATE DATABASE IF NOT EXISTS `$dbname` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
            $pdo->exec("USE `$dbname`");
        }

        $pdo->exec("SET FOREIGN_KEY_CHECKS = 0;");
        
        $pdo->exec($sqlContent);
        
        $pdo->exec("SET FOREIGN_KEY_CHECKS = 1;");
        return ['status' => 'success', 'message' => 'Database environment constructed and populated successfully!'];
    } catch (PDOException $e) {
        return ['status' => 'error', 'message' => 'Database execution failed: ' . $e->getMessage()];
    }
}

$defaultSqlPath = __DIR__ . '/install.sql';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['sql_file'])) {
    if ($_FILES['sql_file']['error'] === UPLOAD_ERR_OK) {
        $sqlContent = file_get_contents($_FILES['sql_file']['tmp_name']);
        $res = executeSqlFile($db_host, $db_user, $db_pass, $db_name, $sqlContent);
        $status = $res['status'];
        $message = $res['message'];
    } else {
        $status = 'error';
        $message = 'Error handling file upload. Please attempt operation again.';
        $showUploadForm = true;
    }
} else {
    if (file_exists($defaultSqlPath)) {
        $sqlContent = file_get_contents($defaultSqlPath);
        $res = executeSqlFile($db_host, $db_user, $db_pass, $db_name, $sqlContent);
        $status = $res['status'];
        $message = "Automated setup triggered via 'install.sql'. " . $res['message'];
    } else {
        $showUploadForm = true;
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MES Automated Schema Installer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow border-0">
                    <div class="card-header bg-dark text-white py-3">
                        <h5 class="mb-0">MES Target Schema Deployment Tool</h5>
                    </div>
                    <div class="card-body p-4">
                        <?php if ($message): ?>
                            <div class="alert alert-<?= $status === 'success' ? 'success' : ($status === 'warning' ? 'warning' : 'danger') ?> mb-4">
                                <?= htmlspecialchars($message) ?>
                            </div>
                        <?php endif; ?>

                        <?php if ($showUploadForm): ?>
                            <div class="alert alert-info py-2 small">
                                Default <code>install.sql</code> asset structural dump was not discovered inside runtime directory. Please supply an external source file.
                            </div>
                            <form method="post" enctype="multipart/form-data" class="mt-3">
                                <div class="mb-4">
                                    <label class="form-label fw-bold text-secondary">Select SQL Structural Backup File</label>
                                    <input type="file" name="sql_file" class="form-control" accept=".sql" required>
                                    <div class="form-text text-muted">Supports raw relational exports including constraints, structures, and dataset rows.</div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 py-2">Execute Target SQL File</button>
                            </form>
                        <?php else: ?>
                            <?php if ($status === 'success'): ?>
                                <div class="text-center py-2">
                                    <p class="text-muted small">Environment successfully mapped to host target <strong><?= htmlspecialchars($db_host) ?></strong></p>
                                    <a href="index.php" class="btn btn-outline-success px-4">Enter Application Workspace</a>
                                </div>
                            <?php endif; ?>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>