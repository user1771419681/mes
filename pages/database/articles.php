<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/Config.php';
require_once INCLUDE_PATH . 'IsAdmin.php';
require_once INCLUDE_PATH . 'Database.php';
require_once INCLUDE_PATH . 'ArticleManager.php'; 
include_once INCLUDE_PATH . 'HeadHelper.php';

$isAdmin = isAdmin();

$articleManager = new ArticleManager($pdo);

$search = $_GET['search'] ?? null;
$filterQC = $_GET['qc'] ?? null;

$articles = $articleManager->listArticles($search, $filterQC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['delete']) && $isAdmin) {
        $articleId = (int) $_POST['article_id'];
        if ($articleManager->deleteArticle($articleId)) {
            $message = "Article deleted successfully.";
        } else {
            $message = "Failed to delete article.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<?php renderHead("Products", $siteBaseUrl) ?>

<body>
    <?php include INCLUDE_PATH . 'Sidebar.php'; ?>

    <div class="content">
        <h1>Articles</h1>
        <?php if (isset($message)): ?>
            <div class="alert alert-info"><?php echo htmlspecialchars($message); ?></div>
        <?php endif; ?>

        <div class="card mb-4">
            <div class="card-header bg-light"><i class="fa-solid fa-filter me-1"></i> Search & Filter</div>
            <div class="card-body py-3">
                <form method="GET" class="row g-2 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label small">Search Article Name</label>
                        <input type="text" name="search" class="form-control form-control-sm" placeholder="e.g. Widget" value="<?= htmlspecialchars($search ?? '') ?>">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small">Quality Control</label>
                        <select name="qc" class="form-select form-select-sm">
                            <option value="">All Statuses</option>
                            <option value="Passed" <?= $filterQC === 'Passed' ? 'selected' : '' ?>>Passed</option>
                            <option value="Failed" <?= $filterQC === 'Failed' ? 'selected' : '' ?>>Failed</option>
                            <option value="Pending" <?= $filterQC === 'Pending' ? 'selected' : '' ?>>Pending</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary btn-sm w-100"><i class="fa-solid fa-search"></i> Filter</button>
                    </div>
                    <div class="col-md-2">
                         <a href="articles.php" class="btn btn-secondary btn-sm w-100">Clear</a>
                    </div>
                </form>
            </div>
        </div>

        <?php if ($isAdmin): ?>
            <div class="mb-3">
                <?php include INCLUDE_PATH . 'pages/articles/articles-add.php'; ?>
            </div>
        <?php endif; ?>

        <h3 class="mt-4">Article List</h3>
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Image Path</th>
                        <th>Quality Control</th>
                        <th>Created</th>
                        <th>Updated</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (count($articles) > 0): ?>
                        <?php foreach ($articles as $article): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($article['ArticleID']); ?></td>
                                <td class="fw-bold"><?php echo htmlspecialchars($article['Name']); ?></td>
                                <td><?php echo htmlspecialchars($article['Description'] ?? 'N/A'); ?></td>
                                <td><?php echo htmlspecialchars($article['ImagePath'] ?? 'N/A'); ?></td>
                                <td>
                                    <?php if($article['QualityControl'] == 'Passed'): ?>
                                        <span class="badge bg-success">Passed</span>
                                    <?php elseif($article['QualityControl'] == 'Failed'): ?>
                                        <span class="badge bg-danger">Failed</span>
                                    <?php else: ?>
                                        <span class="badge bg-warning text-dark"><?php echo htmlspecialchars($article['QualityControl']); ?></span>
                                    <?php endif; ?>
                                </td>
                                <td><?php echo htmlspecialchars($article['CreatedAt']); ?></td>
                                <td><?php echo htmlspecialchars($article['UpdatedAt']); ?></td>
                                <td>
                                    <?php if ($isAdmin): ?>
                                        <button type="button" class="btn btn-sm btn-warning" data-bs-toggle="modal"
                                            data-bs-target="#editModal<?php echo $article['ArticleID']; ?>">
                                            <i class="fa-solid fa-pen"></i> Edit
                                        </button>
                                        <?php include INCLUDE_PATH . 'pages/articles/articles-edit.php'; ?>
                                    <?php endif; ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="8" class="text-center text-muted">No articles found.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>