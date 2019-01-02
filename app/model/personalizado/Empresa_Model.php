<?php

use Adianti\Database\TRecord; 

class Empresa_Model extends TRecord{
    const TABLENAME = 'empresa';
    const PRIMARYKEY = 'id';
    const IDPOLICY = 'max';
    
    function get_mostrarNome() {
        return $this->nome;
    }
    
    function get_mostrarFantasia() {
        return $this->fantasia;
    }
    
}
