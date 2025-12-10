CLASS lcl_business_se DEFINITION.
  PUBLIC SECTION.
    DATA:  lt_setor_empresa TYPE TABLE OF zdlrick_002.

    METHODS:
      get_setor_empresa,
      set_setor_empresa IMPORTING VALUE(it_setor_empresa) TYPE any,
      delete_setor_empresa IMPORTING VALUE(it_deleted_rows) TYPE lvc_t_moce.

ENDCLASS.


CLASS lcl_business_se IMPLEMENTATION.

  METHOD get_setor_empresa.
    SELECT * FROM zdlrick_002 INTO TABLE lt_setor_empresa.
  ENDMETHOD.


  METHOD set_setor_empresa.
    CHECK it_setor_empresa IS NOT INITIAL.

    GET TIME STAMP FIELD DATA(lv_time_stamp).
    DATA(lt_mod_setor_empresa) = CORRESPONDING zdlricktt_002( it_setor_empresa ).

    LOOP AT lt_mod_setor_empresa INTO DATA(ls_setor_empresa).
      ls_setor_empresa-criado_em = lv_time_stamp.
      ls_setor_empresa-criado_por = sy-uname.

      ls_setor_empresa-modificado_em = lv_time_stamp.
      ls_setor_empresa-modificado_por = sy-uname.


      MODIFY zdlrick_002 FROM ls_setor_empresa.
    ENDLOOP.

    MESSAGE `Registro inserido com sucesso` TYPE 'S'.

    COMMIT WORK.


  ENDMETHOD.

  METHOD delete_setor_empresa.

    CHECK it_deleted_rows[] IS NOT INITIAL.

    LOOP AT it_deleted_rows INTO DATA(ls_deleted_rows).

      DATA(ls_setor_empresa) = lt_setor_empresa[ ls_deleted_rows-row_id ].

      DELETE FROM zdlrick_002 WHERE setor = ls_setor_empresa-setor.

      CLEAR ls_setor_empresa.
    ENDLOOP.

    MESSAGE `Registro deletado com sucesso` TYPE 'S'.

    COMMIT WORK.


  ENDMETHOD.

ENDCLASS.
