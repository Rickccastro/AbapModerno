@AbapCatalog.sqlViewName: 'ZVW_DLPM_PROJECT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Projeto'
@Metadata.ignorePropagatedAnnotations: true
define view ZIDLPM_RICK_PROJECTS as select from zdlrick_003 as zp
association [1..1] to zdlrick_002 as _z002 on zp.setor = _z002.setor
association [1..1] to zdlrick_004 as _z004 on zp.equipe = _z004.id  
{
    key id as Id,
    titulo as Titulo,
    descricao as Descricao,
    modulo as Modulo,
    setor as Setor,
    _z002.descricao as SetorText,
    equipe as Equipe,
    _z004.descricao as EquipeText,
    responsavel as Responsavel,
    data_inicio as DataInicio,
    data_fim_esperada as DataFimEsperada,
    data_fim_real as DataFimReal,
    criado_por as CriadoPor,
    criado_em as CriadoEm,
    modificado_por as ModificadoPor,
    modificado_em as ModificadoEm,
    /*Associations*/
    _z002,
    _z004
}
