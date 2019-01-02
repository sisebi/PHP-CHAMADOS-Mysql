<?php

use Adianti\Base\TStandardFormList;
use Adianti\Wrapper\BootstrapFormBuilder;
use Adianti\Widget\Form\TEntry;
use Adianti\Widget\Form\TLabel;
use Adianti\Validator\TRequiredValidator;
use Adianti\Control\TAction;
use Adianti\Widget\Wrapper\TQuickGrid;
use Adianti\Widget\Datagrid\TDataGridAction;
use Adianti\Wrapper\BootstrapDatagridWrapper;

class FormEmpresaLista extends TStandardFormList{
    protected $form;
    protected $datagrid;
    protected $painelPagina;
    private $base = 'changeman';
    private $active = 'Empresa_Model';
    
    public function __construct() {
        parent::__construct();
        parent::setDatabase($this->base);
        parent::setActiveRecord($this->active);
        
        $this->form = new BootstrapFormBuilder('frm_empresa');
        $this->form->setFormTitle('Empresa');
        
        //Edit
        $id = new TEntry('id');
        $id->setEditable(false);
        $id->setSize('25%');
        $lb_id = new TLabel('Codigo');
        
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
        
        //Botao
        $btnSalvar = new TAction(array($this,'onSave'));
        $btnNovo = new TAction(array($this,'onEdit'));
        $btnRecarregar = new TAction(array($this,'onReload'));
        
        //Adicionar Componentes Form
        $this->form->addFields([$lb_id],[$id]);
        $this->form->addFields([$lb_nome],[$nome]);
        $this->form->addFields([$lb_fantasia],[$fantasia]);
        $this->form->addAction('Salvar', $btnSalvar, 'fa:floppy-o');
        $this->form->addAction('Novo', $btnNovo, 'fa:eraser red');
        
        //Grid
        $grid = new TQuickGrid();
        $grid->addQuickColumn('Codigo', 'id', 'center', 50, $btnRecarregar,array('order','id'));
        $grid->addQuickColumn('Nome', 'nome', 'left', null, $btnRecarregar,array('order','nome'));
        $grid->addQuickColumn('Fantasia', 'fantasia', 'left', null, $btnRecarregar,array('order','fantasia'));
        $grid->addQuickAction('Editar', new TDataGridAction(array($this,'onEdit')), 'id', 'fa:pencil-square-o blue fa-lg');
        $grid->addQuickAction('Deletar', new TDataGridAction(array($this,'onDelete')), 'id', 'fa:trash-o red fa-lg');
        
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
    
    function chamar() {
        $classe = new Filial_Model();
        $class_methods = get_class_methods($classe);

        echo '-------FUNÇÃO---------------';
        foreach ($class_methods as $method_name) {
            echo "$method_name<br>";
        }
        echo '--------VARIAVEL--------------';
        var_dump(get_object_vars($classe));
        
        echo '--------PROPERTIS--------------';
        $class_vars = get_class_vars(get_class($classe));
        foreach ($class_vars as $name => $value) {
            echo "$name : $value<br>";
        }

    }
}
