<?php

use Adianti\Base\TStandardForm;
use Adianti\Wrapper\BootstrapFormBuilder;
use Adianti\Widget\Form\TEntry;
use Adianti\Widget\Form\TLabel;
use Adianti\Validator\TRequiredValidator;
use Adianti\Control\TAction;
use Adianti\Widget\Wrapper\TQuickGrid;
use Adianti\Widget\Datagrid\TDataGridAction;
use Adianti\Wrapper\BootstrapDatagridWrapper;
use Adianti\Widget\Wrapper\TDBCombo;
use Adianti\Widget\Form\TButton;
use Adianti\Widget\Container\TPanelGroup;
use Adianti\Widget\Datagrid\TPageNavigation;

class FormFilial extends TStandardForm{
    protected $form;
    protected $form2;
    protected $form3;
    protected $datagrid;
    protected $painelPagina;
    private $base = 'changeman';
    private $active = 'Filial_Model';

    use WS_CEP;
    
    public function __construct() {
        parent::__construct();
        parent::setDatabase($this->base);
        parent::setActiveRecord($this->active);
                        
        $this->form = new BootstrapFormBuilder('frm_Filial');
        $this->form->setFormTitle('Filial');
        
        
        //Edit
        $id = new TEntry('id');
        $id->setEditable(false);
        $id->setSize('25%');
        $lb_id = new TLabel('Codigo');
        
        //Exemplo Seek com Button
//        $empresa = new TDBSeekButton('empresa_id', $this->base, 'frm_Filial', 'Empresa_Model', 'nome');
//        $empresa->addValidation('Empresa', new TRequiredValidator());
//        $empresa->setSize('100%');
//        $empresa_nome = new TEntry('empresa_nome');
//        $empresa_nome->setEditable(false);
//        $empresa_nome->setSize('100%');
//        $empresa->setAuxiliar($empresa_nome);
//        $lb_empresa = new TLabel('Empresa');
        
        //Exemplo Combo
        $empresa = new TDBCombo('empresa_id', $this->base, 'Empresa_Model', 'id', 'mostrarFantasia');
        $empresa->addValidation('Empresa', new TRequiredValidator());
        $empresa->setSize('100%');
        $empresa->enableSearch();
        $lb_empresa = new TLabel('Empresa');
        
        //Edit
        $cnpj = new TEntry('cnpj');
        $cnpj->addValidation('Cnpj', new TRequiredValidator());
        $cnpj->setSize('100%');
        $cnpj->setMask('99.999.999/999-99', TRUE);
        $lb_cnpj = new TLabel('Cnpj');
        
        //Edit
        $ie = new TEntry('ie');
        $ie->addValidation('I.Estadual', new TRequiredValidator());
        $ie->setSize('100%');
        $ie->forceUpperCase();
        $lb_ie = new TLabel('I.Estadual');
        
        //Edit
        $nome = new TEntry('nome');
        $nome->addValidation('Nome', new TRequiredValidator());
        $nome->setSize('100%');
        $nome->forceUpperCase();
        $lb_nome = new TLabel('Nome');
        
        //Edit
        $fantasia = new TEntry('fantasia');
        $fantasia->addValidation('Fantasia', new TRequiredValidator());
        $fantasia->setSize('100%');
        $fantasia->forceUpperCase();
        $lb_fantasia = new TLabel('Fantasia');
        
        //---------ENDEREÇO-------
        $cep = new TEntry('cep');
        $cep->setSize('25%');
        $cep->setMask('999.99-999', true);
        $lb_cep = new TLabel('Cep');
        
        $rua = new TEntry('logradouro');
        $rua->setEditable(false);
        $rua->forceUpperCase();
        $rua->setSize('100%');
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
        $uf->setSize('30%');
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
        
        $nr = new TEntry('numero');
        $nr->addValidation('Numero', new TRequiredValidator());
        $nr->forceUpperCase();
        $nr->setSize('100%');
        $lb_nr = new TLabel('Numero');
        
        //Botao
        $btnSalvar = new TAction(array($this,'onSave'));
        $btnSalvar->class = 'btn btn-sm btn-primary';
        $btnNovo = new TAction(array($this,'onEdit'));
//        $btnRecarregar = new TAction(array($this,'onReload'));
        $btnBuscarCep = TButton::create('btnBuscarCep', [$this, 'buscarCep'], 'Buscar Cep', '');
        $btnBuscarCep->setProperty('class', 'btn btn-success btn-lg');
        
        //Adicionar Componentes Form
        $this->form->addFields([$lb_id],[$id]);
        $this->form->addFields([$lb_empresa],[$empresa]);
        $this->form->addFields([$lb_cnpj],[$cnpj],[$lb_ie],[$ie]);
        $this->form->addFields([$lb_nome],[$nome]);
        $this->form->addFields([$lb_fantasia],[$fantasia]);
        
        //--------ENDEREÇO-------
        $label = new TLabel('Endereço', '#7D78B6', 12, 'bi');
        $label->style='text-align:left;border-bottom:1px solid #c0c0c0;width:100%';
        $this->form->addContent([$label]);
        $this->form->addFields([$lb_cep],[$cep,$btnBuscarCep]);
        $this->form->addFields([$lb_rua],[$rua]);
        $this->form->addFields([$lb_nr],[$nr],[$lb_compl],[$complemento]);
        $this->form->addFields([$lb_bairro],[$bairro]);
        $this->form->addFields([$lb_localidade],[$localidade]);
        $this->form->addFields([$lb_uf],[$uf]);
        $this->form->addFields([$lb_ibge],[$ibge],[$lb_gia],[$gia],[$lb_unidade],[$unidade]);
        
        $this->form->addAction('Salvar', $btnSalvar, 'fa:floppy-o');
        $this->form->addAction('Novo', $btnNovo, 'bs:plus-sign green');
        
        $container = new TVBox;
        $container->style = 'width: 100%';
        $container->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $container->add($this->form);
        
        parent::add($container);
        
    }
    
    public function abrirTelaCep() {
      $frm = new Endereco([]);
      $frm->setIsWrapped(TRUE);
      $frm->show(); 
    }
    
    function buscarCep($dadosForm) {
        $cep = strlen(str_replace('-', '', str_replace('.', '', $dadosForm['cep'])));
        $dados = $this->form->getData(); 
        if ($cep == 8 ){
            $this->CEP_METHOD = '/json/'; 
            $json = $this->buscaCur($dadosForm['cep']);
            $ender = json_decode($json,true); 
            if (!empty($ender['logradouro']))
                {
                $dados = $this->form->getData();
                $dados->logradouro = $ender['logradouro'];
                $dados->complemento = $ender['complemento'];
                $dados->bairro = $ender['bairro'];
                $dados->localidade = $ender['localidade'];
                $dados->uf = $ender['uf'];
                $dados->unidade = $ender['unidade'];
                $dados->ibge = $ender['ibge'];
                $dados->gia = $ender['gia'];
                $this->form->setData($dados);                        
            }else{
              new TMessage('info','Cep Não Encotrado :'. $dadosForm['cep']);                        
            }
        }else{
            new TMessage('error','Cep inválido :'. $dadosForm['cep']);
        }
        $this->form->setData($dados);
               
    }
    
    
}
