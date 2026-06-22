<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarElement.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarHeader.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarLink.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarCategory.php';
$GLOBALS['current_page'] = basename($_SERVER['SCRIPT_NAME'], '.php');

$menu = [];

$menu[] = new SidebarLink('dashboard.php', 'Dashboard', 'fa-gauge-high');

//$menu[] = new SidebarHeader('Planning');
$catPlanning = new SidebarCategory('planningMenu', 'ERP & Planning', 'fa-calendar-days');
$catPlanning->addLink('pages/planning/production-orders.php', 'Production Orders', 'fa-file-invoice');
$catPlanning->addLink('planning.php', 'Shift Scheduler', 'fa-clock');
$menu[] = $catPlanning;

//$menu[] = new SidebarHeader('Execution');

$catShop = new SidebarCategory('shopFloorMenu', 'Shop Floor', 'fa-person-digging');
$catShop->addLink('pages/production/operator-logs.php', 'Operator Logs', 'fa-clipboard-user');
$catShop->addLink('pages/production/production-logs.php', 'Job Runs', 'fa-play');
$catShop->addLink('pages/production/batches.php', 'Batches / Labels', 'fa-barcode');
$menu[] = $catShop;

$catQuality = new SidebarCategory('qualityMenu', 'Quality & Downtime', 'fa-triangle-exclamation');
$catQuality->addLink('pages/production/machine-stops.php', 'Machine Stops', 'fa-stopwatch');
$catQuality->addLink('pages/production/rejects.php', 'Scrap / Rejects', 'fa-ban');
$catQuality->addLink('pages/production/adjustments.php', 'Qty Adjustments', 'fa-sliders');
$menu[] = $catQuality;

$catInv = new SidebarCategory('invMenu', 'Inventory', 'fa-boxes-stacked');
$catInv->addLink('pages/production/raw-materials.php', 'Raw Materials', 'fa-dolly');
$menu[] = $catInv;

$menu[] = new SidebarLink('data-analysis.php', 'Data Analysis', 'fa-chart-line');

//$menu[] = new SidebarHeader('Administration');

$catAssets = new SidebarCategory('assetMenu', 'Factory Assets', 'fa-city');
$catAssets->addLink('pages/database/plants.php', 'Plants', 'fa-industry');
$catAssets->addLink('pages/database/sections.php', 'Sections', 'fa-layer-group');
$catAssets->addLink('pages/database/machines.php', 'Machines', 'fa-robot');
$catAssets->addLink('pages/database/countries.php', 'Countries', 'fa-globe');
$catAssets->addLink('pages/database/cities.php', 'Cities', 'fa-location-dot');
$menu[] = $catAssets;

$catMaster = new SidebarCategory('masterMenu', 'Master Data', 'fa-database');
$catMaster->addLink('pages/database/articles.php', 'Articles / Products', 'fa-cube');
$catMaster->addLink('pages/database/users.php', 'Users / Operators', 'fa-users');
$catMaster->addLink('pages/database/cycles.php', 'Cycles', 'fa-rotate');
$menu[] = $catMaster;

$catSys = new SidebarCategory('systemMenu', 'System & Security', 'fa-shield-halved');
$catSys->addLink('pages/database/reject-categories.php', 'Reject Categories', 'fa-list');
$catSys->addLink('pages/database/reject-reasons.php', 'Reject Reasons', 'fa-list-check');
$catSys->addLink('pages/security/api-management.php', 'API Keys', 'fa-key');
$catSys->addLink('pages/security/api-usage-audits.php', 'Audit Logs', 'fa-file-shield');
$catSys->addLink('pages/system/wago-logs.php', 'WAGO Simulator', 'fa-server');
$menu[] = $catSys;

$logoutLink = new SidebarLink('logout.php', 'Log Out', 'fa-right-from-bracket');

?>

<div class="sidebar">
    <div class="sidebar-header">
        <i class="fa-solid fa-industry me-2"></i> MES Backoffice
    </div>

    <nav class="nav flex-column">
        <?php
        foreach ($menu as $element) {
            echo $element->render();
        }
        ?>

        <hr class="text-light">

        <?php echo $logoutLink->render(); ?>

      <script>
         <?php if (isset($_SESSION['fresh_api_key'])): ?>
                const sessionKey = "<?= $_SESSION['fresh_api_key'] ?>";
                    if (!localStorage.getItem('mes_api_key')) {
                        localStorage.setItem('mes_api_key', sessionKey);
                    }
                    <?php unset($_SESSION['fresh_api_key']); ?>
            <?php endif; ?>

            if (typeof $ !== 'undefined') {
                $.ajaxSetup({
                    beforeSend: function (xhr) {
                        const key = localStorage.getItem('mes_api_key');
                        if (key) xhr.setRequestHeader('X-API-KEY', key);
                    }
                });
            }
        </script>
    </nav>
</div>