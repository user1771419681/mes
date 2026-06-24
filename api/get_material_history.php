<?php
require_once '../includes/Config.php';
require_once '../includes/Database.php';

header('Content-Type: application/json');

$orderId   = isset($_GET['order']) ? (int)$_GET['order'] : 0;
$articleId = isset($_GET['article']) ? (int)$_GET['article'] : 0;

if ($orderId <= 0 || $articleId <= 0) {
    echo json_encode([]);
    exit;
}

try {
    // Fetch logs specific to this order and this raw material article
    $stmt = $pdo->prepare("
        SELECT 
            r.BatchCode, 
            r.Quantity, 
            DATE_FORMAT(r.ScanTime, '%d/%m/%Y %H:%i') as ScanTime, 
            u.OperatorUsername
        FROM raw_material_log r
        LEFT JOIN user u ON r.OperatorID = u.OperatorID
        WHERE r.ProductionOrderID = ? 
          AND r.ArticleID = ?
        ORDER BY r.ScanTime DESC
        LIMIT 50
    ");
    
    $stmt->execute([$orderId, $articleId]);
    $history = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($history);

} catch (PDOException $e) {
    error_log('API Error (get_material_history.php): ' . $e->getMessage());
    
    http_response_code(500);
    echo json_encode(['error' => 'An internal database error occurred.']);
}
?>