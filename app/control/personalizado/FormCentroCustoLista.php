<?php

use Adianti\Base\TStandardFormList;
use Adianti\Wrapper\BootstrapFormBuilder;
use Adianti\Widget\Form\TEntry;
use Adianti\Widget\Form\TLabel;
use Adianti\Validator\TRequiredValidator;
use Adianti\Control\TAction;
use Adianti\Widget\Wrapper\TQuickGrid;

class FormCentroCustoLista extends TStandardFormList{
    protected $form;
    protected $datagrid;
    protected $painelPagina;
    private $base = 'changeman';
    private $active = 'Centro_Custo_Model';
    
    public function __construct() {
        parent::__construct();
        parent::setDatabase($this->base);
        parent::setActiveRecord($this->active);
        
        $this->form = new BootstrapFormBuilder('frm_cCusto');
        $this->form->setFormTitle('CentroCusto');
        
        //Edit
        $id = new TEntry('id');
        $id->setEditable(FALSE);
        $id->setSize('25%');
        $lb_id = new TLabel('Codigo');
        
        //Edit
        $descricao = new TEntry('description');
        $descricao->addValidation('Descricão',new TRequiredValidator());
        $descricao->forceUpperCase();
        $descricao->setSize('100%');
        $lb_descr = new TLabel('Descrição');
        
        //Botao
        $btnSalvar = new TAction(array($this,'onSave'));
        $btnNovo = new TAction(array($this,'onEdit'));
        $btnRecarregar = new TAction(array($this,'onReload'));
        
        //Adicionar Componenentes no Form
        $this->form->addFields([$lb_id],[$id]);
        $this->form->addFields([$lb_descr],[$descricao]);
        $this->form->addAction('Salvar', $btnSalvar,'fa:floppy-o');
        $this->form->addAction('Novo', $btnNovo, 'fa:eraser red');
        
        $grid = new TQuickGrid();
        $grid->addQuickColumn('Codigo', 'id', 'center', 50, $btnRecarregar,array('order', 'id'));
        $grid->addQuickColumn('Descrição', 'description', 'left', null, $btnRecarregar,array('order', 'description'));
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
    
}
