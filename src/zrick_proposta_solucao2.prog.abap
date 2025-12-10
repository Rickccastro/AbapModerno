REPORT ZRICK_PROPOSTA_SOLUCAO2.


TABLES zrh_tb_horas.

DATA: st_fieldcat TYPE slis_fieldcat_alv,
      it_fieldcat TYPE slis_t_fieldcat_alv,
      lt_finaltab TYPE TABLE OF zc_rh_apontamentos.

PERFORM z_feed_fieldcat USING :
      'NomeCompleto'    'Nome Completo'       0   'X'     ,
      'Data'  'Data' 1  'X',
*      'HORA_ENTRADA' 'Hora de Entrada' 2 'X',
*      'HORA_SAIDA' 'Hora de Saída' 3 'X',
*      'HORA_ENTRADA_ALMOCO' 'Hora de Entrada Almoço' 4 'X',
*      'HORA_SAIDA_ALMOCO' 'Hora de Saída Almoço' 5 'X'.
      'horastotais' 'Horas Totais' 2 'X'.

PERFORM z_get_data.
PERFORM z_call_alv.



FORM z_get_data.

*  FIELD-SYMBOLS <linha> TYPE any.
*DATA: color TYPE char4.
*
*LOOP AT lt_finaltab ASSIGNING <linha>.
*  ASSIGN COMPONENT 'COLOR' OF STRUCTURE <linha> TO FIELD-SYMBOL(<cor>).
*  IF sy-subrc = 0.
*
*    "--- Regra de negócio: pintar HorasTotais específicas ---
*    IF <linha>-HORAS_TOTAIS = '00:00'.
*      <cor> = 'C610'. " vermelho
*    ELSEIF <linha>-HORAS_TOTAIS = '08:00'.
*      <cor> = 'C500'. " verde
*    ENDIF.
*
*  ENDIF.
*ENDLOOP.

  SELECT *
    FROM zc_rh_apontamentos
    INTO CORRESPONDING FIELDS OF TABLE @lt_finaltab.

ENDFORM.


FORM Z_feed_fieldcat USING fieldname
                           seltext_m
                           col_pos
                           do_sum.

  st_fieldcat-fieldname   = fieldname.      " Nome do campo
  st_fieldcat-seltext_m   = seltext_m.      " texto do campo
  st_fieldcat-col_pos     = col_pos.        "Em que posição fica a coluna
  st_fieldcat-do_sum      = do_sum.

*   IF col_pos = 2.
*    st_fieldcat-emphasize = 'C610'.   " vermelho
*  ENDIF.

  APPEND st_fieldcat TO it_fieldcat.
  CLEAR st_fieldcat.
ENDFORM.




FORM z_call_alv.
  DATA ls_layout TYPE slis_layout_alv.
  ls_layout-colwidth_optimize = 'X'.
  ls_layout-info_fieldname = 'COLOR'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      i_callback_program = sy-repid    " Nome do programa
*     i_callback_pf_status_set          = ' '
*     i_callback_user_command           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
     is_layout           = ls_layout
      it_fieldcat        = it_fieldcat " catalogo de campos
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
*     i_save             = 'X'
*     IS_VARIANT         =
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  = 0
*     I_HTML_HEIGHT_END  = 0
*     IT_ALV_GRAPHICS    =
*     IT_HYPERLINK       =
*     IT_ADD_FIELDCAT    =
*     IT_EXCEPT_QINFO    =
*     IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = lt_finaltab  " Tabela com os dados
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

ENDFORM.
