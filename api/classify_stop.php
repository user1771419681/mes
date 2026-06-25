<?php
require_once '../includes/Config.php';
require_once '../includes/Database.php';

header('Content-Type: application/json');

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON payload.']);
    exit;
}

$stopId = (int)($input['stop_id'] ?? 0);
$categoryId = (int)($input['category_id'] ?? 0);
$reasonId = (int)($input['reason_id'] ?? 0);
$notes = trim($input['notes'] ?? '');

if ($stopId <= 0 || $categoryId <= 0 || $reasonId <= 0) {
    echo json_encode(['success' => false, 'message' => 'Invalid parameters. Category and Reason are required.']);
    exit;
}

try {
    $stmt = $pdo->prepare("
        UPDATE machine_stop_log 
        SET CategoryID = ?, 
            ReasonID = ?, 
            Notes = CONCAT(COALESCE(Notes, ''), '\n', ?)
        WHERE StopID = ?
    ");
    $stmt->execute([$categoryId, $reasonId, $notes, $stopId]);

    echo json_encode(['success' => true, 'message' => 'Stop classified successfully.']);

} catch (PDOException $e) {
    error_log('API Error (classify_stop.php): ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Database error occurred.']);
}
?>