<?php

use Adianti\Database\TRecord;

class Filial_Model extends TRecord{
    const TABLENAME = 'filial';
    const PRIMARYKEY = 'id';
    const IDPOLICY = 'max';

    function get_mostrarNome() {
        return $this->nome;
    }

    function get_mostrarFantasia() {
        return $this->fantasia;
    }
    
    function get_mostrarEmpresa() {
        return $this->empresa_id;
    }
    
}
