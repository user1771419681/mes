<?php
session_start();

require_once '../includes/Config.php';
require_once '../includes/Database.php';
require_once '../includes/ProductionOrderManager.php';
require_once '../includes/ProductionLogsManager.php';
require_once '../includes/OperatorLogsManager.php'; // Required to check active operators

header('Content-Type: application/json');

// 1. Parse the JSON Payload
$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON payload.']);
    exit;
}

$action = $input['action'] ?? '';
$orderId = (int)($input['order_id'] ?? 0);
$notes = trim($input['notes'] ?? '');

// 2. Validate Inputs
if ($orderId <= 0 || !in_array($action, ['finish', 'suspend'])) {
    echo json_encode(['success' => false, 'message' => 'Invalid action or missing Order ID.']);
    exit;
}

try {
    // Begin transaction
    $pdo->beginTransaction();

    $poManager = new ProductionOrderManager($pdo);
    $logManager = new ProductionLogsManager($pdo);
    $opManager = new OperatorLogsManager($pdo);

    // 3. Verify the Order Exists
    $order = $poManager->getOrderById($orderId);
    if (!$order) {
        throw new Exception("Production order #{$orderId} not found.");
    }

    // 4. Find the Active Production Log to get MachineID and Operator info
    $stmt = $pdo->prepare("
        SELECT LogID, Notes, MachineID, StartOperatorID 
        FROM production_log 
        WHERE ProductionOrderID = ? AND Status = 'Active' 
        LIMIT 1
    ");
    $stmt->execute([$orderId]);
    $activeLog = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($activeLog) {
        $machineId = (int)$activeLog['MachineID'];
        $startOpId = (int)$activeLog['StartOperatorID'];
        $logId = (int)$activeLog['LogID'];
        $existingNotes = $activeLog['Notes'];
        
        // 5. Verify at least one operator is logged into this machine
        $activeOps = $opManager->getActiveOperators($machineId);
        if (empty($activeOps)) {
            throw new Exception("Unauthorized. No operators are currently logged into this machine.");
        }

        // 6. Attribute the action: Prefer the operator who started it, else pick the first logged in
        $operatorId = (int)$activeOps[0]['OperatorID'];
        foreach ($activeOps as $op) {
            if ((int)$op['OperatorID'] === $startOpId) {
                $operatorId = $startOpId;
                break;
            }
        }

        // 7. Stop the log and update notes
        $newLogNotes = $existingNotes;
        if (!empty($notes)) {
            $prefix = "\n[" . date('Y-m-d H:i:s') . " - " . ucfirst($action) . "]: ";
            $newLogNotes = $existingNotes ? $existingNotes . $prefix . $notes : $prefix . $notes;
        }

        $endTime = date('Y-m-d H:i:s');
        
        $logManager->stopLog($logId, $operatorId, $endTime, 0.0);

        if (!empty($notes)) {
            $updNotes = $pdo->prepare("UPDATE production_log SET Notes = ? WHERE LogID = ?");
            $updNotes->execute([$newLogNotes, $logId]);
        }
    } else {
        // Fallback: If no active log is found, ensure someone is logged in before updating order status
        $stmtMachine = $pdo->prepare("SELECT MachineID FROM production_recipes WHERE RecipeID = ?");
        $stmtMachine->execute([$order['RecipeID']]);
        $machineId = (int)$stmtMachine->fetchColumn();

        if ($machineId > 0) {
            $activeOps = $opManager->getActiveOperators($machineId);
            if (empty($activeOps)) {
                throw new Exception("Unauthorized. No operators are currently logged into this machine.");
            }
        }
    }

    // 8. Update the Production Order Status
    $newStatus = ($action === 'finish') ? 'Closed' : 'Suspended';
    $actualEndDate = ($action === 'finish') ? date('Y-m-d H:i:s') : null;

    $updOrder = $pdo->prepare("
        UPDATE production_order 
        SET Status = ?, 
            ActualEndDate = COALESCE(ActualEndDate, ?) 
        WHERE OrderID = ?
    ");
    $updOrder->execute([$newStatus, $actualEndDate, $orderId]);

    // 9. Commit changes
    $pdo->commit();

    echo json_encode([
        'success' => true, 
        'message' => "Order successfully " . ($action === 'finish' ? 'finished' : 'suspended') . "."
    ]);

} catch (Exception $e) {
    // Rollback changes on failure
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    
    error_log('API Error (order_action.php): ' . $e->getMessage());
    echo json_encode([
        'success' => false, 
        'message' => $e->getMessage()
    ]);
}
?>