*&---------------------------------------------------------------------*
*& Report ZRICK_PROPOSTA_SOLUCAO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrick_proposta_solucao.

TABLES zrh_tb_empregado.
TABLES zrh_tb_horas.

DATA: gt_ids_sem_apontamento TYPE TABLE OF zrh_tb_empregado-id,
      ls_sem_apontamento TYPE zrh_tb_horas.


DATA: ls_horas  TYPE zrh_tb_horas,
      lv_nome   TYPE zrh_tb_empregado-nome_completo,
      lv_data   TYPE zrh_tb_horas-data,
      lv_exist  TYPE zrh_tb_horas-id,
      lv_answer TYPE c,
      lt_horas  TYPE TABLE OF zrh_tb_horas.

START-OF-SELECTION.



  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-005.

    PARAMETERS: rb1 RADIOBUTTON GROUP grp1 DEFAULT 'X' USER-COMMAND rb,
                rb2 RADIOBUTTON GROUP grp1,
                rb3 RADIOBUTTON GROUP grp1.

  SELECTION-SCREEN END OF BLOCK b1.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.

    PARAMETERS p_ID TYPE zrh_tb_horas-id.

  SELECTION-SCREEN END OF BLOCK b2.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-006.

    PARAMETERS p_data   TYPE zrh_tb_horas-data.

  SELECTION-SCREEN END OF BLOCK b3.

  SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-002.

    PARAMETERS: p_ent    TYPE zrh_tb_horas-hora_entrada DEFAULT '      ',
                p_SAI    TYPE zrh_tb_horas-hora_saida DEFAULT '      ',
                p_ent_al TYPE zrh_tb_horas-hora_entrada_almoco DEFAULT '      ',
                p_sai_al TYPE zrh_tb_horas-hora_saida_almoco DEFAULT '      '.

  SELECTION-SCREEN END OF BLOCK b4.

AT SELECTION-SCREEN.
  IF sy-ucomm = 'ONLI'.
    PERFORM valida_campos.
  ENDIF.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN INTO DATA(wa).
    IF wa-name CS 'ENT' OR wa-name CS 'SAI'.
      IF rb3 = 'X'.
        wa-active = 0.
      ELSE.
        wa-active = 1.
      ENDIF.
*      wa-active = COND #( WHEN rb3 = abap_true THEN 0 ELSE 1 ).
      MODIFY SCREEN FROM wa.
    ENDIF.
  ENDLOOP.

END-OF-SELECTION.

*INSERIR REGISTRO
  IF rb1 = 'X'.

    PERFORM valida_campos.
    PERFORM inserir_dados.

    IF sy-subrc = 0.
      MESSAGE 'Apontamento inserido com sucesso.' TYPE 'S'.
    ELSE.
      MESSAGE 'Erro ao inserir apontamento.' TYPE 'E'.
    ENDIF.

*EDITAR REGISTRO
  ELSEIF rb2 = 'X'.

    PERFORM valida_campos.
    PERFORM modificar_dados.

    IF sy-subrc = 0.
      MESSAGE 'Apontamento alterado com sucesso.' TYPE 'S'.
    ELSE.
      MESSAGE 'Erro ao alterar apontamento.' TYPE 'E'.
    ENDIF.

*DELETAR REGISTRO
  ELSEIF rb3 = 'X'.

    PERFORM valida_campos.

    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar       = 'Confirmação de exclusão'
        text_question  = 'Deseja excluir este apontamento?'
        text_button_1  = 'Sim'
        text_button_2  = 'Não'
        default_button = '2'
      IMPORTING
        answer         = lv_answer.

    IF lv_answer = '1'.
      DELETE FROM zrh_tb_horas
        WHERE id = p_id
        AND data = p_data.
      MESSAGE 'Apontamento excluído com sucesso.' TYPE 'S'.
    ELSEIF lv_answer = '2'.
      MESSAGE 'Apontamento não excluído.' TYPE 'E'.
    ELSEIF lv_answer = 'A'.
      MESSAGE 'Exclusão cancelada.' TYPE 'I'.
    ENDIF.
  ENDIF.
FORM inserir_dados.

  SELECT SINGLE nome_completo
  FROM zrh_tb_empregado
  INTO lv_nome
  WHERE id = p_ID.

  ls_horas-id = p_id.
  ls_horas-data = p_data.
  ls_horas-hora_entrada = p_ent.
  ls_horas-hora_saida = p_sai.
  ls_horas-hora_entrada_almoco = p_ent_al.
  ls_horas-hora_saida_almoco = p_sai_al.

  IF ls_horas-hora_entrada EQ '      ' OR ls_horas-hora_saida EQ '     ' OR ls_horas-hora_entrada_almoco EQ '      '  OR  ls_horas-hora_saida_almoco EQ '      '.
    MESSAGE 'Preencha todos os campos de horas' TYPE 'E'.
  ENDIF.

  INSERT zrh_tb_horas FROM ls_horas.

ENDFORM.

FORM modificar_dados.

  SELECT SINGLE *
  FROM zrh_tb_horas
  INTO ls_horas
  WHERE id = p_ID
        AND data = p_data.

  IF sy-subrc <> 0.
    MESSAGE 'Apontamento não encontrado para edição.' TYPE 'E'.
  ENDIF.

  IF p_ent NE '      '.
    ls_horas-hora_entrada = p_ent.
  ENDIF.

  IF p_sai NE '      '.
    ls_horas-hora_saida = p_sai.
  ENDIF.

  IF p_ent_al NE '      '.
    ls_horas-hora_entrada_almoco = p_ent_al.
  ENDIF.

  IF p_sai_al NE '      '.
    ls_horas-hora_saida_almoco = p_sai_al.
  ENDIF.

  MODIFY zrh_tb_horas FROM ls_horas.

ENDFORM.


FORM valida_campos.

  IF sy-uzeit EQ '235500'.

    " 1. Buscar IDs dos funcionários sem apontamento hoje
    SELECT e~id
      FROM zrh_tb_empregado AS e
      LEFT JOIN zrh_tb_horas AS h
             ON h~id   = e~id
            AND h~data = @sy-datum
      WHERE h~id IS NULL
      INTO TABLE @gt_ids_sem_apontamento.

    " 2. Registrar apontamento automático
    LOOP AT gt_ids_sem_apontamento ASSIGNING FIELD-SYMBOL(<fs_id>).

      CLEAR ls_sem_apontamento.
      ls_sem_apontamento-id   = <fs_id>.
      ls_sem_apontamento-data = sy-datum.
      ls_horas-hora_entrada =  '235501'.
      ls_horas-hora_saida =  '235502'.
      ls_horas-hora_entrada_almoco = '235503'.
      ls_horas-hora_saida_almoco = '235504'.


      INSERT zrh_tb_horas FROM ls_sem_apontamento.

      IF sy-subrc = 0.
        " Registro inserido com sucesso
      ELSE.
        " Tratamento de erro se necessário
      ENDIF.

    ENDLOOP.

  ELSE.
    SELECT SINGLE id INTO lv_exist
  FROM zrh_tb_horas
  WHERE id = p_id AND data = p_data.

    IF p_id IS INITIAL AND p_data IS INITIAL.
      MESSAGE ' Os campos ID e Data de lançamento são Obrigatórios' TYPE'E'.
    ELSEIF p_id IS INITIAL.
      MESSAGE 'O campo ID é Obrigatório' TYPE'E'.
    ELSEIF p_data IS INITIAL.
      MESSAGE 'O campo Data de lançamento é Obrigatório' TYPE'E'.
    ENDIF.

    IF rb1 = 'X'.
      IF lv_exist IS NOT INITIAL.
        MESSAGE 'Já existe apontamento para esse ID e data.' TYPE 'E'.
      ENDIF.
      IF p_ent >= p_sai.
        MESSAGE 'Hora de entrada deve ser menor que a de saída.' TYPE 'E'.
      ENDIF.
    ENDIF.

    IF rb2 = 'X'.
      IF lv_exist IS INITIAL.
        MESSAGE 'Não existe registro para editar.' TYPE 'E'.
      ENDIF.
    ENDIF.

    IF rb3 = 'X'.
      IF lv_exist IS INITIAL.
        MESSAGE 'Apontamento não encontrado para exclusão.' TYPE 'E'.
      ENDIF.
    ENDIF.

  ENDIF.
ENDFORM.
