<?php
$stmtStop = $pdo->prepare("SELECT StopID, CategoryID FROM machine_stop_log WHERE MachineID = ? AND EndTime IS NULL LIMIT 1");
$stmtStop->execute([$machine['MachineID']]);
$activeStop = $stmtStop->fetch(PDO::FETCH_ASSOC);

$hasActiveStop = $activeStop !== false;
$activeStopId = $hasActiveStop ? $activeStop['StopID'] : null;
$isUnclassified = $hasActiveStop && empty($activeStop['CategoryID']);

$stmtUnclassified = $pdo->prepare("SELECT COUNT(*) FROM machine_stop_log WHERE MachineID = ? AND EndTime IS NOT NULL AND (CategoryID IS NULL OR ReasonID IS NULL)");
$stmtUnclassified->execute([$machine['MachineID']]);
$unclassifiedCount = $stmtUnclassified->fetchColumn();

$stopCategories = $pdo->query("SELECT * FROM machine_stop_category ORDER BY CategoryName")->fetchAll(PDO::FETCH_ASSOC);
$stopReasons = $pdo->query("SELECT * FROM machine_stop_reason ORDER BY ReasonName")->fetchAll(PDO::FETCH_ASSOC);
?>

<aside id="machine-panel">
    <div class="panel h-100 d-flex flex-column">
        <h3>Machine Info</h3>
        <div class="machine-detail">
            <span class="label">Name:</span>
            <span class="value">
                <?= htmlspecialchars($machine['Name']) ?>
            </span>
        </div>
        <div class="machine-detail">
            <span class="label">Status:</span>
            <span id="ui-machine-status" class="value <?= $hasActiveStop ? 'text-danger fw-bold' : '' ?>">
                <?= $hasActiveStop ? 'STOPPED' : htmlspecialchars($machine['Status']) ?>
            </span>
        </div>
        <div class="machine-detail">
            <span class="label">Model:</span>
            <span class="value">
                <?= htmlspecialchars($machine['Model']) ?>
            </span>
        </div>
        
        <div class="mt-auto">
            <button id="btn-trigger-main-stop"
                    class="btn <?= $hasActiveStop ? 'btn-danger' : 'btn-secondary' ?> w-100 fw-bold py-3 mb-2" 
                    data-bs-toggle="modal" 
                    data-bs-target="#modal-machine-stops">
                <i id="ui-stop-icon" class="fa-solid fa-triangle-exclamation <?= $hasActiveStop ? 'fa-fade' : '' ?> me-2"></i> 
                <span id="ui-stop-text"><?= $hasActiveStop ? 'MACHINE STOPPED' : 'Report Stop' ?></span>
            </button>
            
            <button class="btn btn-outline-dark w-100 fw-bold py-2" 
                    id="btn-stop-history"
                    data-machine="<?= $machine['MachineID'] ?>">
                <i class="fa-solid fa-clock-rotate-left me-2"></i> Stop History
                <span id="ui-unclassified-badge" class="badge bg-danger ms-2 pulse-badge <?= $unclassifiedCount > 0 ? '' : 'd-none' ?>" title="Unclassified Stops">
                    <span id="ui-unclassified-count"><?= $unclassifiedCount ?></span> Pending
                </span>
            </button>
        </div>
    </div>
</aside>

<div class="modal fade" id="modal-machine-stops" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header <?= $hasActiveStop ? 'bg-danger' : 'bg-warning text-dark' ?> text-white" id="stop-modal-header">
                <h5 class="modal-title fw-bold" id="stop-modal-title">
                    <i class="fa-solid fa-hand me-2"></i> 
                    <?= $hasActiveStop ? 'Active Machine Stop' : 'Register Machine Stop' ?>
                </h5>
                <button type="button" class="btn-close <?= $hasActiveStop ? 'btn-close-white' : '' ?>" id="btn-close-modal-header" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4 text-start">
                
                <div id="unclassified-warning" class="alert alert-warning border-warning <?= ($hasActiveStop && $isUnclassified) ? '' : 'd-none' ?>">
                    <i class="fa-solid fa-bell me-2"></i>
                    <strong>Action Required:</strong> The machine has been stopped automatically due to inactivity. Please classify the reason below.
                </div>
                
                <form id="form-machine-stop" onsubmit="return false;">
                    <input type="hidden" id="stop-machine-id" value="<?= $machine['MachineID'] ?>">
                    <input type="hidden" id="stop-active-id" value="<?= $activeStopId ?>">
                    <input type="hidden" id="stop-order-id" value="<?= isset($activeOrder) && $activeOrder ? $activeOrder['OrderID'] : '' ?>">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Stop Category <span class="text-danger">*</span></label>
                        <select class="form-select form-select-lg" id="stop-category" required>
                            <option value="">-- Select Category --</option>
                            <?php foreach($stopCategories as $cat): ?>
                                <option value="<?= $cat['CategoryID'] ?>"><?= htmlspecialchars($cat['CategoryName']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">Stop Reason <span class="text-danger">*</span></label>
                        <select class="form-select form-select-lg" id="stop-reason" required disabled>
                            <option value="">-- First, select a category --</option>
                            <?php foreach($stopReasons as $res): ?>
                                <option value="<?= $res['ReasonID'] ?>" data-category="<?= $res['CategoryID'] ?>" class="d-none">
                                    <?= htmlspecialchars($res['ReasonName']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold">Notes (Optional)</label>
                        <textarea class="form-control" id="stop-notes" rows="3" placeholder="Provide additional details regarding the downtime..."></textarea>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn <?= $hasActiveStop ? 'btn-danger' : 'btn-warning text-dark' ?> btn-lg fw-bold" id="btn-submit-stop">
                            <i class="fa-solid fa-save me-2"></i> <span id="submit-stop-text"><?= $hasActiveStop ? 'Update Stop Information' : 'Confirm Machine Stop' ?></span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-stop-history" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-dark text-white">
                <h5 class="modal-title fw-bold">
                    <i class="fa-solid fa-clock-rotate-left me-2"></i> Machine Stop History
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div class="table-responsive" style="max-height: 60vh;">
                    <table class="table table-hover table-striped mb-0 align-middle">
                        <thead class="table-light sticky-top">
                            <tr>
                                <th>Period</th>
                                <th>Duration</th>
                                <th>Category / Reason</th>
                                <th>Operator</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody id="stop-history-body">
                            <tr><td colspan="5" class="text-center py-4 text-muted"><i class="fa-solid fa-spinner fa-spin me-2"></i> Loading history...</td></tr>
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

<style>
    @keyframes pulse-red {
        0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.7); }
        70% { transform: scale(1); box-shadow: 0 0 0 10px rgba(220, 53, 69, 0); }
        100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(220, 53, 69, 0); }
    }
    .pulse-badge { animation: pulse-red 2s infinite; }
</style>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const machineId = <?= $machine['MachineID'] ?>;
    
    setInterval(() => {
        fetch(`api/live_update.php?machine_id=${machineId}`)
            .then(res => res.json())
            .then(data => {
                if (data.machine_status !== undefined) {
                    const statusEl = document.getElementById('ui-machine-status');
                    const btnStop = document.getElementById('btn-trigger-main-stop');
                    const iconStop = document.getElementById('ui-stop-icon');
                    const textStop = document.getElementById('ui-stop-text');
                    const headerModal = document.getElementById('stop-modal-header');
                    const btnSubmitStop = document.getElementById('btn-submit-stop');
                    const btnCloseModal = document.getElementById('btn-close-modal-header');
                    
                    // 1. Update Active Stop UI
                    if (data.has_active_stop) {
                        statusEl.innerText = 'STOPPED';
                        statusEl.className = 'value text-danger fw-bold';
                        
                        btnStop.className = 'btn btn-danger w-100 fw-bold py-3 mb-2';
                        iconStop.className = 'fa-solid fa-triangle-exclamation fa-fade me-2';
                        textStop.innerText = 'MACHINE STOPPED';
                        
                        // Update Modal Hidden State
                        document.getElementById('stop-active-id').value = data.active_stop_id;
                        
                        const warningAlert = document.getElementById('unclassified-warning');
                        if (data.is_unclassified_active) {
                            warningAlert.classList.remove('d-none');
                        } else {
                            warningAlert.classList.add('d-none');
                        }
                    } else {
                        statusEl.innerText = data.machine_status;
                        statusEl.className = 'value'; 
                        
                        btnStop.className = 'btn btn-secondary w-100 fw-bold py-3 mb-2';
                        iconStop.className = 'fa-solid fa-triangle-exclamation me-2';
                        textStop.innerText = 'Report Stop';
                        
                        document.getElementById('stop-active-id').value = '';
                        document.getElementById('unclassified-warning').classList.add('d-none');
                    }

                    // 2. Update Unclassified History Badge
                    const badgeEl = document.getElementById('ui-unclassified-badge');
                    const countEl = document.getElementById('ui-unclassified-count');
                    if (data.unclassified_count > 0) {
                        countEl.innerText = data.unclassified_count;
                        badgeEl.classList.remove('d-none');
                    } else {
                        badgeEl.classList.add('d-none');
                    }
                }
            })
            .catch(err => console.error("Machine polling error:", err));
    }, 5000);

    const categorySelect = document.getElementById('stop-category');
    const reasonSelect = document.getElementById('stop-reason');
    const stopForm = document.getElementById('form-machine-stop');
    const stopActiveIdField = document.getElementById('stop-active-id');
    const warningAlert = document.getElementById('unclassified-warning');

    const stopModalEl = document.getElementById('modal-machine-stops');
    const historyModalEl = document.getElementById('modal-stop-history');
    let stopModalInstance = null;
    let historyModalInstance = null;
    
    if (stopModalEl) stopModalInstance = new bootstrap.Modal(stopModalEl);
    if (historyModalEl) historyModalInstance = new bootstrap.Modal(historyModalEl);

    if (categorySelect && reasonSelect) {
        categorySelect.addEventListener('change', function() {
            const selectedCat = this.value;
            let firstValidReason = null;
            
            reasonSelect.value = "";
            
            if (!selectedCat) {
                reasonSelect.disabled = true;
                Array.from(reasonSelect.options).forEach(opt => { if(opt.value) opt.classList.add('d-none'); });
                reasonSelect.options[0].text = "-- First, select a category --";
                return;
            }

            reasonSelect.disabled = false;
            reasonSelect.options[0].text = "-- Select Reason --";

            Array.from(reasonSelect.options).forEach(opt => {
                if (!opt.value) return; 
                if (opt.dataset.category === selectedCat) {
                    opt.classList.remove('d-none');
                    if (!firstValidReason) firstValidReason = opt.value;
                } else {
                    opt.classList.add('d-none');
                }
            });
        });
    }

    const btnMainStop = document.getElementById('btn-trigger-main-stop');
    if (btnMainStop) {
        btnMainStop.addEventListener('click', () => {
            const hasStop = stopActiveIdField.value !== "";
            const isUnclass = !document.getElementById('unclassified-warning').classList.contains('d-none');
            
            document.getElementById('stop-modal-title').innerHTML = `<i class='fa-solid fa-hand me-2'></i> ${hasStop ? 'Active Machine Stop' : 'Register Machine Stop'}`;
            document.getElementById('submit-stop-text').innerText = hasStop ? 'Update Stop Information' : 'Confirm Machine Stop';
            
            const header = document.getElementById('stop-modal-header');
            const btnSubmit = document.getElementById('btn-submit-stop');
            const btnClose = document.getElementById('btn-close-modal-header');

            if (hasStop) {
                header.className = 'modal-header bg-danger text-white';
                btnSubmit.className = 'btn btn-danger btn-lg fw-bold';
                btnClose.classList.add('btn-close-white');
            } else {
                header.className = 'modal-header bg-warning text-dark';
                btnSubmit.className = 'btn btn-warning text-dark btn-lg fw-bold';
                btnClose.classList.remove('btn-close-white');
            }
        });
    }

    const btnHistory = document.getElementById('btn-stop-history');
    if (btnHistory) {
        btnHistory.addEventListener('click', function() {
            historyModalInstance.show();

            fetch(`api/get_stop_history.php?machine_id=${machineId}`)
                .then(res => res.json())
                .then(data => {
                    let rows = '';
                    if(data.length === 0) {
                        rows = '<tr><td colspan="5" class="text-center text-muted py-4">No stops recorded for this machine.</td></tr>';
                    } else {
                        data.forEach(stop => {
                            let statusHtml = '';
                            let actionHtml = '';

                            if (stop.IsUnclassified) {
                                statusHtml = `<span class="badge bg-danger"><i class="fa-solid fa-triangle-exclamation me-1"></i> Unclassified</span>`;
                                actionHtml = `<button class="btn btn-sm btn-danger btn-classify-stop" data-id="${stop.StopID}"><i class="fa-solid fa-pen"></i> Classify</button>`;
                            } else {
                                statusHtml = `<strong>${stop.CategoryName}</strong><br><span class="text-muted small">${stop.ReasonName}</span>`;
                                actionHtml = `<span class="badge bg-success"><i class="fa-solid fa-check"></i> Resolved</span>`;
                            }

                            rows += `
                                <tr>
                                    <td>
                                        <div><i class="fa-regular fa-clock text-muted me-1"></i> ${stop.StartTimeFormatted}</div>
                                        <div class="small text-muted">To: ${stop.EndTimeFormatted}</div>
                                    </td>
                                    <td class="fw-bold">${stop.DurationMinutes} min</td>
                                    <td>${statusHtml}</td>
                                    <td><i class="fa-solid fa-user-circle me-1 text-muted"></i> ${stop.OperatorUsername || 'System'}</td>
                                    <td class="text-end">${actionHtml}</td>
                                </tr>
                            `;
                        });
                    }
                    document.getElementById('stop-history-body').innerHTML = rows;

                    document.querySelectorAll('.btn-classify-stop').forEach(btn => {
                        btn.addEventListener('click', function() {
                            const pastStopId = this.dataset.id;
                            
                            historyModalInstance.hide();
                            
                            stopActiveIdField.value = pastStopId;
                            categorySelect.value = '';
                            reasonSelect.value = '';
                            reasonSelect.disabled = true;
                            document.getElementById('stop-notes').value = '';
                            
                            warningAlert.classList.remove('d-none');
                            document.getElementById('stop-modal-title').innerHTML = "<i class='fa-solid fa-pen me-2'></i> Classify Past Stop";
                            document.getElementById('submit-stop-text').innerText = "Save Classification";
                            document.getElementById('stop-modal-header').className = "modal-header bg-danger text-white";
                            document.getElementById('btn-submit-stop').className = "btn btn-danger btn-lg fw-bold";
                            document.getElementById('btn-close-modal-header').classList.add('btn-close-white');

                            stopModalInstance.show();
                        });
                    });
                })
                .catch(err => {
                    document.getElementById('stop-history-body').innerHTML = `<tr><td colspan="5" class="text-center text-danger">Error loading history</td></tr>`;
                });
        });
    }

    if (stopForm) {
        stopForm.addEventListener('submit', function() {
            const btn = document.getElementById('btn-submit-stop');
            const originalBtnHtml = btn.innerHTML;
            
            btn.disabled = true;
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin me-2"></i> Processing...';

            const payload = {
                machine_id: document.getElementById('stop-machine-id').value,
                stop_id: document.getElementById('stop-active-id').value,
                order_id: document.getElementById('stop-order-id').value,
                category_id: document.getElementById('stop-category').value,
                reason_id: document.getElementById('stop-reason').value,
                notes: document.getElementById('stop-notes').value
            };

            fetch('api/manage_stop.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if(data.success) {
                    location.reload(); 
                } else {
                    alert('Error: ' + data.message);
                    btn.disabled = false;
                    btn.innerHTML = originalBtnHtml;
                }
            })
            .catch(err => {
                console.error(err);
                alert("Network Error");
                btn.disabled = false;
                btn.innerHTML = originalBtnHtml;
            });
        });
    }
});
</script>