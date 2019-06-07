<?php

class Recaptcha extends Okay {

    private $secret_key;
    private $url = 'https://www.google.com/recaptcha/api/siteverify';
    private $response;

    public function __construct() {
        
        switch ($this->settings->captcha_type) {
            case 'invisible':
                $this->secret_key = $this->settings->secret_recaptcha_invisible;
                break;
            case 'v2':
                $this->secret_key = $this->settings->secret_recaptcha;
                break;
        }
    }

    public function check() {
        
        $this->request();
        
        // В случае инвалидных ключей пропускаем пользователя
        if (isset($this->response['error-codes']) && reset($this->response['error-codes']) == 'invalid-input-secret') {
            return true; // TODO add to events list
        }
        
        if ($this->response['success'] == false) {
            return false;
        }
        
        return true;
    }
    
    private function request() {
        $curl = curl_init($this->url);

        $params = http_build_query(array(
            'secret'   => $this->secret_key,
            'response' => $this->get_response_key(),
            'remoteip' => $_SERVER['REMOTE_ADDR']
        ));

        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $params);
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        $response = curl_exec($curl);
        curl_close($curl);
        
        $this->response = json_decode($response, true);
    }

    private function get_response_key() {
        if ($this->settings->captcha_type == 'v2' || $this->settings->captcha_type == 'invisible'){
            return $this->request->post('g-recaptcha-response');
        }
    }
    
}
