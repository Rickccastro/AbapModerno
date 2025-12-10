@AbapCatalog.sqlViewName: 'ZC_DLPM_PROJECT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Consumer - Projetos'
@Metadata.ignorePropagatedAnnotations: true
define view ZC_PROJECTS as select from ZIDLPM_RICK_PROJECTS as zp
{
    @UI:{ selectionField:[{position: 10}], lineItem:[{ position: 10, label: 'ID'}]}
    key Id,
    @UI:{ selectionField:[{position: 20}], lineItem:[{ position: 20, label: 'Título'}]}
    Titulo,
    @UI:{ lineItem:[{ position: 30, label: 'ID'}]}
    Descricao,
    @UI:{ selectionField:[{position: 30}], lineItem:[{ position: 40, label: 'Modulo'}]}
    Modulo,
    @UI:{ selectionField:[{position: 40}], lineItem:[{ position: 50, label: 'Setor'}]}
    @ObjectModel.text.element: ['SetorText']
    Setor,
    zp.SetorText,
    @UI:{ selectionField:[{position: 50}], lineItem:[{ position: 60, label: 'Equipe'}]}
    @ObjectModel.text.element: ['EquipeText']
    Equipe,
    zp.EquipeText,
    Responsavel,
    DataInicio,
    DataFimEsperada,
    DataFimReal,
    CriadoPor,
    CriadoEm,
    ModificadoPor,
    ModificadoEm,
    /*Associations*/
    _z002,
    _z004
   
}
