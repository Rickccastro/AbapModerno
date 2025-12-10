CLASS lcl_business_ms DEFINITION.
    PUBLIC SECTION.
    DATA:  lt_modulo_sap TYPE TABLE OF zdlrick_001.

    METHODS:
      get_modulo_sap,
      set_modulo_sap IMPORTING VALUE(it_modulo_sap) TYPE any,
      delete_modulo_sap IMPORTING VALUE(it_deleted_rows) TYPE lvc_t_moce.

ENDCLASS.


CLASS lcl_business_ms IMPLEMENTATION.

  METHOD get_modulo_sap.
    SELECT * FROM zdlrick_001 INTO TABLE lt_modulo_sap.
  ENDMETHOD.


  METHOD set_modulo_sap.

    CHECK it_modulo_sap IS NOT INITIAL.

    GET TIME STAMP FIELD DATA(lv_time_stamp).
    DATA(lt_mod_modulo_sap) = CORRESPONDING zdlricktt_001( it_modulo_sap ).

    LOOP AT lt_mod_modulo_sap INTO DATA(ls_modulo_sap).
" OBS
      ls_modulo_sap-criado_em = lv_time_stamp.
      ls_modulo_sap-criado_por = sy-uname.

      ls_modulo_sap-modificado_em = lv_time_stamp.
      ls_modulo_sap-modificado_por = sy-uname.


      MODIFY zdlrick_001 FROM ls_modulo_sap.
    ENDLOOP.

    MESSAGE `Registro inserido com sucesso` TYPE 'S'.

    COMMIT WORK.


  ENDMETHOD.

  METHOD delete_modulo_sap.

    CHECK it_deleted_rows[] IS NOT INITIAL.

    LOOP AT it_deleted_rows INTO DATA(ls_deleted_rows).

      DATA(ls_modulo_sap) = lt_modulo_sap[ ls_deleted_rows-row_id ].

      DELETE FROM zdlrick_001 WHERE modulo = ls_modulo_sap-modulo.

      CLEAR ls_modulo_sap.
    ENDLOOP.

    MESSAGE `Registro deletado com sucesso` TYPE 'S'.

    COMMIT WORK.


  ENDMETHOD.

ENDCLASS.
