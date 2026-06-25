<?php
require_once '../includes/Config.php';
require_once '../includes/Database.php';

header('Content-Type: application/json');

$orderId   = isset($_GET['order']) ? (int)$_GET['order'] : 0;
$articleId = isset($_GET['article']) ? (int)$_GET['article'] : 0;

if ($orderId <= 0 || $articleId <= 0) {
    echo json_encode([]); exit;
}

try {
    $stmt = $pdo->prepare("
        SELECT 
            b.BatchCode, 
            b.Quantity, 
            DATE_FORMAT(b.PrintTime, '%d/%m/%Y %H:%i') as PrintTime, 
            u.OperatorUsername
        FROM batch_log b
        LEFT JOIN user u ON b.OperatorID = u.OperatorID
        WHERE b.ProductionOrderID = ? AND b.ArticleID = ?
        ORDER BY b.PrintTime DESC
        LIMIT 50
    ");
    $stmt->execute([$orderId, $articleId]);
    echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database error']);
}
?>