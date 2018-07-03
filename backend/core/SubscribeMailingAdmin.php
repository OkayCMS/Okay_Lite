<?php

require_once('api/Okay.php');

class SubscribeMailingAdmin extends Okay {
    
    /*Отображение подписчиков сайта*/
    public function fetch() {
        return $this->body = $this->design->fetch('pro_only.tpl');
    }
    
}
