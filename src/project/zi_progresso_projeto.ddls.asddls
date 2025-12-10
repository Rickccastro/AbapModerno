@AbapCatalog.sqlViewName: 'ZI_PROG_PROJECT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Progresso Projeto'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PROGRESSO_PROJETO
  as select from ZIDLPM_RICK_PROJECTS as p
  association [1..1] to Z_TOTAL_HORAS_APONTADA_PROJETO as _thap on $projection.Id = _thap.Projeto
  association [1..1] to Z_TOTAL_HORAS_PROJETO_CUBE     as _thp  on $projection.Id = _thp.Projeto
{

      @EndUserText: { label: 'ID', quickInfo: 'ID'}
  key Id,
      @EndUserText: { label: 'Título', quickInfo: 'Título'}
      Titulo,
      @EndUserText: { label: 'Total Horas Apontadas', quickInfo: 'Total Horas Apontadas'}
      _thap.HorasApontadas                                          as TotalHorasApontadas,
      @EndUserText: { label: 'Total Horas', quickInfo: 'Total Horas'}
      _thp.HoursExpected                                            as TotalHoras,
      @EndUserText: { label: 'Progresso', quickInfo: 'Progresso'}
      cast (cast(_thap.HorasApontadas * 100 as abap.decfloat34)  /
      cast ( _thp.HoursExpected as abap.decfloat34)  as abap.int1 ) as Progresso,
      /*Associations*/
      _thap,
      _thp
}
