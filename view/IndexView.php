<?php

require_once('View.php');

class IndexView extends View {
    
    public $modules_dir = 'view/';
    
    public function __construct() {
        parent::__construct();
    }
    
    public function fetch() {

        // Содержимое корзины
        $this->design->assign('cart',		$this->cart->get_cart());
        
        // Категории товаров
        $this->count_visible($this->categories->get_categories_tree());
        $this->design->assign('categories', $this->categories->get_categories_tree());
        
        // Страницы
        $pages = $this->pages->get_pages(array('visible'=>1));
        $this->design->assign('pages', $pages);

        $is_mobile = $this->design->is_mobile();
        $is_tablet = $this->design->is_tablet();
        $this->design->assign('is_mobile',$is_mobile);
        $this->design->assign('is_tablet',$is_tablet);
        
        // Текущий модуль (для отображения центрального блока)
        $module = $this->request->get('module', 'string');
        $module = preg_replace("/[^A-Za-z0-9]+/", "", $module);
        
        // Если не задан - берем из настроек
        if(empty($module)) {
            return false;
        }
        //$module = $this->settings->main_module;
        
        // Создаем соответствующий класс
        if (is_file($this->modules_dir."$module.php")) {
            include_once($this->modules_dir."$module.php");
            if (class_exists($module)) {
                $this->main = new $module($this);
            } else {
                return false;
            }
        } else {
            return false;
        }
        
        // Создаем основной блок страницы
        if (!$content = $this->main->fetch()) {
            return false;
        }
        
        // Передаем основной блок в шаблон
        $this->design->assign('content', $content);
        
        // Передаем название модуля в шаблон, это может пригодиться
        $this->design->assign('module', $module);
        
        // Создаем текущую обертку сайта (обычно index.tpl)
        $wrapper = $this->design->get_var('wrapper');
        if(is_null($wrapper)) {
            $wrapper = 'index.tpl';
        }
        
        if(!empty($wrapper)) {
            return $this->body = $this->design->fetch($wrapper);
        } else {
            return $this->body = $content;
        }
    }

    private function count_visible($categories = array()) {
        $all_categories = $this->categories->get_categories();
        foreach ($categories as $category) {
            $category->has_children_visible = 0;
            if ($category->parent_id && $category->visible) {
                $all_categories[$category->parent_id]->has_children_visible = 1;
            }
            if ($category->subcategories) {
                $this->count_visible($category->subcategories);
            }
        }
    }

}
