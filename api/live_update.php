<?php
require_once '../includes/Config.php';
require_once '../includes/Database.php';

header('Content-Type: application/json');

$orderId = (int)($_GET['order_id'] ?? 0);
$machineId = (int)($_GET['machine_id'] ?? 0);

$response = ['success' => true];

try {
    if ($orderId > 0) {
        $stmtProgress = $pdo->prepare("SELECT ArticleID, ProgressType, CurrentQuantity FROM production_order_progress WHERE OrderID = ?");
        $stmtProgress->execute([$orderId]);
        $response['progress'] = $stmtProgress->fetchAll(PDO::FETCH_ASSOC);

        $stmtRejects = $pdo->prepare("
            SELECT r.Quantity, rr.ReasonName, rc.CategoryName 
            FROM reject r
            JOIN reject_reason rr ON r.ReasonID = rr.ReasonID
            JOIN reject_category rc ON r.CategoryID = rc.CategoryID
            WHERE r.OrderID = ?
            ORDER BY r.RejectDate DESC LIMIT 5
        ");
        $stmtRejects->execute([$orderId]);
        $response['rejects'] = $stmtRejects->fetchAll(PDO::FETCH_ASSOC);
    }

    if ($machineId > 0) {
        $stmtMachine = $pdo->prepare("SELECT Status FROM machine WHERE MachineID = ?");
        $stmtMachine->execute([$machineId]);
        $response['machine_status'] = $stmtMachine->fetchColumn();

        $stmtStop = $pdo->prepare("SELECT StopID, CategoryID FROM machine_stop_log WHERE MachineID = ? AND EndTime IS NULL LIMIT 1");
        $stmtStop->execute([$machineId]);
        $activeStop = $stmtStop->fetch(PDO::FETCH_ASSOC);
        
        $response['has_active_stop'] = $activeStop !== false;
        $response['active_stop_id'] = $activeStop !== false ? $activeStop['StopID'] : null;
        $response['is_unclassified_active'] = $activeStop !== false && empty($activeStop['CategoryID']);

        $stmtUnclassified = $pdo->prepare("SELECT COUNT(*) FROM machine_stop_log WHERE MachineID = ? AND EndTime IS NOT NULL AND (CategoryID IS NULL OR ReasonID IS NULL)");
        $stmtUnclassified->execute([$machineId]);
        $response['unclassified_count'] = (int)$stmtUnclassified->fetchColumn();
    }

    echo json_encode($response);

} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>