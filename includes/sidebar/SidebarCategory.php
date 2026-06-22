<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/mes/includes/sidebar/SidebarElement.php';

class SidebarCategory extends SidebarElement
{
    private $id;
    private $text;
    private $icon;
    private $items = [];

    public function __construct($id, $text, $icon)
    {
        $this->id = $id;
        $this->text = $text;
        $this->icon = $icon;
    }

    public function addLink($href, $text, $icon = 'fa-circle-dot')
    {
        $this->items[] = new SidebarLink($href, $text, $icon);
        return $this;
    }

    private function isOpen()
    {
        foreach ($this->items as $item) {
            if ($item->isActive())
                return true;
        }
        return false;
    }

    public function render()
    {
        $isOpen = $this->isOpen();
        $collapsedClass = $isOpen ? '' : 'collapsed';
        $showClass = $isOpen ? 'show' : '';
        $ariaExpanded = $isOpen ? 'true' : 'false';

        $html = sprintf(
            '<a class="nav-link %s" data-bs-toggle="collapse" href="#%s" aria-expanded="%s">
                <i class="fa-solid %s me-2" style="width: 20px; text-align: center;"></i> 
                %s
                <i class="fa-solid fa-chevron-down float-end mt-1" style="font-size: 0.8rem;"></i>
            </a>',
            $collapsedClass,
            $this->id,
            $ariaExpanded,
            $this->icon,
            htmlspecialchars($this->text)
        );

        $html .= sprintf('<div class="collapse %s" id="%s"><div class="ms-3 border-start ps-2">', $showClass, $this->id);

        foreach ($this->items as $item) {
            $html .= $item->render();
        }

        $html .= '</div></div>';
        return $html;
    }
}
?>