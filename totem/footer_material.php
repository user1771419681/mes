<?php
// Fetch inputs for the current active recipe if one exists
$materialInputs = [];
if (isset($activeOrder) && $activeOrder) {
    // Join recipe_inputs with the production_order_progress table specifically for 'Input' types
    $stmt = $pdo->prepare("
        SELECT 
            ri.ArticleID, 
            ri.Quantity as RecipeMultiplier, 
            ri.Unit, 
            ri.InputType, 
            a.Name as ArticleName,
            COALESCE(pop.CurrentQuantity, 0) as CurrentQuantity
        FROM recipe_inputs ri
        JOIN article a ON ri.ArticleID = a.ArticleID
        LEFT JOIN production_order_progress pop 
            ON ri.ArticleID = pop.ArticleID 
            AND pop.OrderID = ?
            AND pop.ProgressType = 'Input'
        WHERE ri.RecipeID = ?
        ORDER BY ri.InputType ASC, a.Name ASC
    ");
    $stmt->execute([$activeOrder['OrderID'], $activeOrder['RecipeID']]);
    $materialInputs = $stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>

<style>
    @keyframes flashWarning {
        0% { background-color: #fee2e2; border-color: #ef4444; color: #b91c1c; }
        50% { background-color: #fef08a; border-color: #eab308; color: #a16207; }
        100% { background-color: #fee2e2; border-color: #ef4444; color: #b91c1c; }
    }
    .material-negative {
        animation: flashWarning 1s infinite;
        border-width: 2px !important;
    }
</style>

<div class="card border-0 shadow-sm h-100">
    <div class="card-header bg-secondary text-white d-flex align-items-center">
        <i class="fa-solid fa-boxes-packing me-2"></i>
        <h5 class="card-title mb-0">Raw Materials</h5>
    </div>
    <div class="card-body overflow-auto" style="max-height: 400px;">
        <?php if (!$activeOrder): ?>
            <div class="alert alert-secondary text-center">
                <i class="fa-solid fa-power-off mb-2 fs-4 block"></i><br>
                No active production order.
            </div>
        <?php elseif (empty($materialInputs)): ?>
            <div class="alert alert-warning text-center">
                <i class="fa-solid fa-triangle-exclamation mb-2 fs-4 block"></i><br>
                No inputs defined for this recipe.
            </div>
        <?php else: ?>
            <?php foreach ($materialInputs as $inp): 
                $qty = (float)$inp['CurrentQuantity'];
                $isNegative = $qty < 0;
                $boxClass = $isNegative ? 'material-negative' : 'border-secondary bg-white text-dark';
            ?>
                <div id="box-input-<?= $inp['ArticleID'] ?>" class="output-block border rounded p-3 mb-3 <?= $boxClass ?>">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0 fw-bold">
                            <?= htmlspecialchars($inp['ArticleName']) ?>
                            <?php 
                                $badgeClass = match($inp['InputType']) {
                                    'consumable' => 'bg-warning text-dark',
                                    'resource' => 'bg-info text-dark',
                                    default => 'bg-secondary'
                                };
                            ?>
                            <span class="badge <?= $badgeClass ?> ms-1"><?= ucfirst($inp['InputType']) ?></span>
                        </h6>
                        <span class="fw-bold fs-5">
                            <span id="qty-input-<?= $inp['ArticleID'] ?>"><?= number_format($qty, 2) ?></span> 
                            <span class="fs-6 text-muted fw-normal"><?= htmlspecialchars($inp['Unit']) ?></span>
                        </span>
                    </div>

                    <div class="d-flex gap-2">
                        <button class="btn <?= $isNegative ? 'btn-danger' : 'btn-primary' ?> flex-fill btn-scan-material" 
                                data-order="<?= $activeOrder['OrderID'] ?>" 
                                data-article="<?= $inp['ArticleID'] ?>"
                                data-articlename="<?= htmlspecialchars($inp['ArticleName']) ?>">
                            <i class="fa-solid fa-barcode me-1"></i> Scan Batch
                        </button>
                        
                        <button class="btn <?= $isNegative ? 'btn-outline-danger' : 'btn-outline-secondary' ?> flex-fill btn-material-history" 
                                data-order="<?= $activeOrder['OrderID'] ?>" 
                                data-article="<?= $inp['ArticleID'] ?>"
                                data-articlename="<?= htmlspecialchars($inp['ArticleName']) ?>">
                            <i class="fa-solid fa-clock-rotate-left me-1"></i> History
                        </button>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</div>

<div class="modal fade" id="scanMaterialModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold">
                    <i class="fa-solid fa-barcode me-2"></i> 
                    Scan Material: <span id="scanModalArticleName"></span>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4 text-center">
                <p class="text-muted mb-4">Use the USB scanner or type the batch code below and press Enter.</p>
                <form id="scanMaterialForm" onsubmit="return false;">
                    <input type="hidden" id="scanOrderId" value="">
                    <input type="hidden" id="scanArticleId" value="">
                    
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control form-control-lg text-center fw-bold" id="scanBatchCode" placeholder="Batch Code" autocomplete="off" required>
                        <label for="scanBatchCode">Batch Code</label>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <input type="number" step="0.0001" class="form-control text-center" id="scanQuantity" value="1" placeholder="Quantity" required>
                        <label for="scanQuantity">Quantity Inserted</label>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg w-100 mt-2" id="btnSubmitScan">Register Material</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="materialHistoryModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold">
                    <i class="fa-solid fa-clock-rotate-left me-2 text-secondary"></i> 
                    Scan History: <span id="historyModalArticleName" class="text-secondary"></span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>Batch Code</th>
                                <th>Quantity Scanned</th>
                                <th>Operator</th>
                                <th>Scan Time</th>
                            </tr>
                        </thead>
                        <tbody id="materialHistoryTableBody">
                            <tr><td colspan="4" class="text-center py-4 text-muted"><i class="fa-solid fa-spinner fa-spin me-2"></i> Loading...</td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {

    const scanMaterialModalEl = document.getElementById('scanMaterialModal');
    let scanModalInstance = null;
    if (scanMaterialModalEl) {
        scanModalInstance = new bootstrap.Modal(scanMaterialModalEl);
        
        document.querySelectorAll('.btn-scan-material').forEach(btn => {
            btn.addEventListener('click', function() {
                document.getElementById('scanOrderId').value = this.dataset.order;
                document.getElementById('scanArticleId').value = this.dataset.article;
                document.getElementById('scanModalArticleName').innerText = this.dataset.articlename;
                document.getElementById('scanBatchCode').value = '';
                document.getElementById('scanQuantity').value = 1; 
                scanModalInstance.show();
            });
        });

        scanMaterialModalEl.addEventListener('shown.bs.modal', () => {
            document.getElementById('scanBatchCode').focus();
        });

        document.getElementById('scanMaterialForm').addEventListener('submit', function() {
            const orderId = document.getElementById('scanOrderId').value;
            const articleId = document.getElementById('scanArticleId').value;
            const batchCode = document.getElementById('scanBatchCode').value;
            const qty = document.getElementById('scanQuantity').value;
            const btn = document.getElementById('btnSubmitScan');

            btn.disabled = true;
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';

            fetch('api/scan_material.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    order_id: orderId,
                    article_id: articleId,
                    batch_code: batchCode,
                    quantity: qty
                })
            })
            .then(res => res.json())
            .then(data => {
                if(data.success) {
                    location.reload(); 
                } else {
                    alert('Error: ' + data.message);
                }
            })
            .finally(() => {
                btn.disabled = false;
                btn.innerHTML = 'Register Material';
            });
            
        });
    }

    // --- SETUP: MATERIAL HISTORY MODAL ---
    const historyModalEl = document.getElementById('materialHistoryModal');
    let historyModalInstance = null;
    if (historyModalEl) {
        historyModalInstance = new bootstrap.Modal(historyModalEl);
        
        document.querySelectorAll('.btn-material-history').forEach(btn => {
            btn.addEventListener('click', function() {
                const orderId = this.dataset.order;
                const articleId = this.dataset.article;
                
                document.getElementById('historyModalArticleName').innerText = this.dataset.articlename;
                historyModalInstance.show();

                
                fetch(`api/get_material_history.php?order=${orderId}&article=${articleId}`)
                    .then(res => res.json())
                    .then(data => {
                        let rows = '';
                        if(data.length === 0) {
                            rows = '<tr><td colspan="4" class="text-center text-muted">No materials scanned yet.</td></tr>';
                        } else {
                            data.forEach(log => {
                                rows += `<tr>
                                    <td><span class="badge bg-primary">${log.BatchCode}</span></td>
                                    <td class="fw-bold">${log.Quantity}</td>
                                    <td><i class="fa-solid fa-user-circle me-1"></i>${log.OperatorUsername}</td>
                                    <td>${log.ScanTime}</td>
                                </tr>`;
                            });
                        }
                        document.getElementById('materialHistoryTableBody').innerHTML = rows;
                    });
            });
        });
    }
});
</script>