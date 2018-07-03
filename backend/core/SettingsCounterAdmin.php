<?php

require_once('api/Okay.php');

class SettingsCounterAdmin extends Okay {

    /*Настройки счетчиков*/
    public function fetch() {
        return $this->design->fetch('pro_only.tpl');
    }
}
