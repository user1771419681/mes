<?php 
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarElement.php';

class SidebarHeader extends SidebarElement
{
    private $text;

    public function __construct($text)
    {
        $this->text = $text;
    }

    public function render()
    {
        return '<div class="sidebar-category">' . htmlspecialchars($this->text) . '</div>';
    }
}
?>