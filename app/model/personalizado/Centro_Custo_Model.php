<?php
use Adianti\Database\TRecord;

class Centro_Custo_Model extends TRecord{
    const TABLENAME = 'centro_custo';
    const PRIMARYKEY = 'id';
    const IDPOLICY = 'max';
    
    function get_mostratrDescricao() {
        return $this->description;
    }
}
