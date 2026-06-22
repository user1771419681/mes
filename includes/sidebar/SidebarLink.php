<?php 
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarHeader.php';
class SidebarLink extends SidebarElement
{
    public $href;
    private $text;
    private $icon;

    public function __construct($href, $text, $icon = 'fa-circle-dot')
    {
        $this->href = $href;
        $this->text = $text;
        $this->icon = $icon;
    }

    public function isActive()
    {
        return $GLOBALS['current_page'] === basename($this->href, '.php');
    }

    public function render()
    {
        $activeClass = $this->isActive() ? 'active' : '';
        return sprintf(
            '<a class="nav-link %s" href="/mes/%s">
                <i class="fa-solid %s me-2" style="width: 20px; text-align: center;"></i> %s
            </a>',
            $activeClass,
            $this->href,
            $this->icon,
            htmlspecialchars($this->text)
        );
    }
}
?>