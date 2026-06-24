<?php
session_start();

require_once '../includes/Config.php';
require_once '../includes/Database.php';
require_once '../includes/RawMaterialManager.php';
require_once '../includes/OperatorLogsManager.php';

header('Content-Type: application/json');

// 1. Parse JSON Payload
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON payload.']);
    exit;
}

$orderId   = (int)($input['order_id'] ?? 0);
$articleId = (int)($input['article_id'] ?? 0);
$batchCode = trim($input['batch_code'] ?? '');
$quantity  = (float)($input['quantity'] ?? 0);

// 2. Validate Inputs
if ($orderId <= 0 || $articleId <= 0 || empty($batchCode) || $quantity <= 0) {
    echo json_encode(['success' => false, 'message' => 'Invalid inputs. Ensure all fields are filled properly.']);
    exit;
}

try {
    $pdo->beginTransaction();

    // 3. Find MachineID associated with this Order
    $stmtMachine = $pdo->prepare("
        SELECT pr.MachineID 
        FROM production_order po 
        JOIN production_recipes pr ON po.RecipeID = pr.RecipeID 
        WHERE po.OrderID = ?
    ");
    $stmtMachine->execute([$orderId]);
    $machineId = (int)$stmtMachine->fetchColumn();

    if (!$machineId) {
        throw new Exception("Could not resolve machine for this order.");
    }

    // 4. Find the Active Operator on this Machine
    $opManager = new OperatorLogsManager($pdo);
    $activeOps = $opManager->getActiveOperators($machineId);
    
    if (empty($activeOps)) {
        throw new Exception("No active operator found. Please log in to the machine first.");
    }
    
    // Default to the first logged-in operator if multiple exist
    $operatorId = (int)$activeOps[0]['OperatorID'];

    // 5. Create Raw Material Log
    $rmManager = new RawMaterialManager($pdo);
    $logCreated = $rmManager->createLog(
        $orderId, 
        $operatorId, 
        $batchCode, 
        $articleId, 
        $machineId, 
        $quantity, 
        null, // ScanTime (Defaults to NOW)
        "Scanned via Totem UI"
    );

    if (!$logCreated) {
        throw new Exception("Failed to save material log. Batch code might be a duplicate.");
    }

    // 6. Update the Production Order Progress Buffer (Upsert)
    // We add the scanned quantity to the CurrentQuantity for 'Input' types.
    $stmtProgress = $pdo->prepare("
        INSERT INTO production_order_progress (OrderID, ArticleID, ProgressType, CurrentQuantity)
        VALUES (?, ?, 'Input', ?)
        ON DUPLICATE KEY UPDATE CurrentQuantity = CurrentQuantity + VALUES(CurrentQuantity)
    ");
    $stmtProgress->execute([$orderId, $articleId, $quantity]);

    $pdo->commit();

    echo json_encode(['success' => true, 'message' => 'Material registered successfully.']);

} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    error_log('API Error (scan_material.php): ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>