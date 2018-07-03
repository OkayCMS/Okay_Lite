<?php

require_once('api/Okay.php');

class SeoFilterPatternsAdmin extends Okay {

    public function fetch() {
        return $this->design->fetch('pro_only.tpl');
    }
}
