@AbapCatalog.sqlViewName: 'ZVW_T_HR_AP_PRJ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Cubo - Total Horas Apontadas Projeto'
@Metadata.ignorePropagatedAnnotations: true
define view Z_TOTAL_HORAS_APONTADA_PROJETO
  as select from zdlrick_007 as z007
    join         zdlrick_009 as z009 on z007.id = z009.ticket
{
  key  projeto         as Projeto,
       sum(z009.horas) as HorasApontadas
}
where aprovacao = 'A'
group by
  projeto
