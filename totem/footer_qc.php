<?php
// =========================================================================
// 1. CONSTANTE DE CONFIGURARE API ȘI TRADUCERI (UI)
// =========================================================================

// Configurații Endpoint-uri API (Modifică aici rutele țintă)
const QC_API_ENDPOINT = "http://localhost:8082/api/qc/check-part.php";
const QC_API_TOKEN    = "secure_bearer_token_token_here";

// Texte Secțiune Principală Calitate (QC)
const L_QC_TITLE            = "Calitate";
const L_QC_NO_REJECTS       = "Nu există rebuturi recente";
const L_TITLE_DISCARD       = "Aruncă / Rebut piese";
const L_TITLE_RECOVERY      = "Recuperare / Reprelucrare";
const L_TITLE_CAMERA        = "Verificare vizuală (Cameră)";

// Texte Modal Rebutare Piese (Discard)
const L_MODAL_DISCARD_TITLE = "Rebutare Piese";
const L_LABEL_QTY           = "Cantitate";
const L_LABEL_CATEGORIES    = "CATEGORII";
const L_LABEL_REASONS       = "MOTIVE";
const L_SELECT_CATEGORY     = "Selectează o categorie";
const L_PLACEHOLDER_NOTES   = "Informații suplimentare (opțional)...";
const L_BTN_CANCEL          = "Anulează";
const L_BTN_CONFIRM_DISCARD = "Confirmă Rebutul";

// Texte Modal Cameră și Verificare Vizuală
const L_MODAL_CAMERA_TITLE  = "Scanare și Verificare Piesă";
const L_BTN_CHECK_PART      = "Verifică piesa";
const L_CAMERA_LOADING      = "Se inițializează fluxul video...";
const L_JS_CAMERA_ERR       = "Nu s-a putut accesa camera video: ";
const L_JS_API_SUCCESS      = "Verificare completă! Piesa a fost procesată.";
const L_JS_API_ERR          = "Eroare la comunicarea cu serverul API.";
?>

<div id="qc" class="footer-section d-flex flex-column h-100">
    <div class="d-flex justify-content-between align-items-center mb-2 w-100">
        <h3 class="mb-0"><?= L_QC_TITLE ?></h3>
        <div class="d-flex gap-1">
            <button class="btn btn-primary btn-sm shadow-sm" id="btn-camera" data-bs-toggle="modal" data-bs-target="#modal-camera" title="<?= L_TITLE_CAMERA ?>" style="width: 40px; height: 32px;">
                <i class="fa-solid fa-camera"></i>
            </button>
            <button class="btn btn-danger btn-sm shadow-sm" id="btn-discard" data-bs-toggle="modal" data-bs-target="#modal-discard" title="<?= L_TITLE_DISCARD ?>" style="width: 40px; height: 32px;">
                <i class="fa-solid fa-trash"></i>
            </button>
            <button class="btn btn-success btn-sm shadow-sm" id="btn-recovery" title="<?= L_TITLE_RECOVERY ?>" style="width: 40px; height: 32px;">
                <i class="fa-solid fa-recycle"></i>
            </button>
        </div>
    </div>

    <div class="qc-recent-list flex-grow-1 overflow-auto border rounded bg-white p-1" style="font-size: 0.8rem;">
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
            <div class="text-muted text-center pt-2 fst-italic"><?= L_QC_NO_REJECTS ?></div>
        <?php endif; ?>
    </div>
</div>

<div class="modal fade" id="modal-discard" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="fa-solid fa-trash me-2"></i> <?= L_MODAL_DISCARD_TITLE ?></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div class="d-flex" style="height: 450px;">
                    <div class="col-4 bg-light border-end p-3 d-flex flex-column">
                        <div class="mb-3">
                            <label class="form-label fw-bold"><?= L_LABEL_QTY ?></label>
                            <input type="number" id="reject-qty" class="form-control form-control-lg text-center fw-bold" value="1" min="1">
                        </div>
                        <div class="flex-grow-1 overflow-auto">
                            <label class="form-label fw-bold text-muted small"><?= L_LABEL_CATEGORIES ?></label>
                            <div class="list-group" id="reject-categories">
                                <div class="text-center p-3"><i class="fa-solid fa-spinner fa-spin"></i></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-8 p-3 d-flex flex-column">
                        <div class="flex-grow-1 overflow-auto mb-3 border rounded p-2 bg-white" id="reject-reasons-container">
                            <label class="form-label fw-bold text-muted small sticky-top bg-white w-100"><?= L_LABEL_REASONS ?></label>
                            <div class="list-group list-group-flush" id="reject-reasons">
                                <div class="text-center p-3 text-muted"><?= L_SELECT_CATEGORY ?></div>
                            </div>
                        </div>

                        <div class="mb-0">
                            <textarea id="reject-notes" class="form-control" rows="2" placeholder="<?= L_PLACEHOLDER_NOTES ?>"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><?= L_BTN_CANCEL ?></button>
                <button type="button" id="btn-submit-reject" class="btn btn-danger px-4" disabled>
                    <i class="fa-solid fa-check"></i> <?= L_BTN_CONFIRM_DISCARD ?>
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modal-camera" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="fa-solid fa-camera me-2"></i> <?= L_MODAL_CAMERA_TITLE ?></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-3 bg-dark text-center position-relative">
                <video id="webcam-stream" autoplay playsinline class="w-100 rounded border border-secondary" style="height: 340px; object-fit: cover; background-color: #000;"></video>
                <canvas id="webcam-canvas" class="d-none"></canvas>
                
                <div id="camera-loading-status" class="text-white small mt-2">
                    <i class="fa-solid fa-circle-notch fa-spin me-1 text-primary"></i> <?= L_CAMERA_LOADING ?>
                </div>
            </div>
            <div class="modal-footer bg-light">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><?= L_BTN_CANCEL ?></button>
                <button type="button" id="btn-capture-and-check" class="btn btn-primary px-4">
                    <i class="fa-solid fa-magnifying-glass me-1"></i> <?= L_BTN_CHECK_PART ?>
                </button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // Preluarea variabilelor globale din configurarea PHP
    const apiEndpoint = "<?= QC_API_ENDPOINT ?>";
    const apiToken    = "<?= QC_API_TOKEN ?>";

    const modalCamera = document.getElementById('modal-camera');
    const video       = document.getElementById('webcam-stream');
    const canvas      = document.getElementById('webcam-canvas');
    const btnCapture  = document.getElementById('btn-capture-and-check');
    const statusText  = document.getElementById('camera-loading-status');
    
    let localStream = null;

    // A. Activare flux video când modalul devine vizibil pe ecran
    modalCamera.addEventListener('shown.bs.modal', async function () {
        statusText.classList.remove('d-none');
        try {
            localStream = await navigator.mediaDevices.getUserMedia({ 
                video: { facingMode: "environment" }, // Preferă camera principală din spate pe dispozitive mobile
                audio: false 
            });
            video.srcObject = localStream;
            statusText.classList.add('d-none');
        } catch (err) {
            console.error("Webcam Error: ", err);
            statusText.innerHTML = `<span class="text-danger"><i class="fa-solid fa-circle-exclamation"></i> <?= L_JS_CAMERA_ERR ?> ${err.message}</span>`;
        }
    });

    // B. Oprire flux video în momentul în care modalul este închis (eliberare hardware)
    modalCamera.addEventListener('hidden.bs.modal', function () {
        if (localStream) {
            localStream.getTracks().forEach(track => track.stop());
            localStream = null;
        }
        video.srcObject = null;
    });

    // C. Captură cadru video și trimitere payload către API (Decizia de procesare)
    btnCapture.addEventListener('click', function () {
        if (!localStream) return;

        // Potrivire rezoluție canvas cu fluxul video activ
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        
        // Desenare cadru curent pe canvas
        const context = canvas.getContext('2d');
        context.drawImage(video, 0, 0, canvas.width, canvas.height);
        
        // Convertire imagine în format Base64 (DataURL)
        const imageDataUrl = canvas.toDataURL('image/jpeg', 0.9);

        // Schimbare stare interfață pe mod procesare
        btnCapture.disabled = true;
        statusText.classList.remove('d-none');
        statusText.innerHTML = '<i class="fa-solid fa-spinner fa-spin text-warning me-1"></i> Se analizează piesa...';

        // Aici se trimite imaginea către endpoint-ul tău API
        fetch(apiEndpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + apiToken
            },
            body: JSON.stringify({
                image: imageDataUrl,
                timestamp: new Date().toISOString()
            })
        })
        .then(response => response.json())
        .then(data => {
            // Aici decizi ce faci cu răspunsul de la API
            alert("<?= L_JS_API_SUCCESS ?>\nResponse: " + JSON.stringify(data));
            
            // Închide modalul după succes
            const bootstrapModal = bootstrap.Modal.getInstance(modalCamera);
            bootstrapModal.hide();
        })
        .catch(error => {
            console.error("API Error: ", error);
            alert("<?= L_JS_API_ERR ?>");
        })
        .finally(() => {
            // Resetare butoane interfață
            btnCapture.disabled = false;
            statusText.classList.add('d-none');
        });
    });
});
</script>