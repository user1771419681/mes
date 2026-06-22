<?php
$siteBaseUrl = "http://localhost:8082/mes/";
define('INCLUDE_PATH', $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/');

$configFilePath = $_SERVER['DOCUMENT_ROOT'] . '/mes/db.properties';

if (file_exists($configFilePath)) {
    $lines = file($configFilePath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    
    foreach ($lines as $line) {
        $line = trim($line);
        
        if (strpos($line, '#') === 0 || strpos($line, ';') === 0) {
            continue;
        }
        
        if (strpos($line, '=') !== false) {
            list($key, $value) = explode('=', $line, 2);
            
            $key = trim($key);
            $value = trim($value);
            
            $value = trim($value, "\"'");
            
            if (!defined($key)) {
                define($key, $value);
            }
        }
    }
} else {
    error_log("Critical Error: Database configuration file missing at " . $configFilePath);
    header('Content-Type: application/json');
    http_response_code(500);
    die(json_encode(['status' => 'error', 'message' => 'Server configuration error']));
}
?>