<?php
session_start();

require_once '../includes/Config.php';
require_once '../includes/Database.php';
require_once '../includes/OperatorLogsManager.php';

header('Content-Type: application/json');

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON payload.']);
    exit;
}

$machineId  = (int)($input['machine_id'] ?? 0);
$stopId     = (int)($input['stop_id'] ?? 0); // Will be 0 if creating a new stop
$orderId    = (int)($input['order_id'] ?? 0);
$categoryId = (int)($input['category_id'] ?? 0);
$reasonId   = (int)($input['reason_id'] ?? 0);
$notes      = trim($input['notes'] ?? '');

if ($machineId <= 0 || $categoryId <= 0 || $reasonId <= 0) {
    echo json_encode(['success' => false, 'message' => 'Machine, Category, and Reason are required.']);
    exit;
}

try {
    $opManager = new OperatorLogsManager($pdo);
    $activeOps = $opManager->getActiveOperators($machineId);
    $operatorId = !empty($activeOps) ? (int)$activeOps[0]['OperatorID'] : 1; 

    if ($stopId > 0) {
        $stmt = $pdo->prepare("
            UPDATE machine_stop_log 
            SET CategoryID = ?, 
                ReasonID = ?, 
                Notes = CASE WHEN Notes IS NULL OR Notes = '' THEN ? ELSE CONCAT(Notes, '\n', ?) END
            WHERE StopID = ?
        ");
        $stmt->execute([$categoryId, $reasonId, $notes, $notes, $stopId]);
        $message = "Stop updated and classified successfully.";
    } else {
        $stmt = $pdo->prepare("
            INSERT INTO machine_stop_log (MachineID, OperatorID, ProductionOrderID, CategoryID, ReasonID, StartTime, Notes)
            VALUES (?, ?, ?, ?, ?, NOW(), ?)
        ");
        $finalOrderId = $orderId > 0 ? $orderId : null;
        $stmt->execute([$machineId, $operatorId, $finalOrderId, $categoryId, $reasonId, $notes]);
        $message = "Machine stop registered successfully.";
    }

    echo json_encode(['success' => true, 'message' => $message]);

} catch (PDOException $e) {
    error_log('API Error (manage_stop.php): ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Database error occurred.']);
}
?>