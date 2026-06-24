<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarElement.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarHeader.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarLink.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarCategory.php';

$GLOBALS['current_page'] = basename($_SERVER['SCRIPT_NAME'], '.php');

$menuConfig = [
    [
        'type' => 'link',
        'href' => 'dashboard.php',
        'text' => 'Dashboard',
        'icon' => 'fa-gauge-high'
    ],
    
    [
        'type' => 'category',
        'id' => 'planningMenu',
        'text' => 'Planning & Orders',
        'icon' => 'fa-calendar-days',
        'links' => [
            ['pages/planning/production-orders.php', 'Production Orders', 'fa-file-invoice'],
            ['planning.php', 'Shift Scheduler', 'fa-clock']
        ]
    ],
    [
        'type' => 'category',
        'id' => 'shopFloorMenu',
        'text' => 'Shop Floor & Logs',
        'icon' => 'fa-person-digging',
        'links' => [
            ['pages/production/operator-logs.php', 'Operator Logs', 'fa-clipboard-user'],
            ['pages/production/production-logs.php', 'Job Runs', 'fa-play'],
            ['pages/production/batches.php', 'Batches / Labels', 'fa-barcode'],
            ['pages/production/machine-stops.php', 'Machine Stops', 'fa-stopwatch'],
            ['pages/production/rejects.php', 'Scrap / Rejects', 'fa-ban'],
            ['pages/production/adjustments.php', 'Qty Adjustments', 'fa-sliders']
        ]
    ],

    [
        'type' => 'link',
        'href' => 'pages/production/raw-materials.php',
        'text' => 'Raw Materials Inventory',
        'icon' => 'fa-boxes-stacked'
    ],
    [
        'type' => 'link',
        'href' => 'data-analysis.php',
        'text' => 'Data Analysis',
        'icon' => 'fa-chart-line'
    ],

    [
        'type' => 'category',
        'id' => 'assetMenu',
        'text' => 'Factory Infrastructure',
        'icon' => 'fa-city',
        'links' => [
            ['pages/database/plants.php', 'Plants', 'fa-industry'],
            ['pages/database/sections.php', 'Sections', 'fa-layer-group'],
            ['pages/database/machines.php', 'Machines', 'fa-robot'],
            ['pages/database/countries.php', 'Countries', 'fa-globe'],
            ['pages/database/cities.php', 'Cities', 'fa-location-dot']
        ]
    ],
    [
        'type' => 'category',
        'id' => 'masterMenu',
        'text' => 'App Master Data',
        'icon' => 'fa-database',
        'links' => [
            ['pages/database/articles.php', 'Articles / Products', 'fa-cube'],
            ['pages/database/users.php', 'Users / Operators', 'fa-users'],
            ['pages/database/cycles.php', 'Cycles', 'fa-rotate']
        ]
    ],

    [
        'type' => 'category',
        'id' => 'systemMenu',
        'text' => 'Platform Control',
        'icon' => 'fa-shield-halved',
        'links' => [
            ['pages/database/reject-categories.php', 'Reject Categories', 'fa-list'],
            ['pages/database/reject-reasons.php', 'Reject Reasons', 'fa-list-check'],
            ['pages/security/api-management.php', 'API Keys', 'fa-key'],
            ['pages/security/api-usage-audits.php', 'Audit Logs', 'fa-file-shield'],
            ['pages/system/wago-logs.php', 'WAGO Simulator', 'fa-server']
        ]
    ]
];

$menu = [];
foreach ($menuConfig as $node) {
    switch ($node['type']) {
        case 'link':
            $menu[] = new SidebarLink($node['href'], $node['text'], $node['icon']);
            break;
            
        case 'header':
            $menu[] = new SidebarHeader($node['text']);
            break;
            
        case 'category':
            $cat = new SidebarCategory($node['id'], $node['text'], $node['icon']);
            foreach ($node['links'] as $link) {
                $cat->addLink($link[0], $link[1], $link[2]);
            }
            $menu[] = $cat;
            break;
    }
}

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