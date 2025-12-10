CLASS lcl_business_pj DEFINITION.
  PUBLIC SECTION.
    DATA: lt_projetos TYPE TABLE OF zdlrick_003,
          lo_projeto  TYPE REF TO zdlrickcl_002.

    METHODS:
      get_projetos,
      constructor,
      set_projetos IMPORTING VALUE(it_projetos) TYPE any,
      delete_projetos IMPORTING VALUE(it_deleted_rows) TYPE lvc_t_moce.

ENDCLASS.


CLASS lcl_business_pj IMPLEMENTATION.

  METHOD constructor.

    lo_projeto = NEW zdlrickcl_002( iv_table = `ZDLRICK_003` ).

  ENDMETHOD.

  METHOD get_projetos.
    lo_projeto->read( IMPORTING et_data = lt_projetos ).
  ENDMETHOD.


  METHOD set_projetos.

    CHECK it_projetos IS NOT INITIAL.

    GET TIME STAMP FIELD DATA(lv_time_stamp).
    DATA(lt_mod_projetos) = CORRESPONDING zdlricktt_003( it_projetos ).

    LOOP AT lt_mod_projetos INTO DATA(ls_projeto).

      IF ls_projeto-id EQ space.
        DATA(ls_return_create) = lo_projeto->create( CHANGING is_data = ls_projeto ).
      ELSE.
        DATA(ls_return_update) =   lo_projeto->update( CHANGING is_data = ls_projeto ).
      ENDIF.

    ENDLOOP.

    MESSAGE `Registro inserido com sucesso` TYPE 'S'.

    COMMIT WORK.


  ENDMETHOD.

  METHOD delete_projetos.

    CHECK it_deleted_rows[] IS NOT INITIAL.

    LOOP AT it_deleted_rows INTO DATA(ls_deleted_rows).

      DATA(ls_projeto) = lt_projetos[ ls_deleted_rows-row_id ].

       DATA(ls_return_delete) =   lo_projeto->delete( EXPORTING is_data = ls_projeto ).

      CLEAR ls_projeto.
    ENDLOOP.

    MESSAGE `Registro deletado com sucesso` TYPE 'S'.

    COMMIT WORK.


  ENDMETHOD.

ENDCLASS.
