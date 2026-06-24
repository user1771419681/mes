<div id="production-area">
    
    <?php if ($activeOrder): ?>
        <?php 
            $percent = 0;
            if ($activeOrder['TargetQuantity'] > 0) {
                $percent = ($activeOrder['ProducedQuantity'] / $activeOrder['TargetQuantity']) * 100;
                $percent = min(100, round($percent, 1));
            }
        ?>
        <div class="panel h-100 d-flex flex-column">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h3><i class="fa-solid fa-gear fa-spin me-2"></i> In Production</h3>
                <span class="badge bg-success" style="padding:5px 10px; border-radius:4px; color:white; background:green;">RUNNING</span>
            </div>
            
            <div style="font-size:1.2rem; margin-bottom:10px;">
                <strong>Order #<?= $activeOrder['OrderID'] ?></strong> - <?= htmlspecialchars($activeOrder['ArticleName']) ?>
            </div>
            
            <div style="display:grid; grid-template-columns: 1fr 1fr; gap:10px; margin-bottom:20px;">
                <div class="stat-box" style="background:#f8f9fa; padding:10px; border-radius:5px;">
                    <div style="color:#666; font-size:0.9rem;">Target</div>
                    <div style="font-size:1.5rem; font-weight:bold;"><?= number_format($activeOrder['TargetQuantity'], 0) ?></div>
                </div>
                <div class="stat-box" style="background:#e0f2fe; padding:10px; border-radius:5px; border:1px solid #bae6fd;">
                    <div style="color:#0369a1; font-size:0.9rem;">Produced</div>
                    <div style="font-size:1.5rem; font-weight:bold; color:#0284c7;"><?= number_format($activeOrder['ProducedQuantity'], 0) ?></div>
                </div>
            </div>

            <div class="progress-container mb-3">
                <div class="progress-bar" style="width: <?= $percent ?>%;"><?= $percent ?>%</div>
            </div>
            
            <div style="margin-top:auto; display:flex; gap:10px;">
                <button class="large-btn secondary flex-fill text-white" style="background:#dc2626;" data-bs-toggle="modal" data-bs-target="#finishOrderModal">
                    <i class="fa-solid fa-flag-checkered me-2"></i> Finish Order
                </button>
                <button class="large-btn secondary flex-fill text-white" style="background:#f59e0b;" data-bs-toggle="modal" data-bs-target="#suspendOrderModal">
                    <i class="fa-solid fa-pause me-2"></i> Suspend Run
                </button>
            </div>
        </div>

        <div class="modal fade" id="finishOrderModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fa-solid fa-triangle-exclamation me-2"></i> Finish Order</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to finish and close <strong>Order #<?= $activeOrder['OrderID'] ?></strong>? This action will close the active production log and mark the order as <strong>Closed</strong>.</p>
                        <div class="mb-3">
                            <label for="finishNotes" class="form-label">Production Notes (Optional)</label>
                            <textarea class="form-control" id="finishNotes" rows="2" placeholder="e.g., Target met, run completed smoothly."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" id="btnConfirmFinish" data-order="<?= $activeOrder['OrderID'] ?>">Confirm Finish</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="suspendOrderModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title"><i class="fa-solid fa-pause me-2"></i> Suspend Order</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to suspend <strong>Order #<?= $activeOrder['OrderID'] ?></strong>? You will be able to resume this order later.</p>
                        <div class="mb-3">
                            <label for="suspendNotes" class="form-label">Reason for Suspension (Optional)</label>
                            <textarea class="form-control" id="suspendNotes" rows="2" placeholder="e.g., Missing materials, shift ended early."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-warning" id="btnConfirmSuspend" data-order="<?= $activeOrder['OrderID'] ?>">Confirm Suspend</button>
                    </div>
                </div>
            </div>
        </div>

    <?php else: ?>
        <div class="panel h-100">
            <h3>Select Order to Start</h3>
            
            <?php if (empty($plannedOrders)): ?>
                <div style="text-align:center; padding:40px; color:#999;">
                    <i class="fa-solid fa-clipboard-list fa-3x mb-3"></i>
                    <p>No planned orders available for this machine.</p>
                </div>
            <?php else: ?>
                <div style="overflow-y:auto; height:85%;">
                    <table style="width:100%; border-collapse:collapse;">
                        <thead>
                            <tr style="background:#f3f4f6; text-align:left;">
                                <th style="padding:10px;">ID</th>
                                <th style="padding:10px;">Article</th>
                                <th style="padding:10px;">Qty</th>
                                <th style="padding:10px;">Date</th>
                                <th style="padding:10px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($plannedOrders as $po): ?>
                                <tr style="border-bottom:1px solid #eee;">
                                    <td style="padding:10px; font-weight:bold;">#<?= $po['OrderID'] ?></td>
                                    <td style="padding:10px;"><?= htmlspecialchars($po['ArticleName']) ?></td>
                                    <td style="padding:10px;"><?= number_format($po['TargetQuantity'], 0) ?></td>
                                    <td style="padding:10px;"><?= date('d/m', strtotime($po['PlannedStartDate'])) ?></td>
                                    <td style="padding:10px;">
                                        <button class="btn btn-primary btn-sm btn-start-order" data-id="<?= $po['OrderID'] ?>" style="padding:8px 15px; font-size:0.9rem;">
                                            <i class="fa-solid fa-play"></i> Start
                                        </button>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endif; ?>
        </div>
    <?php endif; ?>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    
    // Handler for Finishing an Order
    const btnConfirmFinish = document.getElementById('btnConfirmFinish');
    if (btnConfirmFinish) {
        btnConfirmFinish.addEventListener('click', function() {
            const orderId = this.dataset.order;
            const notes = document.getElementById('finishNotes').value;
            
            this.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';
            this.disabled = true;

            fetch('api/order_action.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    action: 'finish',
                    order_id: orderId,
                    notes: notes
                })
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    location.reload(); // Reload to clear active order layout
                } else {
                    alert('Error closing order: ' + (data.message || 'Unknown error'));
                    this.innerHTML = 'Confirm Finish';
                    this.disabled = false;
                }
            })
            .catch(err => {
                console.error(err);
                alert('Network or server error occurred.' + err);
                this.innerHTML = 'Confirm Finish';
                this.disabled = false;
            });
        });
    }

    // Handler for Suspending an Order
    const btnConfirmSuspend = document.getElementById('btnConfirmSuspend');
    if (btnConfirmSuspend) {
        btnConfirmSuspend.addEventListener('click', function() {
            const orderId = this.dataset.order;
            const notes = document.getElementById('suspendNotes').value;
            
            this.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Processing...';
            this.disabled = true;

            fetch('api/order_action.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    action: 'suspend',
                    order_id: orderId,
                    notes: notes
                })
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    location.reload(); 
                } else {
                    alert('Error suspending order: ' + (data.message || 'Unknown error'));
                    this.innerHTML = 'Confirm Suspend';
                    this.disabled = false;
                }
            })
            .catch(err => {
                console.error(err);
                alert('Network or server error occurred.' + err);
                this.innerHTML = 'Confirm Suspend';
                this.disabled = false;
            });
        });
    }
});
</script>