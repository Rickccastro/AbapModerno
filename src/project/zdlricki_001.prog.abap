*&---------------------------------------------------------------------*
*& Modulpool ZDLRICKI_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM zdlricki_001.

" Componentes  da tela - Telas -> Layout
"     1- Quadrado
DATA: go_custom_control TYPE REF TO cl_gui_custom_container,
      "     2- Lista
      go_grid           TYPE REF TO cl_gui_alv_grid,
      "     3- Caracteristicas de Colunas
      gt_fieldcat       TYPE lvc_t_fcat,
      "     4- Caracteristicas da Lista
      gs_layout         TYPE lvc_s_layo.


INCLUDE: zdlricki_001_se,
         zdlricki_001_ms,
         zdlricki_001_pj.

CLASS lcl_business DEFINITION.

  PUBLIC SECTION.
    DATA: lo_business_ms TYPE REF TO lcl_business_ms,
          lo_business_pj TYPE REF TO lcl_business_pj,
          lo_business_se TYPE REF TO lcl_business_se.

    DATA: lv_screen        TYPE string.

    METHODS: constructor IMPORTING VALUE(iv_screen) TYPE string,
      run,
      run_project,
      run_setor_empresa,
      run_modulo_sap,
      active_change_handle,
      refresh,
      "     Metodo disparado quando o evento da classe
      "     cl_gui_alv_grid->check_changed_data( ) é chamado.
      handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed.



  PROTECTED SECTION.
  PRIVATE   SECTION.

ENDCLASS.

CLASS lcl_business IMPLEMENTATION.

  METHOD constructor.
    lv_screen = iv_screen.
    lo_business_pj = NEW lcl_business_pj( ).
    lo_business_ms = NEW lcl_business_ms( ).
    lo_business_se = NEW lcl_business_se( ).

  ENDMETHOD.

  METHOD run.
    CALL METHOD (lv_screen).
  ENDMETHOD.


  METHOD run_project.
    CHECK go_custom_control IS INITIAL.

    go_custom_control = NEW cl_gui_custom_container(`CC_PROJETO`).

    go_grid = NEW cl_gui_alv_grid( i_parent = go_custom_control ).

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = `ZDLRICK_003`
      CHANGING
        ct_fieldcat      = gt_fieldcat.

    LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).

      CASE <fs_fieldcat>-fieldname.
        WHEN 'TITULO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'DESCRICAO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'MODULO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'SETOR'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'EQUIPE'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'RESPONSAVEL'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'DATA_INICIO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'DATA_FIM_ESPERADA'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'DATA_FIM_REAL'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'MODIFICADO_POR'.
          <fs_fieldcat>-reptext = 'Mod.Por'.
          <fs_fieldcat>-scrtext_s = 'Mod.Por'.
          <fs_fieldcat>-scrtext_l = 'Modificado Por'.
          <fs_fieldcat>-scrtext_m = 'Modificado Por'.
        WHEN 'MODIFICADO_EM'.
          <fs_fieldcat>-scrtext_s = 'Mod.Em'.
          <fs_fieldcat>-scrtext_l = 'Modificado Em'.
          <fs_fieldcat>-scrtext_m = 'Modificado Em'.
        WHEN OTHERS.
          <fs_fieldcat>-no_out = 'X'.
      ENDCASE.

    ENDLOOP.


    go_grid->set_table_for_first_display(
      EXPORTING
          i_structure_name = `ZDLRICK_003`
          is_layout = gs_layout
      CHANGING
          it_fieldcatalog = gt_fieldcat
          it_outtab       =  lo_business_pj->lt_projetos
    ).

    SET HANDLER handle_data_changed FOR go_grid.

    refresh( ).
  ENDMETHOD.

  METHOD run_setor_empresa.

    CHECK go_custom_control IS INITIAL.

    go_custom_control = NEW cl_gui_custom_container(`CC_SETOR_EMPRESA`).

    go_grid = NEW cl_gui_alv_grid( i_parent = go_custom_control ).

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = `ZDLRICK_002`
      CHANGING
        ct_fieldcat      = gt_fieldcat.

    LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).

      CASE <fs_fieldcat>-fieldname.
        WHEN 'SETOR'.
          <fs_fieldcat>-just = 'C'.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'DESCRICAO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit = abap_true.
        WHEN 'MODIFICADO_POR'.
          <fs_fieldcat>-reptext = 'Mod.Por'.
          <fs_fieldcat>-scrtext_s = 'Mod.Por'.
          <fs_fieldcat>-scrtext_l = 'Modificado Por'.
          <fs_fieldcat>-scrtext_m = 'Modificado Por'.
        WHEN 'MODIFICADO_EM'.
          <fs_fieldcat>-scrtext_s = 'Mod.Em'.
          <fs_fieldcat>-scrtext_l = 'Modificado Em'.
          <fs_fieldcat>-scrtext_m = 'Modificado Em'.
        WHEN OTHERS.
          <fs_fieldcat>-no_out = 'X'.
      ENDCASE.

    ENDLOOP.

    go_grid->set_table_for_first_display(
      EXPORTING
          i_structure_name = `ZDLRICK_002`
          is_layout = gs_layout
      CHANGING
          it_fieldcatalog = gt_fieldcat
          it_outtab       =  lo_business_se->lt_setor_empresa
    ).

    SET HANDLER handle_data_changed FOR go_grid.

    refresh( ).

  ENDMETHOD.

  METHOD run_modulo_sap.
    CHECK go_custom_control IS INITIAL.

    go_custom_control = NEW cl_gui_custom_container(`CC_MODULO`).

    go_grid = NEW cl_gui_alv_grid( i_parent = go_custom_control ).

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = `ZDLRICK_001`
      CHANGING
        ct_fieldcat      = gt_fieldcat.

    LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).

      CASE <fs_fieldcat>-fieldname.
        WHEN 'MODULO'.
          <fs_fieldcat>-just = 'C'.
          <fs_fieldcat>-edit = abap_true.
*        WHEN 'CRIADO_POR'.
*          <fs_fieldcat>-reptext =   'Cri.Por'.
*          <fs_fieldcat>-scrtext_s = 'Cri.Por'.
*          <fs_fieldcat>-scrtext_l = 'Criado Por'.
*          <fs_fieldcat>-scrtext_m = 'Criado Por'.
*        WHEN 'CRIADO_EM'.
*          <fs_fieldcat>-scrtext_s =  'Cri.Em'.
*          <fs_fieldcat>-scrtext_l =  'Criado Em'.
*          <fs_fieldcat>-scrtext_m =  'Criado Em'.

        WHEN 'MODIFICADO_POR'.
          <fs_fieldcat>-reptext = 'Mod.Por'.
          <fs_fieldcat>-scrtext_s = 'Mod.Por'.
          <fs_fieldcat>-scrtext_l = 'Modificado Por'.
          <fs_fieldcat>-scrtext_m = 'Modificado Por'.

        WHEN 'MODIFICADO_EM'.
          <fs_fieldcat>-scrtext_s = 'Mod.Em'.
          <fs_fieldcat>-scrtext_l = 'Modificado Em'.
          <fs_fieldcat>-scrtext_m = 'Modificado Em'.
        WHEN OTHERS.
          <fs_fieldcat>-no_out = 'X'.
      ENDCASE.

    ENDLOOP.

    go_grid->set_table_for_first_display(
      EXPORTING
          i_structure_name = `ZDLRICK_001`
          is_layout = gs_layout
      CHANGING
          it_fieldcatalog = gt_fieldcat
          it_outtab       =  lo_business_ms->lt_modulo_sap
    ).

    SET HANDLER handle_data_changed FOR go_grid.

    refresh( ).
  ENDMETHOD.

  METHOD active_change_handle.
    go_grid->check_changed_data( ).
  ENDMETHOD.


  METHOD refresh.
    go_grid->refresh_table_display( ).
    cl_gui_cfw=>flush( ).
  ENDMETHOD.

  METHOD handle_data_changed.

    ASSIGN er_data_changed->mp_mod_rows->* TO FIELD-SYMBOL(<modified_rows>).
    ASSIGN er_data_changed->mt_deleted_rows TO FIELD-SYMBOL(<deleted_rows>).

    CASE lv_screen.
      WHEN 'RUN_PROJECT'.
        lo_business_pj->set_projetos( <modified_rows> ).
        lo_business_pj->delete_projetos( <deleted_rows> ).

      WHEN 'RUN_SETOR_EMPRESA'.
        lo_business_se->set_setor_empresa( <modified_rows> ).
        lo_business_se->delete_setor_empresa( <deleted_rows> ).

      WHEN 'RUN_MODULO_SAP'.
        lo_business_ms->set_modulo_sap( <modified_rows> ).
        lo_business_ms->delete_modulo_sap( <deleted_rows> ).

      WHEN OTHERS.
    ENDCASE.


  ENDMETHOD.

ENDCLASS.



DATA lo_business TYPE REF TO lcl_business.

MODULE set_status OUTPUT.

  IF lo_business IS INITIAL.
    lo_business = NEW lcl_business( COND #(
    WHEN sy-dynnr = '2001' THEN `RUN_PROJECT`
    WHEN sy-dynnr = '2002' THEN `RUN_SETOR_EMPRESA`
    ELSE `RUN_MODULO_SAP`)
    ).
  ENDIF.

  lo_business->run( ).

  SET PF-STATUS 'STANDARD'.
  SET TITLEBAR sy-dynnr.
ENDMODULE.


MODULE user_command INPUT.

  CASE sy-ucomm.
    WHEN '&F03' OR '&F12' OR '&F15'.
      LEAVE PROGRAM.
    WHEN 'BTN_SETOR_EMPRESA'.
      lo_business->lo_business_se->get_setor_empresa( ).
      lo_business->refresh( ).
    WHEN 'BTN_MODULO'.
      lo_business->lo_business_ms->get_modulo_sap( ).
      lo_business->refresh( ).
    WHEN 'BTN_PROJETO'.
      lo_business->lo_business_pj->get_projetos( ).
      lo_business->refresh( ).
    WHEN 'BTN_SE_SAVE' OR 'BTN_PJ_SAVE' OR 'BTN_MS_SAVE'.
      lo_business->active_change_handle( ).
    WHEN OTHERS.

  ENDCASE.

ENDMODULE.
