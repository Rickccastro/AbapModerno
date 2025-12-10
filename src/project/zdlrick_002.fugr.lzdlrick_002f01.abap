FORM MODIFY_REGISTER.

  CHECK ZDLRICK_002-criado_por IS NOT INITIAL.

  GET TIME STAMP FIELD DATA(lv_timestamp).
  ZDLRICK_002-modificado_por = SY-UNAME.
  ZDLRICK_002-modificado_em = lv_timestamp.


ENDFORM.


FORM CREATE_REGISTER.

    GET TIME STAMP FIELD DATA(lv_timestamp).
    ZDLRICK_002-criado_por = sy-uname.
    ZDLRICK_002-criado_em = lv_timestamp.

ENDFORM.
