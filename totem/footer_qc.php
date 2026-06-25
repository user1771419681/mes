<?php
// QC configuration
const QC_API_ENDPOINT = "http://localhost:8082/api/qc/check-part.php";
const QC_API_TOKEN    = "secure_bearer_token_token_here";
?>

<div class="card border-0 shadow-sm h-100">
    <div class="card-header bg-danger text-white d-flex align-items-center">
        <i class="fa-solid fa-clipboard-check me-2"></i>
        <h5 class="card-title mb-0">Quality Control</h5>
    </div>
    <div class="card-body d-flex flex-column overflow-hidden" style="max-height: 400px; padding: 15px;">
        
        <h6 class="text-muted small fw-bold mb-2">Recent Discards</h6>
        <div class="flex-grow-1 overflow-auto mb-3 border rounded p-2 bg-light" id="live-rejects-list">
            <?php if (!empty($data['recentRejects'])): ?>
                <?php foreach ($data['recentRejects'] as $reject): ?>
                    <div class="d-flex justify-content-between border-bottom pb-1 mb-1 px-1">
                        <span class="text-truncate" style="max-width: 75%;" title="<?= htmlspecialchars($reject['CategoryName'] . ' - ' . $reject['ReasonName']) ?>">
                            <?= htmlspecialchars($reject['ReasonName']) ?>
                        </span>
                        <span class="fw-bold text-danger">-<?= $reject['Quantity'] ?></span>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="text-muted text-center pt-2 fst-italic">No recent rejects</div>
            <?php endif; ?>
        </div>

        <div class="d-flex gap-2 mt-auto">
            <button class="btn btn-outline-danger flex-fill" data-bs-toggle="modal" data-bs-target="#modal-discard">
                <i class="fa-solid fa-trash mb-1 d-block fs-5"></i> Discard
            </button>
            <button class="btn btn-primary flex-fill" data-bs-toggle="modal" data-bs-target="#modal-camera">
                <i class="fa-solid fa-camera mb-1 d-block fs-5"></i> Camera Scan
            </button>
            <button class="btn btn-success flex-fill">
                <i class="fa-solid fa-recycle mb-1 d-block fs-5"></i> Recover
            </button>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-discard" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="fa-solid fa-trash me-2"></i> Report Rejects</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4 text-center">
                <h3 class="text-muted">Reject Form Placeholder</h3>
                <p>Implement reason selection and quantity insertion here.</p>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-camera" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="fa-solid fa-camera me-2"></i> Scan Part</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-3 bg-dark text-center position-relative">
                <video id="webcam-stream" autoplay playsinline class="w-100 rounded border border-secondary" style="height: 340px; object-fit: cover; background-color: #000;"></video>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const activeOrderId = <?= isset($activeOrder) && $activeOrder ? $activeOrder['OrderID'] : 'null' ?>;
    
    if (activeOrderId) {
        setInterval(() => {
            fetch(`api/live_update.php?order_id=${activeOrderId}`)
                .then(res => res.json())
                .then(data => {
                    if(!data.success) return;

                    // 1. Update Material & Logistics Quantities
                    data.progress.forEach(p => {
                        if (p.ProgressType === 'Input') {
                            const textEl = document.getElementById(`qty-input-${p.ArticleID}`);
                            const boxEl = document.getElementById(`box-input-${p.ArticleID}`);
                            if (textEl && boxEl) {
                                const qty = parseFloat(p.CurrentQuantity);
                                textEl.innerText = qty.toFixed(2);
                                
                                const scanBtn = boxEl.querySelector('.btn-scan-material');
                                const histBtn = boxEl.querySelector('.btn-material-history');
                                
                                if (qty < 0) {
                                    boxEl.classList.add('material-negative');
                                    boxEl.classList.remove('border-secondary', 'bg-white', 'text-dark');
                                    if(scanBtn) { scanBtn.classList.replace('btn-primary', 'btn-danger'); }
                                    if(histBtn) { histBtn.classList.replace('btn-outline-secondary', 'btn-outline-danger'); }
                                } else {
                                    boxEl.classList.remove('material-negative');
                                    boxEl.classList.add('border-secondary', 'bg-white', 'text-dark');
                                    if(scanBtn) { scanBtn.classList.replace('btn-danger', 'btn-primary'); }
                                    if(histBtn) { histBtn.classList.replace('btn-outline-danger', 'btn-outline-secondary'); }
                                }
                            }
                        } else if (p.ProgressType === 'Output') {
                            const textEl = document.getElementById(`qty-output-${p.ArticleID}`);
                            const barEl = document.getElementById(`progress-bar-${p.ArticleID}`);
                            const btnPrint = document.getElementById(`btn-print-${p.ArticleID}`);
                            
                            if (textEl && barEl) {
                                const qty = parseFloat(p.CurrentQuantity);
                                const target = parseFloat(textEl.dataset.target) || 1000;
                                textEl.innerText = qty.toFixed(0);
                                
                                let pct = Math.min(100, Math.max(0, (qty / target) * 100));
                                barEl.style.width = pct + '%';
                                barEl.innerText = Math.round(pct) + '%';
                                
                                if (qty >= target) {
                                    barEl.classList.add('bg-success');
                                    barEl.classList.remove('bg-primary', 'progress-bar-striped', 'progress-bar-animated');
                                    textEl.classList.replace('text-dark', 'text-success');
                                } else {
                                    barEl.classList.remove('bg-success');
                                    barEl.classList.add('bg-primary', 'progress-bar-striped', 'progress-bar-animated');
                                    textEl.classList.replace('text-success', 'text-dark');
                                }

                                if (btnPrint) btnPrint.disabled = (qty <= 0);
                            }
                        }
                    });

                    // 2. Update QC Rejects List
                    const rejectList = document.getElementById('live-rejects-list');
                    if (rejectList) {
                        if (data.rejects.length === 0) {
                            rejectList.innerHTML = '<div class="text-muted text-center pt-2 fst-italic">No recent rejects</div>';
                        } else {
                            let html = '';
                            data.rejects.forEach(r => {
                                html += `<div class="d-flex justify-content-between border-bottom pb-1 mb-1 px-1">
                                    <span class="text-truncate" style="max-width: 75%;">
                                        ${r.ReasonName}
                                    </span>
                                    <span class="fw-bold text-danger">-${r.Quantity}</span>
                                </div>`;
                            });
                            rejectList.innerHTML = html;
                        }
                    }
                })
                .catch(err => console.error("Polling error:", err));
        }, 5000); // 5000ms = 5 Seconds
    }
});
</script>