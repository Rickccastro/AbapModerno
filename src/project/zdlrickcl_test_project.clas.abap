class ZDLRICKCL_TEST_PROJECT definition
  public
  final
  create public
  for testing
  risk level harmless .

public section.

  data GO_PROJECT type ref to ZDLRICKCL_002 .
protected section.
private section.

  methods SETUP .
  methods TEARDOWN .
  methods HAS_NO_TITLE
  for testing
    raising
      ZDLRICKCL_003 .
  methods HAS_NO_DESCRIPTION
  for testing
    raising
      ZDLRICKCL_003 .
  methods HAS_NO_SQUAD
  for testing
    raising
      ZDLRICKCL_003 .
  methods HAS_NO_OWNER
  for testing
    raising
      ZDLRICKCL_003 .
  methods FILLED
  for testing
    raising
      ZDLRICKCL_003 .
  methods EDIT
  for testing
    raising
      ZDLRICKCL_003 .
  methods DELETE
  for testing
    raising
      ZDLRICKCL_003 .
ENDCLASS.



CLASS ZDLRICKCL_TEST_PROJECT IMPLEMENTATION.


  METHOD delete.

   DATA(project) = VALUE ZDLRICK_003(
        TITULO                     = `Titulo`
        DESCRICAO                  = `DESCRICAO`
        MODULO                     = 'FI'
        SETOR                      = '1'
        EQUIPE                     = '1'
        RESPONSAVEL                = `MVMFONTES`
        DATA_INICIO                = `20251120`
        DATA_FIM_ESPERADA          = `20251120`
        DATA_FIM_REAL              = ''
       ).

    DATA(ls_result_create) = ME->go_project->create(
    CHANGING IS_DATA = project ).


   project-id = ls_result_create-message_v1.
   project-descricao = `DELETED`.

    DATA(ls_result_delete) = ME->go_project->delete( project ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).

  ENDMETHOD.


  method EDIT.
        DATA(project) = VALUE ZDLRICK_003(
        TITULO                     = `Titulo`
        DESCRICAO                  = `DESCRICAO`
        MODULO                     = 'FI'
        SETOR                      = '1'
        EQUIPE                     = '1'
        RESPONSAVEL                = `MVMFONTES`
        DATA_INICIO                = `20251120`
        DATA_FIM_ESPERADA          = `20251120`
        DATA_FIM_REAL              = ''
       ).

   DATA(ls_result_create) = ME->go_project->create(
    CHANGING IS_DATA = project ).


   project-id = ls_result_create-message_v1.
   project-descricao = `Modified`.

    DATA(ls_result_update) = ME->go_project->update(
    CHANGING IS_DATA = project ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).
  endmethod.


  method FILLED.
        DATA(project) = VALUE ZDLRICK_003(
        TITULO                     = `Titulo`
        DESCRICAO                  = 'DESCRICAO'
        MODULO                     = 'FI'
        SETOR                      = '1'
        EQUIPE                     = '1'
        RESPONSAVEL                = 'MVMFONTES'
        DATA_INICIO                = '20251120'
        DATA_FIM_ESPERADA          = '20251120'
        DATA_FIM_REAL              = ''
       ).

   DATA(ls_result) = ME->go_project->create(
    CHANGING IS_DATA = project ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  endmethod.


  method HAS_NO_DESCRIPTION.
        DATA(project) = VALUE ZDLRICK_003(
        TITULO                     = `Titulo`
        DESCRICAO                  =  ``
        MODULO                     = 'FI'
        SETOR                      = '1'
        EQUIPE                     = '1'
        RESPONSAVEL                = 'MVMFONTES'
        DATA_INICIO                = '20251120'
        DATA_FIM_ESPERADA          = '20251120'
        DATA_FIM_REAL              = ''
       ).

   DATA(ls_result) = ME->go_project->create(
    CHANGING IS_DATA = project ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  endmethod.


  method HAS_NO_OWNER.
        DATA(project) = VALUE ZDLRICK_003(

        DESCRICAO                  = 'DESCRICAO'
        MODULO                     = 'FI'
        SETOR                      = '1'
        EQUIPE                     = '1'
        RESPONSAVEL                = ''
        DATA_INICIO                = '20251120'
        DATA_FIM_ESPERADA          = '20251120'
        DATA_FIM_REAL              = ''
       ).

   DATA(ls_result) = ME->go_project->create(
    CHANGING IS_DATA = project ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  endmethod.


  method HAS_NO_SQUAD.
        DATA(project) = VALUE ZDLRICK_003(

        DESCRICAO                  = 'DESCRICAO'
        MODULO                     = 'FI'
        SETOR                      = '1'
        EQUIPE                     = ''
        RESPONSAVEL                = 'MVMFONTES'
        DATA_INICIO                = '20251120'
        DATA_FIM_ESPERADA          = '20251120'
        DATA_FIM_REAL              = ''
       ).

   DATA(ls_result) = ME->go_project->create(
    CHANGING IS_DATA = project ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  endmethod.


  method HAS_NO_TITLE.

    DATA(project) = VALUE ZDLRICK_003(

        DESCRICAO                  = 'DESCRICAO'
        MODULO                     = 'FI'
        SETOR                      = '1'
        EQUIPE                     = '1'
        RESPONSAVEL                = 'MVMFONTES'
        DATA_INICIO                = '20251120'
        DATA_FIM_ESPERADA          = '20251120'
        DATA_FIM_REAL              = ''
       ).

   DATA(ls_result) = ME->go_project->create(
    CHANGING IS_DATA = project ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).

  endmethod.


  method SETUP.
    ME->go_project = NEW ZDLRICKCL_002( `ZDLRICK_003` ).
  endmethod.


  method TEARDOWN.
    FREE: ME->go_project.
  endmethod.
ENDCLASS.
