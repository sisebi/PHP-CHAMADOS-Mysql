<?php

use Adianti\Database\TRecord;

class Departamento_Model extends TRecord{
    
    const TABLENAME = 'departamento';
    const PRIMARYKEY= 'id';
    const IDPOLICY =  'max'; 
    
    function get_mostarDescricao() {
        return $this->description;
    }
    function get_mostrarCentroCusto() {
        return $this->centro_custo_id['description'];
    }
    
}
