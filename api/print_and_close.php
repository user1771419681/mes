<?php
require_once '../includes/Config.php';
require_once '../includes/Database.php';
require_once '../includes/OperatorLogsManager.php';
require_once '../includes/ProductionLogsManager.php';

header('Content-Type: application/json');

$input = json_decode(file_get_contents('php://input'), true);
$orderId = (int)($input['order_id'] ?? 0);
$articleId = (int)($input['article_id'] ?? 0);
$qty = (float)($input['qty'] ?? 0);

if ($orderId <= 0 || $articleId <= 0) {
    echo json_encode(['success' => false, 'message' => 'Invalid parameters.']);
    exit;
}

try {
    $pdo->beginTransaction();

    $stmtMachine = $pdo->prepare("SELECT pr.MachineID FROM production_order po JOIN production_recipes pr ON po.RecipeID = pr.RecipeID WHERE po.OrderID = ?");
    $stmtMachine->execute([$orderId]);
    $machineId = (int)$stmtMachine->fetchColumn();

    $opManager = new OperatorLogsManager($pdo);
    $activeOps = $opManager->getActiveOperators($machineId);
    if (empty($activeOps)) {
        throw new Exception("No active operator logged in. Please log in first.");
    }
    $operatorId = (int)$activeOps[0]['OperatorID'];

    $batchCode = "FINAL-" . date('Ymd') . "-O" . $orderId;

    if ($qty > 0) {
        $stmtInsert = $pdo->prepare("
            INSERT INTO batch_log (BatchCode, BatchType, ProductionOrderID, ArticleID, OperatorID, MachineID, Quantity)
            VALUES (?, 'Finished Product', ?, ?, ?, ?, ?)
        ");
        $stmtInsert->execute([$batchCode, $orderId, $articleId, $operatorId, $machineId, $qty]);

        $stmtUpdate = $pdo->prepare("UPDATE production_order_progress SET CurrentQuantity = CurrentQuantity - ? WHERE OrderID = ? AND ArticleID = ? AND ProgressType = 'Output'");
        $stmtUpdate->execute([$qty, $orderId, $articleId]);
    } else {
        $batchCode = "No units printed (Qty was 0).";
    }

    $logManager = new ProductionLogsManager($pdo);
    $stmtLog = $pdo->prepare("SELECT LogID FROM production_log WHERE ProductionOrderID = ? AND Status = 'Active' LIMIT 1");
    $stmtLog->execute([$orderId]);
    $activeLog = $stmtLog->fetch(PDO::FETCH_ASSOC);

    if ($activeLog) {
        $logManager->stopLog($activeLog['LogID'], $operatorId, date('Y-m-d H:i:s'), 0.0);
    }

    $updOrder = $pdo->prepare("UPDATE production_order SET Status = 'Closed', ActualEndDate = NOW() WHERE OrderID = ?");
    $updOrder->execute([$orderId]);

    $pdo->commit();
    echo json_encode(['success' => true, 'batch_code' => $batchCode]);

} catch (Exception $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>