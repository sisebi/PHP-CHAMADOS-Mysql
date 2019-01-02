<?php

use Adianti\Base\TStandardFormList;
use Adianti\Wrapper\BootstrapFormBuilder;
use Adianti\Widget\Form\TEntry;
use Adianti\Validator\TRequiredValidator;
use Adianti\Widget\Form\TLabel;
use Adianti\Control\TAction;
use Adianti\Widget\Wrapper\TQuickGrid;
use Adianti\Widget\Datagrid\TDataGridAction;
use Adianti\Wrapper\BootstrapDatagridWrapper;
use Adianti\Widget\Wrapper\TDBCombo;
use Adianti\Database\TTransaction;
use Adianti\Database\TCriteria;
use Adianti\Widget\Dialog\TMessage;


//$city_id = new TDBCombo('city_id', 'samples', 'City', 'id', 'name', 'name', $filter);
//$customer_id = new TDBCombo('customer_id', 'samples', 'Customer', 'id', 'name', 'name', $filter);


class FormDepartamentoLista extends TStandardFormList{
    protected $form;
    protected $datagrid;
    protected $painelPagina;
    private $formNome = 'frm_departamento';
    private $base = 'changeman'; 
    private $active = 'Departamento_Model';


    public function __construct() {
        
        parent::__construct();
        parent::setDatabase($this->base);
        parent::setActiveRecord($this->active);
        $this->form = new BootstrapFormBuilder($this->formNome);
        $this->form->setFormTitle('Departamento');
        
        //edits
        $id = new TEntry('id');
        $id->setEditable(False);
        $id->setSize('25%');
        
        $descritpion = new TEntry('description');
        $descritpion->addValidation('Descrição', new TRequiredValidator());
        $descritpion->setSize('100%');
        $descritpion->forceUpperCase();
        
        $cCusto = new TDBCombo('centro_custo_id', $this->base, 'Centro_Custo_Model', 'id', 'mostratrDescricao','description');
        $cCusto->addValidation('Centro de Custo', new TRequiredValidator());
        $cCusto->setSize('50%');
        $cCusto->enableSearch();
        
        $empresa = new TDBCombo('empresa_id', $this->base, 'Empresa_Model', 'id', 'mostrarNome','nome');
        $empresa->addValidation('Empresa', new TRequiredValidator());
        $empresa->setSize('70%');
        $empresa->enableSearch();
        
        $filial = new TDBCombo('filial_id', $this->base, 'Filial_Model', 'id', 'nome','nome');
        $filial->addValidation('Filial', new TRequiredValidator());
        $filial->setSize('100%');
        $filial->enableSearch();
        
        //Botoes
        $btnSalvar = new TAction(array($this, 'onSave'));
        $btnSalvar->setProperty(' class', 'btn btn-sm btn-primary');
        $btnNovo = new TAction(array($this,'onEdit'));
        $btnNovo->setProperty('class', 'btn btn-sm btn-success');
        $btnRecarregar = new TAction(array($this,'onReload'));
       
        //Adicionando componentes no Form
        $this->form->addFields([new TLabel('Codigo')],[$id]);
        $this->form->addFields([new TLabel('Descrição')],[$descritpion]);
        $this->form->addFields([new TLabel('Empresa')],[$empresa]);
        $this->form->addFields([new TLabel('Filial')],[$filial]);
        $this->form->addFields([new TLabel('Centro de Custo')],[$cCusto]);
        $this->form->addAction('Salvar', $btnSalvar,'fa:floppy-o');
        $this->form->addAction('Novo', $btnNovo, 'fa:eraser red');
        
        $empresa->setChangeAction(new TAction(array($this,'onChangeEmpresa')));
        
        $grid = new TQuickGrid();
        $grid->addQuickColumn('Codigo', 'id', 'center', 50, $btnRecarregar,array('order', 'id'));
        $grid->addQuickColumn('Descrição', 'description', 'left', null, $btnRecarregar,array('order', 'description'));
//Achar Solução aparecer nome
//        $grid->addQuickColumn('Centro Custo', 'centro_custo_id', 'left', null, $btnRecarregar,array('order', 'centro_custo_id'));
        $grid->addQuickAction('Editar', new TDataGridAction(array($this, 'onEdit')), 'id', 'fa:pencil-square-o blue fa-lg');
        $grid->addQuickAction('Deletar', new TDataGridAction(array($this, 'onDelete')), 'id', 'fa:trash-o red fa-lg');
        
        $this->datagrid = new BootstrapDatagridWrapper($grid);
        $this->datagrid->width = '100%';
        $this->datagrid->setHeight(320);
        $this->datagrid->createModel();
        
        $this->painelPagina = new TPageNavigation;
        $this->painelPagina->setAction($btnRecarregar);
        $this->painelPagina->setWidth($this->datagrid->getWidth());
        
        $panel = new TPanelGroup;
        $panel->add($this->datagrid);
        $panel->addFooter($this->painelPagina);
        
        $container = new TVBox;
        $container->style = 'width: 100%';
        $container->add(new TXMLBreadCrumb('menu.xml', __CLASS__));
        $container->add($this->form);
        $container->add($panel);
        
        parent::add($container);
        
        
        
    }
    
    static function onChangeEmpresa($param) {
        TDBCombo::clearField('frm_departamento', 'filial');
        try {
            TDBCombo::disableField('frm_departamento', 'filial');
            TTransaction::open('changeman');
            if (!empty($param['empresa_id'])){
                $criteria = TCriteria::create(['empresa_id'=>$param['empresa_id']]);
                TDBCombo::reloadFromModel('frm_departamento', 'filial_id', 'changeman', 'Filial_Model', 'id', '{fantasia} ({nome})', 'fantasia', $criteria, true);
            }else{
                TDBCombo::clearField('frm_departamento', 'filial');
            }
        } catch (Exception $ex) {
            new TMessage('error', $ex->getMessage());
        } finally {
            TDBCombo::enableField('frm_departamento', 'filial');
            TTransaction::close();
        }
    }
    
}
