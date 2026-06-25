<?php
// Fetch outputs for the current active recipe if one exists
$logisticsOutputs = [];
if (isset($activeOrder) && $activeOrder) {
    // Join recipe_outputs with the new production_order_progress table
    $stmt = $pdo->prepare("
        SELECT 
            ro.ArticleID, 
            ro.Quantity as RecipeMultiplier, 
            ro.Unit, 
            ro.IsPrimary, 
            a.Name as ArticleName,
            COALESCE(pop.CurrentQuantity, 0) as CurrentQuantity
        FROM recipe_outputs ro
        JOIN article a ON ro.ArticleID = a.ArticleID
        LEFT JOIN production_order_progress pop 
            ON ro.ArticleID = pop.ArticleID 
            AND pop.OrderID = ?
            AND pop.ProgressType = 'Output'
        WHERE ro.RecipeID = ?
        ORDER BY ro.IsPrimary DESC, a.Name ASC
    ");
    $stmt->execute([$activeOrder['OrderID'], $activeOrder['RecipeID']]);
    $logisticsOutputs = $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Container target capacity
$containerTarget = 1000; 
?>

<div class="card border-0 shadow-sm h-100">
    <div class="card-header bg-dark text-white d-flex align-items-center">
        <i class="fa-solid fa-boxes-stacked me-2"></i>
        <h5 class="card-title mb-0">Logistics & Packaging</h5>
    </div>
    <div class="card-body overflow-auto" style="max-height: 400px;">
        <?php if (!$activeOrder): ?>
            <div class="alert alert-secondary text-center">
                <i class="fa-solid fa-power-off mb-2 fs-4 block"></i><br>
                No active production order.
            </div>
        <?php elseif (empty($logisticsOutputs)): ?>
            <div class="alert alert-warning text-center">
                <i class="fa-solid fa-triangle-exclamation mb-2 fs-4 block"></i><br>
                No outputs defined for this recipe.
            </div>
        <?php else: ?>
            <?php foreach ($logisticsOutputs as $out): 
                $currentQty = (float)$out['CurrentQuantity'];
                $percentage = min(100, max(0, ($currentQty / $containerTarget) * 100)); // Ensure it stays 0-100
                $isFull = $currentQty >= $containerTarget;
            ?>
                <div class="output-block border rounded p-3 mb-3 bg-white">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h6 class="mb-0 fw-bold">
                            <?= htmlspecialchars($out['ArticleName']) ?>
                            <?php if ($out['IsPrimary']): ?>
                                <span class="badge bg-primary ms-1">Primary</span>
                            <?php else: ?>
                                <span class="badge bg-secondary ms-1">Secondary</span>
                            <?php endif; ?>
                        </h6>
                        <span class="fw-bold fs-5 <?= $isFull ? 'text-success' : 'text-dark' ?>">
                            <span id="qty-output-<?= $out['ArticleID'] ?>" data-target="<?= $containerTarget ?>"><?= number_format($currentQty, 0) ?></span> / <?= $containerTarget ?> 
                            <span class="fs-6 text-muted fw-normal"><?= htmlspecialchars($out['Unit']) ?></span>
                        </span>
                    </div>
                    
                    <div class="progress mb-3" style="height: 20px;">
                        <div id="progress-bar-<?= $out['ArticleID'] ?>"
                             class="progress-bar <?= $isFull ? 'bg-success' : 'bg-primary progress-bar-striped progress-bar-animated' ?>" 
                             role="progressbar" 
                             style="width: <?= $percentage ?>%;" 
                             aria-valuenow="<?= $percentage ?>" 
                             aria-valuemin="0" 
                             aria-valuemax="100">
                            <?= round($percentage) ?>%
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button id="btn-print-<?= $out['ArticleID'] ?>"
                                class="btn btn-primary flex-fill btn-print-label" 
                                data-order="<?= $activeOrder['OrderID'] ?>" 
                                data-article="<?= $out['ArticleID'] ?>" 
                                data-qty="<?= $currentQty ?>"
                                <?= $currentQty <= 0 ? 'disabled' : '' ?>>
                            <i class="fa-solid fa-print me-1"></i> Print Label
                        </button>
                        
                        <button class="btn btn-danger flex-fill btn-print-close" 
                                data-order="<?= $activeOrder['OrderID'] ?>" 
                                data-article="<?= $out['ArticleID'] ?>" 
                                data-qty="<?= $currentQty ?>">
                            <i class="fa-solid fa-flag-checkered me-1"></i> Print & Close
                        </button>
                        
                        <button class="btn btn-outline-secondary flex-fill btn-view-labels" 
                                data-order="<?= $activeOrder['OrderID'] ?>" 
                                data-article="<?= $out['ArticleID'] ?>"
                                data-articlename="<?= htmlspecialchars($out['ArticleName']) ?>">
                            <i class="fa-solid fa-list me-1"></i> View Labels
                        </button>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</div>

<div class="modal fade" id="labelsModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-light">
                <h5 class="modal-title fw-bold">
                    <i class="fa-solid fa-tags me-2 text-primary"></i> 
                    Printed Labels: <span id="modalArticleName" class="text-primary"></span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>Batch Code</th>
                                <th>Quantity</th>
                                <th>Operator</th>
                                <th>Time Printed</th>
                            </tr>
                        </thead>
                        <tbody id="labelsTableBody">
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
    if (!window.labelsModalInitialized) {
        document.addEventListener('DOMContentLoaded', () => {
            
            // 1. View Labels Modal
            document.querySelectorAll('.btn-view-labels').forEach(btn => {
                btn.addEventListener('click', function() {
                    const orderId = this.dataset.order;
                    const articleId = this.dataset.article;
                    document.getElementById('modalArticleName').innerText = this.dataset.articlename;
                    
                    const modal = new bootstrap.Modal(document.getElementById('labelsModal'));
                    modal.show();

                    fetch(`api/get_labels.php?order=${orderId}&article=${articleId}`)
                        .then(res => res.json())
                        .then(data => {
                            let rows = '';
                            if(data.length === 0) {
                                rows = '<tr><td colspan="4" class="text-center text-muted">No labels printed yet.</td></tr>';
                            } else {
                                data.forEach(lbl => {
                                    rows += `<tr>
                                        <td><span class="badge bg-secondary">${lbl.BatchCode}</span></td>
                                        <td class="fw-bold">${lbl.Quantity}</td>
                                        <td><i class="fa-solid fa-user-circle me-1"></i>${lbl.OperatorUsername}</td>
                                        <td>${lbl.PrintTime}</td>
                                    </tr>`;
                                });
                            }
                            document.getElementById('labelsTableBody').innerHTML = rows;
                        });
                });
            });

            // 2. Print Label & Reset Buffer
            document.querySelectorAll('.btn-print-label').forEach(btn => {
                btn.addEventListener('click', function() {
                    const orderId = this.dataset.order;
                    const articleId = this.dataset.article;
                    
                    // Fetch the live quantity dynamically in case the AJAX polling updated it
                    const liveQtyText = document.getElementById(`qty-output-${articleId}`).innerText;
                    const qty = parseFloat(liveQtyText.replace(/,/g, ''));

                    if(qty <= 0) { alert("Buffer is empty!"); return; }

                    this.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Printing...';
                    this.disabled = true;

                    fetch('api/print_label.php', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ order_id: orderId, article_id: articleId, qty: qty })
                    })
                    .then(res => res.json())
                    .then(data => {
                        if(data.success) {
                            alert("Printed Label: " + data.batch_code);
                            location.reload(); 
                        } else {
                            alert('Error: ' + data.message);
                            this.innerHTML = '<i class="fa-solid fa-print me-1"></i> Print Label';
                            this.disabled = false;
                        }
                    });
                });
            });

            // 3. Print Final Label & Close Order
            document.querySelectorAll('.btn-print-close').forEach(btn => {
                btn.addEventListener('click', function() {
                    const orderId = this.dataset.order;
                    const articleId = this.dataset.article;
                    
                    // Fetch the live quantity dynamically
                    const liveQtyText = document.getElementById(`qty-output-${articleId}`).innerText;
                    const qty = parseFloat(liveQtyText.replace(/,/g, ''));

                    if(!confirm("Are you sure you want to print the final label and CLOSE this order?")) return;

                    this.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Closing...';
                    this.disabled = true;

                    fetch('api/print_and_close.php', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ order_id: orderId, article_id: articleId, qty: qty })
                    })
                    .then(res => res.json())
                    .then(data => {
                        if(data.success) {
                            alert("Order Closed. Final Label: " + data.batch_code);
                            location.reload(); 
                        } else {
                            alert('Error: ' + data.message);
                            this.innerHTML = '<i class="fa-solid fa-flag-checkered me-1"></i> Print & Close';
                            this.disabled = false;
                        }
                    });
                });
            });

            window.labelsModalInitialized = true;
        });
    }
</script>