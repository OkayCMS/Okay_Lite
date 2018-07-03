<?php

require_once('api/Okay.php');

class RobotsAdmin extends Okay {

    public function fetch() {
        return $this->design->fetch('pro_only.tpl');
    }
}
