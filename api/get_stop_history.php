<?php
require_once '../includes/Config.php';
require_once '../includes/Database.php';

header('Content-Type: application/json');

$machineId = isset($_GET['machine_id']) ? (int)$_GET['machine_id'] : 0;

if ($machineId <= 0) {
    echo json_encode([]);
    exit;
}

try {
    $stmt = $pdo->prepare("
        SELECT 
            sl.StopID, 
            sl.StartTime, 
            sl.EndTime, 
            sl.Notes,
            c.CategoryName, 
            r.ReasonName,
            u.OperatorUsername,
            TIMESTAMPDIFF(MINUTE, sl.StartTime, COALESCE(sl.EndTime, NOW())) as DurationMinutes
        FROM machine_stop_log sl
        LEFT JOIN machine_stop_category c ON sl.CategoryID = c.CategoryID
        LEFT JOIN machine_stop_reason r ON sl.ReasonID = r.ReasonID
        LEFT JOIN user u ON sl.OperatorID = u.OperatorID
        WHERE sl.MachineID = ?
        ORDER BY sl.StartTime DESC
        LIMIT 50
    ");
    $stmt->execute([$machineId]);
    $history = $stmt->fetchAll(PDO::FETCH_ASSOC);

    foreach ($history as &$row) {
        $row['StartTimeFormatted'] = date('d/m H:i', strtotime($row['StartTime']));
        $row['EndTimeFormatted'] = $row['EndTime'] ? date('d/m H:i', strtotime($row['EndTime'])) : 'Ongoing';
        $row['IsUnclassified'] = empty($row['CategoryName']) || empty($row['ReasonName']);
    }

    echo json_encode($history);

} catch (PDOException $e) {
    error_log('API Error (get_stop_history.php): ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['error' => 'Database error']);
}
?>