class ZDLRICKCL_TEST_SQUAD definition
  public
  final
  create public
  for testing RISK LEVEL HARMLESS.

public section.

  data GO_SQUAD type ref to ZDLRICKCL_004 .
protected section.
private section.

  methods SETUP .
  methods TEARDOWN .
  methods HAS_NO_DESCRIPTION
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



CLASS ZDLRICKCL_TEST_SQUAD IMPLEMENTATION.


  method DELETE.
      DATA(squad) = VALUE ZDLRICK_004(
       descricao = `Equipe de Teste`

       ).

   ME->go_squad->create(
    CHANGING IS_DATA = squad ).

   DATA(ls_result) =  ME->go_squad->delete( squad ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  endmethod.


  method EDIT.
      DATA(squad) = VALUE ZDLRICK_004(
       descricao = `Equipe de Teste`

       ).

   ME->go_squad->create(
    CHANGING IS_DATA = squad ).

   squad-descricao = `Equipe de Teste Modificada`.

   DATA(ls_result) =  ME->go_squad->update(
      CHANGING IS_DATA = squad ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  endmethod.


  method FILLED.
       DATA(squad) = VALUE ZDLRICK_004(
       descricao = `Equipe de Teste`

       ).

   DATA(ls_result) = ME->go_squad->create(
    CHANGING IS_DATA = squad ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  endmethod.


  method HAS_NO_DESCRIPTION.
        DATA(squad) = VALUE ZDLRICK_004(
        DESCRICAO                  =  ``
       ).

   DATA(ls_result) = ME->go_squad->create(
    CHANGING IS_DATA = squad ).


    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  endmethod.


  method SETUP.
    me->go_squad = NEW ZDLRICKCL_004( 'ZDLRICK_004' ).
  endmethod.


  method TEARDOWN.
    FREE: ME->go_squad.
  endmethod.
ENDCLASS.
