<?php

use Adianti\Control\TWindow;
use Adianti\Widget\Form\TEntry;
use Adianti\Control\TAction;
use Adianti\Wrapper\BootstrapFormBuilder;
use Adianti\Widget\Form\TLabel;

class Endereco extends TWindow{
    protected $frm;
    
    public function __construct($dadosForm) {
        
        parent::__construct();
        parent::setSize(800, null);
        parent::setTitle('Buscar Cep');
        parent::setProperty('class', 'window_modal');
        
        $this->frm = new BootstrapFormBuilder('frm_cep');
//        $this->form->setFormTitle('Endereço');
        
        $cep = new TEntry('cep');
        $cep->setSize('25%');
        $cep->setMask('999.99-999', true);
        $lb_cep = new TLabel('Cep');
        
        $rua = new TEntry('logradouro');
        $rua->setEditable(false);
        $rua->forceUpperCase();
        $rua->setSize('100%');
//        $rua->setValue($dadosForm['fantasia']);
        $lb_rua = new TLabel('Rua');
        
        $complemento = new TEntry('complemento');
        $complemento->setEditable(false);
        $complemento->forceUpperCase();
        $complemento->setSize('100%');
        $lb_compl = new TLabel('Complemento');
        
        $bairro = new TEntry('bairro');
        $bairro->setEditable(false);
        $bairro->forceUpperCase();
        $bairro->setSize('100%');
        $lb_bairro = new TLabel('Bairro');
        
        $localidade = new TEntry('localidade');
        $localidade->setEditable(false);
        $localidade->forceUpperCase();
        $localidade->setSize('100%');
        $lb_localidade = new TLabel('Localidade');
        
        $uf = new TEntry('uf');
        $uf->setEditable(false);
        $uf->forceUpperCase();
        $uf->setSize('100%');
        $lb_uf = new TLabel('Uf');
        
        $unidade = new TEntry('unidade');
        $unidade->setEditable(false);
        $unidade->forceUpperCase();
        $unidade->setSize('100%');
        $lb_unidade = new TLabel('Unid.');
        
        $ibge = new TEntry('ibge');
        $ibge->setEditable(false);
        $ibge->forceUpperCase();
        $ibge->setSize('100%');
        $lb_ibge = new TLabel('Ibge');
        
        $gia = new TEntry('gia');
        $gia->setEditable(false);
        $gia->forceUpperCase();
        $gia->setSize('100%');
        $lb_gia = new TLabel('Gia');
        
        $btnBuscarCep = new TAction(array($this,'buscarCep'));
        $btnOk = new TAction(array($this,'carregarEndereco'));
        
        $this->frm->addFields([$lb_cep],[$cep]);
        $this->frm->addFields([$lb_rua],[$rua]);
        $this->frm->addFields([$lb_bairro],[$bairro],[$lb_compl],[$complemento]);
        $this->frm->addFields([$lb_localidade],[$localidade],[$lb_uf],[$uf],[$lb_unidade],[$unidade]);
        $this->frm->addFields([$lb_ibge],[$ibge],[$lb_gia],[$gia]);
        $this->frm->addAction('Buscar', $btnBuscarCep);
        $this->frm->addAction('Ok', $btnOk);
        
        $container = new TVBox;
        $container->style = 'width: 100%';
        $container->add($this->frm);
        
        parent::add($container);
                
    }
    
    function buscarCep($dadosForm) {
        $viaCep = new formViaCepLista();
        $ender = $viaCep->retornaCepSimples($dadosForm['cep']);
        
        $dados = $this->frm->getData();
        $dados->logradouro = $ender['logradouro'];
        $dados->complemento = $ender['complemento'];
        $dados->bairro = $ender['bairro'];
        $dados->localidade = $ender['localidade'];
        $dados->uf = $ender['uf'];
        $dados->unidade = $ender['unidade'];
        $dados->ibge = $ender['ibge'];
        $dados->gia = $ender['gia'];
        $this->frm->setData($dados);
    }
    
    function carregarEndereco($dadosForm) {
//        if (isset($dadosForm)){
////            new TMessage('info', 'Tem Valores ');
//            TSession::setValue('logradouro', $dadosForm->logradouro);
//            TSession::setValue('complemento', $dadosForm->complemento);
//            TSession::setValue('bairro', $dadosForm->bairro);
//            TSession::setValue('uf', $dadosForm->uf);
//            TSession::setValue('unidade', $dadosForm->unidade);
//            TSession::setValue('ibge', $dadosForm->ibge);
//            TSession::setValue('gia', $dadosForm->gia);
//        }
        TWindow::closeWindow();
//        var_dump($dadosForm);
//        $this->form->fantasia = $dadosForm['logradouro'];
    }
    
}
