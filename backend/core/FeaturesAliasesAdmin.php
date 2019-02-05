<?php

require_once('api/Okay.php');

class FeaturesAliasesAdmin extends Okay {

    public function fetch() {
        return $this->design->fetch('pro_only.tpl');
    }
}
