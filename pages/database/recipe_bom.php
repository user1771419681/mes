<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/Config.php';
require_once INCLUDE_PATH . 'IsAdmin.php';
require_once INCLUDE_PATH . 'Database.php';
require_once INCLUDE_PATH . 'RecipeManager.php';
require_once INCLUDE_PATH . 'ArticleManager.php';

$isAdmin = isAdmin();
if (!$isAdmin) {
    header("Location: " . $siteBaseUrl . "index.php");
    exit;
}

$recipeId = isset($_GET['recipe_id']) ? (int)$_GET['recipe_id'] : 0;
if ($recipeId <= 0) {
    header("Location: cycles.php?error=invalid_recipe");
    exit;
}

$recipeManager = new RecipeManager($pdo);
$inputManager = new RecipeInputManager($pdo);
$outputManager = new RecipeOutputManager($pdo);
$articleManager = new ArticleManager($pdo);

$recipe = $recipeManager->getRecipeById($recipeId);
if (!$recipe) {
    header("Location: cycles.php?error=recipe_not_found");
    exit;
}

$targetArticle = $articleManager->getArticleById($recipe['ArticleID']);
$articles = $articleManager->listArticles();

$message = '';
$error = '';

// --- POST HANDLERS ---
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $redirectUrl = "recipe_bom.php?recipe_id=$recipeId";

    // --- INPUTS ---
    if (isset($_POST['add_input'])) {
        if ($inputManager->createInput($recipeId, (int)$_POST['article_id'], (float)$_POST['quantity'], $_POST['unit'], $_POST['input_type'])) {
            header("Location: $redirectUrl&msg=input_added"); exit;
        } else {
            $error = "Failed to add input.";
        }
    }
    if (isset($_POST['edit_input'])) {
        if ($inputManager->updateInput((int)$_POST['input_id'], null, (int)$_POST['edit_article_id'], (float)$_POST['edit_quantity'], $_POST['edit_unit'], $_POST['edit_input_type'])) {
            header("Location: $redirectUrl&msg=input_updated"); exit;
        } else {
            $error = "Failed to update input.";
        }
    }
    if (isset($_POST['delete_input'])) {
        if ($inputManager->deleteInput((int)$_POST['input_id'])) {
            header("Location: $redirectUrl&msg=input_deleted"); exit;
        } else {
            $error = "Failed to delete input.";
        }
    }

    // --- OUTPUTS ---
    if (isset($_POST['add_output'])) {
        $isPrimary = isset($_POST['is_primary']) ? true : false;
        if ($outputManager->createOutput($recipeId, (int)$_POST['article_id'], (float)$_POST['quantity'], $_POST['unit'], $isPrimary)) {
            header("Location: $redirectUrl&msg=output_added"); exit;
        } else {
            $error = "Failed to add output.";
        }
    }
    if (isset($_POST['edit_output'])) {
        $isPrimary = isset($_POST['edit_is_primary']) ? true : false;
        if ($outputManager->updateOutput((int)$_POST['output_id'], null, (int)$_POST['edit_article_id'], (float)$_POST['edit_quantity'], $_POST['edit_unit'], $isPrimary)) {
            header("Location: $redirectUrl&msg=output_updated"); exit;
        } else {
            $error = "Failed to update output.";
        }
    }
    if (isset($_POST['delete_output'])) {
        if ($outputManager->deleteOutput((int)$_POST['output_id'])) {
            header("Location: $redirectUrl&msg=output_deleted"); exit;
        } else {
            $error = "Failed to delete output.";
        }
    }
}

// MSG handling
if (isset($_GET['msg'])) {
    $msgMap = [
        'input_added' => 'Input material added successfully.',
        'input_updated' => 'Input material updated.',
        'input_deleted' => 'Input material removed.',
        'output_added' => 'Recipe output added successfully.',
        'output_updated' => 'Recipe output updated.',
        'output_deleted' => 'Recipe output removed.'
    ];
    $message = $msgMap[$_GET['msg']] ?? '';
}

$inputs = $inputManager->listInputs($recipeId);
$outputs = $outputManager->listOutputs($recipeId);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>MES - Manage BOM</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<?= $siteBaseUrl ?>styles/backoffice.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <?php include INCLUDE_PATH . 'Sidebar.php'; ?>

    <div class="content">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <a href="cycles.php" class="btn btn-outline-secondary btn-sm mb-2"><i class="fa-solid fa-arrow-left"></i> Back to Cycles</a>
                <h1 class="mb-0">Manage Bill of Materials</h1>
                <p class="text-muted">Recipe Version: <strong><?= htmlspecialchars($recipe['Version']) ?></strong> | Target Product: <strong><?= htmlspecialchars($targetArticle['Name'] ?? 'Unknown') ?></strong></p>
            </div>
        </div>
        
        <?php if ($message): ?><div class="alert alert-success"><?= htmlspecialchars($message) ?></div><?php endif; ?>
        <?php if ($error): ?><div class="alert alert-danger"><?= htmlspecialchars($error) ?></div><?php endif; ?>

        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fa-solid fa-box-open me-2"></i>Inputs (Raw Materials)</h5>
                        <button class="btn btn-sm btn-light text-primary fw-bold" data-bs-toggle="modal" data-bs-target="#addInputModal"><i class="fa-solid fa-plus"></i> Add Input</button>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Article</th>
                                    <th>Qty / Unit</th>
                                    <th>Type</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if(empty($inputs)): ?>
                                    <tr><td colspan="4" class="text-center py-3 text-muted">No inputs defined.</td></tr>
                                <?php endif; ?>
                                <?php foreach ($inputs as $in): ?>
                                    <tr>
                                        <td class="fw-bold"><?= htmlspecialchars($in['ArticleName']) ?></td>
                                        <td><?= number_format($in['Quantity'], 4) ?> <?= htmlspecialchars($in['Unit']) ?></td>
                                        <td>
                                            <?php 
                                                $badgeClass = match($in['InputType']) {
                                                    'consumable' => 'bg-warning text-dark',
                                                    'resource' => 'bg-info text-dark',
                                                    default => 'bg-secondary'
                                                };
                                            ?>
                                            <span class="badge <?= $badgeClass ?>"><?= ucfirst($in['InputType']) ?></span>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#editInputModal<?= $in['InputID'] ?>"><i class="fa-solid fa-pen"></i></button>
                                            <form method="post" class="d-inline" onsubmit="return confirm('Remove this input?');">
                                                <input type="hidden" name="input_id" value="<?= $in['InputID'] ?>">
                                                <button type="submit" name="delete_input" class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>

                                    <div class="modal fade" id="editInputModal<?= $in['InputID'] ?>" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content text-start">
                                                <div class="modal-header"><h5 class="modal-title">Edit Input</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                                <form method="post">
                                                    <div class="modal-body">
                                                        <input type="hidden" name="input_id" value="<?= $in['InputID'] ?>">
                                                        <div class="mb-3">
                                                            <label class="form-label">Article</label>
                                                            <select name="edit_article_id" class="form-select" required>
                                                                <?php foreach ($articles as $a): ?>
                                                                    <option value="<?= $a['ArticleID'] ?>" <?= $a['ArticleID'] == $in['ArticleID'] ? 'selected' : '' ?>><?= htmlspecialchars($a['Name']) ?></option>
                                                                <?php endforeach; ?>
                                                            </select>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-6">
                                                                <label class="form-label">Quantity</label>
                                                                <input type="number" step="0.0001" name="edit_quantity" class="form-control" value="<?= $in['Quantity'] ?>" required>
                                                            </div>
                                                            <div class="col-6">
                                                                <label class="form-label">Unit</label>
                                                                <input type="text" name="edit_unit" class="form-control" value="<?= htmlspecialchars($in['Unit']) ?>" required>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3">
                                                            <label class="form-label">Type</label>
                                                            <select name="edit_input_type" class="form-select" required>
                                                                <option value="part" <?= $in['InputType'] == 'part' ? 'selected' : '' ?>>Part</option>
                                                                <option value="resource" <?= $in['InputType'] == 'resource' ? 'selected' : '' ?>>Resource</option>
                                                                <option value="consumable" <?= $in['InputType'] == 'consumable' ? 'selected' : '' ?>>Consumable</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer"><button type="submit" name="edit_input" class="btn btn-warning">Save Changes</button></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fa-solid fa-boxes-packing me-2"></i>Outputs (Yield)</h5>
                        <button class="btn btn-sm btn-light text-success fw-bold" data-bs-toggle="modal" data-bs-target="#addOutputModal"><i class="fa-solid fa-plus"></i> Add Output</button>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Article</th>
                                    <th>Qty / Unit</th>
                                    <th>Primary</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if(empty($outputs)): ?>
                                    <tr><td colspan="4" class="text-center py-3 text-muted">No outputs defined.</td></tr>
                                <?php endif; ?>
                                <?php foreach ($outputs as $out): ?>
                                    <tr>
                                        <td class="fw-bold"><?= htmlspecialchars($out['ArticleName']) ?></td>
                                        <td><?= number_format($out['Quantity'], 4) ?> <?= htmlspecialchars($out['Unit']) ?></td>
                                        <td>
                                            <?php if($out['IsPrimary']): ?>
                                                <i class="fa-solid fa-star text-warning" title="Primary Product"></i>
                                            <?php else: ?>
                                                <span class="text-muted"><i class="fa-regular fa-star"></i></span>
                                            <?php endif; ?>
                                        </td>
                                        <td class="text-end">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#editOutputModal<?= $out['OutputID'] ?>"><i class="fa-solid fa-pen"></i></button>
                                            <form method="post" class="d-inline" onsubmit="return confirm('Remove this output?');">
                                                <input type="hidden" name="output_id" value="<?= $out['OutputID'] ?>">
                                                <button type="submit" name="delete_output" class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>

                                    <div class="modal fade" id="editOutputModal<?= $out['OutputID'] ?>" tabindex="-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content text-start">
                                                <div class="modal-header"><h5 class="modal-title">Edit Output</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                                <form method="post">
                                                    <div class="modal-body">
                                                        <input type="hidden" name="output_id" value="<?= $out['OutputID'] ?>">
                                                        <div class="mb-3">
                                                            <label class="form-label">Article</label>
                                                            <select name="edit_article_id" class="form-select" required>
                                                                <?php foreach ($articles as $a): ?>
                                                                    <option value="<?= $a['ArticleID'] ?>" <?= $a['ArticleID'] == $out['ArticleID'] ? 'selected' : '' ?>><?= htmlspecialchars($a['Name']) ?></option>
                                                                <?php endforeach; ?>
                                                            </select>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-6">
                                                                <label class="form-label">Quantity</label>
                                                                <input type="number" step="0.0001" name="edit_quantity" class="form-control" value="<?= $out['Quantity'] ?>" required>
                                                            </div>
                                                            <div class="col-6">
                                                                <label class="form-label">Unit</label>
                                                                <input type="text" name="edit_unit" class="form-control" value="<?= htmlspecialchars($out['Unit']) ?>" required>
                                                            </div>
                                                        </div>
                                                        <div class="mb-3 form-check">
                                                            <input type="checkbox" class="form-check-input" id="editChkPrimary<?= $out['OutputID'] ?>" name="edit_is_primary" <?= $out['IsPrimary'] ? 'checked' : '' ?>>
                                                            <label class="form-check-label" for="editChkPrimary<?= $out['OutputID'] ?>">Primary Product</label>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer"><button type="submit" name="edit_output" class="btn btn-warning">Save Changes</button></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addInputModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">Add Recipe Input</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Article *</label>
                            <select name="article_id" class="form-select" required>
                                <option value="">Select Article...</option>
                                <?php foreach ($articles as $a): ?>
                                    <option value="<?= $a['ArticleID'] ?>"><?= htmlspecialchars($a['Name']) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Quantity *</label>
                                <input type="number" step="0.0001" name="quantity" class="form-control" value="1" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Unit *</label>
                                <input type="text" name="unit" class="form-control" value="unit" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Input Type</label>
                            <select name="input_type" class="form-select" required>
                                <option value="part">Part / Component</option>
                                <option value="resource">Resource</option>
                                <option value="consumable">Consumable</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer"><button type="submit" name="add_input" class="btn btn-primary">Add Input</button></div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addOutputModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header"><h5 class="modal-title">Add Recipe Output</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                <form method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Article *</label>
                            <select name="article_id" class="form-select" required>
                                <option value="">Select Article...</option>
                                <?php foreach ($articles as $a): ?>
                                    <option value="<?= $a['ArticleID'] ?>" <?= $a['ArticleID'] == $recipe['ArticleID'] ? 'selected' : '' ?>><?= htmlspecialchars($a['Name']) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                <label class="form-label">Quantity *</label>
                                <input type="number" step="0.0001" name="quantity" class="form-control" value="1" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label">Unit *</label>
                                <input type="text" name="unit" class="form-control" value="unit" required>
                            </div>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="chkPrimary" name="is_primary" checked>
                            <label class="form-check-label" for="chkPrimary">Primary Product</label>
                        </div>
                    </div>
                    <div class="modal-footer"><button type="submit" name="add_output" class="btn btn-success">Add Output</button></div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>