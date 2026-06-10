<?php
require_once '../includes/Config.php';
require_once '../includes/Database.php';
require_once '../includes/AdjustmentManager.php';

header('Content-Type: application/json');

try {
    $manager = new AdjustmentManager($pdo);

    $action = $_REQUEST['action'] ?? '';

    switch ($action) {
        case 'create':
            $orderId = isset($_POST['order_id']) ? (int)$_POST['order_id'] : 0;
            $articleId = isset($_POST['article_id']) ? (int)$_POST['article_id'] : 0;
            $quantity = isset($_POST['quantity']) ? (int)$_POST['quantity'] : 0;

            if ($manager->createAdjustment($orderId, $articleId, $quantity)) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Failed to create adjustment']);
            }
            break;

        case 'update':
            $id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
            $orderId = !empty($_POST['order_id']) ? (int)$_POST['order_id'] : null;
            $articleId = !empty($_POST['article_id']) ? (int)$_POST['article_id'] : null;
            $quantity = isset($_POST['quantity']) ? (int)$_POST['quantity'] : null;

            if ($manager->updateAdjustment($id, $orderId, $articleId, $quantity)) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Failed to update adjustment']);
            }
            break;

        case 'delete':
            $id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
            if ($manager->deleteAdjustment($id)) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Failed to delete adjustment']);
            }
            break;

        case 'get':
            $id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
            $adjustment = $manager->getAdjustmentById($id);
            if ($adjustment) {
                echo json_encode(['status' => 'success', 'data' => $adjustment]);
            } else {
                http_response_code(404);
                echo json_encode(['status' => 'error', 'message' => 'Adjustment not found']);
            }
            break;

        case 'list':
            $adjustments = $manager->listAdjustments();
            echo json_encode(['status' => 'success', 'data' => $adjustments]);
            break;

        default:
            http_response_code(400);
            echo json_encode(['status' => 'error', 'message' => 'Invalid action']);
            break;
    }
} catch (Exception $e) {
    error_log('API Error: ' . $e->getMessage());
    
    http_response_code(500);
    echo json_encode(['status' => 'error', 'message' => 'An internal server error occurred']);
}
?>