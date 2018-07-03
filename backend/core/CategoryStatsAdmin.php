<?php

require_once('api/Okay.php');

class CategoryStatsAdmin extends Okay {
    
    public function fetch() {
        return $this->design->fetch('pro_only.tpl');
    }
}
