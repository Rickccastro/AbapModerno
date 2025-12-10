*&---------------------------------------------------------------------*
*& Report ZDLRICKP_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdlrickp_001.

" Equipe

" Projeto

" Ticket


SELECTION-SCREEN: BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-001.
  PARAMETERS: cb_clear AS CHECKBOX.
SELECTION-SCREEN: END OF BLOCK b0.

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.
  PARAMETERS: cb_gener AS CHECKBOX.
SELECTION-SCREEN: END OF BLOCK b1.


class lcl_main definition.

  public section.

  TYPES: tyt_ids TYPE TABLE OF ZDLRICKEL_004 WITH EMPTY KEY.

  methods: run,
  clear_tables,
  generate_data,
  generate_squads  RETURNING VALUE(rv_squad_id) TYPE ZDLRICKEL_004,
  generate_project IMPORTING iv_squad_id TYPE ZDLRICKEL_004
                   RETURNING VALUE(rv_project_id) TYPE ZDLRICKEL_004,
  generate_tickets IMPORTING iv_project_id TYPE ZDLRICKEL_004
                   RETURNING VALUE(rt_tickets) TYPE TYT_IDS,
  generate_hours   IMPORTING it_tickets_id TYPE TYT_IDS.


  protected section.
  private   section.

endclass.

class lcl_main implementation.

method run.
  generate_data( ).
  clear_tables( ).
endmethod.

method clear_tables.

  CHECK CB_CLEAR EQ ABAP_TRUE.

  DELETE FROM ZDLRICK_003. " Projeto
  DELETE FROM ZDLRICK_004. " Equipe
  DELETE FROM ZDLRICK_005. " Equipe Perfil
  DELETE FROM ZDLRICK_007. " Ticket
  DELETE FROM ZDLRICK_009. " Hora

  COMMIT WORK AND WAIT.


endmethod.

method generate_data.

   CHECK cb_gener EQ abap_true.
   DATA(lv_squad_id) = generate_squads( ).
   DATA(lv_project_id) = generate_project( lv_squad_id ).
   DATA(lt_tickets) = generate_tickets( lv_project_id ).
   generate_hours( lt_tickets ).

endmethod.

method generate_squads.
   data(lo_squad) = NEW ZDLRICKCL_004(`ZDLRICK_004`).

   DATA(ls_squad_1) = value ZDLRICK_004( descricao = `Equipe Carga 1 ` ).

   DATA(ls_return_squad_1) = lo_squad->create( CHANGING is_data = ls_squad_1 ).

   rv_squad_id = ls_return_squad_1-message_v1.

   DATA(ls_squad_profile_1) = VALUE ZDLRICK_005(
    equipe = rv_squad_id
    usuario = `CONSULTANT `
    perfil = `2`
    ).

   MODIFY ZDLRICK_005 FROM ls_squad_profile_1.

   DATA(ls_squad_profile_2) = VALUE ZDLRICK_005(
    equipe = rv_squad_id
    usuario = `ADMIN`
    perfil = `1 `
    ).

   MODIFY ZDLRICK_005 FROM ls_squad_profile_2.


endmethod.


METHOD generate_project.

  DATA(lo_project) = NEW ZDLRICKCL_002( `ZDLRICK_003` ).

  DATA(ls_project) = VALUE ZDLRICK_003(
    titulo = `Projeto Carga 1 `
    descricao = `TESTANDO CARGA 1 `
    modulo = `FI`
    setor = '4'
    equipe = iv_squad_id
    responsavel = sy-uname
    data_inicio = sy-datum
    data_fim_real = sy-datum + 10
   ).



  DATA(ls_return) = lo_project->create( CHANGING is_data = ls_project ).

  rv_project_id = ls_return-message_v1.

ENDMETHOD.



METHOD generate_tickets.

  DATA(lo_ticket) = NEW ZDLRICKCL_006( `ZDLRICK_007` ).

  DATA(ls_ticket_1) = VALUE ZDLRICK_007(
  titulo = `Task Carga Dados 1 `
  descricao = `Ticket 1 `
  projeto = iv_project_id
  responsavel = sy-uname
  hours_expected = 20
  status = `1`
  ).

   DATA(ls_return) = lo_ticket->create( CHANGING is_data = ls_ticket_1 ).
   APPEND ls_return-message_v1 TO rt_tickets.


  DATA(ls_ticket_2) = VALUE ZDLRICK_007(
  titulo = `Task Carga Dados 2 `
  descricao = `Ticket 2 `
  projeto = iv_project_id
  responsavel = sy-uname
  hours_expected = 10
  status = `1`
  ).

   DATA(ls_return_2) = lo_ticket->create( CHANGING is_data = ls_ticket_2 ).
   APPEND ls_return_2-message_v1 TO rt_tickets.


ENDMETHOD.

METHOD generate_hours.
  DATA(lo_hour) = NEW ZDLRICKCL_007(`ZDLRICK_009`).

  DATA(lv_hour_1) = VALUE ZDLRICK_009(
    ticket = it_tickets_id[ 1 ]
    usuario = `CONSULTANT`
    horas = `1`
    descricao  = `HORAS APONTADAS 1 `
   ).

  DATA(ls_return_1)  = lo_hour->create( CHANGING is_data  = lv_hour_1 ).
  lo_hour->approve_hour( EXPORTING iv_approve = 'A'  CHANGING cs_data = lv_hour_1 ).

    DATA(lv_hour_2) = VALUE ZDLRICK_009(
    ticket = it_tickets_id[ 1 ]
    usuario = `CONSULTANT`
    horas = `2`
    descricao  = `HORAS APONTADAS 2 `
   ).

  DATA(ls_return_2)  = lo_hour->create( CHANGING is_data  = lv_hour_2 ).
  lo_hour->approve_hour( EXPORTING iv_approve = 'A'  CHANGING cs_data = lv_hour_2 ).

  DATA(lv_hour_3) = VALUE ZDLRICK_009(
    ticket = it_tickets_id[ 1 ]
    usuario = `CONSULTANT`
    horas = `2`
    descricao  = `HORAS APONTADAS 2 `
   ).

  DATA(ls_return_3)  = lo_hour->create( CHANGING is_data  = lv_hour_3 ).
  lo_hour->approve_hour( EXPORTING iv_approve = 'R'  CHANGING cs_data = lv_hour_3 ).

ENDMETHOD.

endclass.



start-of-selection.

DATA(lo_main) = NEW lcl_main( ).

lo_main->run( ).
