<?php

require_once('api/Okay.php');

class SettingsFeedAdmin extends Okay {

    /*Настройки выгрузки в яндекс*/
    public function fetch() {
        return $this->design->fetch('pro_only.tpl');
    }

}
