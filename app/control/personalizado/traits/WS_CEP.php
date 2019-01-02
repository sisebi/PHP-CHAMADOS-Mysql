<?php


trait WS_CEP {
    protected $CEP_SITE = 'http://viacep.com.br/ws/';
    protected $CEP_METHOD = '/json/';
    protected $cep;
    protected $results_string;
    protected function validaCEP($cep) {
        $formated_cep = preg_replace("/[^0-9]/", "", $cep);
        if (!preg_match('/^[0-9]{8}?$/', $formated_cep)) {
            throw new \Exception("CEP inválido");
        }
        $this->cep = $formated_cep;
    }
    protected function buscaSimples($cep) {
        $this->validaCEP($cep);
        $result = file_get_contents($this->CEP_SITE .
                $this->cep .
                $this->CEP_METHOD);
        return $result;
    }
    protected function buscaCur($cep) {
        $this->validaCEP($cep);
        $url = $this->CEP_SITE .
                $this->cep .
                $this->CEP_METHOD;
        $ch = curl_init($url);
//        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $resposta = curl_exec($ch);
        curl_close($ch);
        return $resposta;
    }
    protected function buscaInfoCEP() {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HEADER, false);
        $url = $this->CEP_SITE . $this->cep . $this->CEP_METHOD . $this->outros_parametros;
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSLVERSION, 3);
        $this->results_string = curl_exec($ch);
        curl_close($ch);
    }
    protected function fazRequisicaoFacade($cep) {
        $this->validaCEP($cep);
        $this->buscaInfoCEP();
    }
    public function retornaConteudoRequisicao() {
        if ($this->results_string == "") {
            throw new \Exception('Não houve requisição através do método retornaCEP');
        }
        return $this->results_string;
    }
//    abstract public function retornaCEP($cep);
}
