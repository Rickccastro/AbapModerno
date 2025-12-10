*----------------------------------------------------------------------*
***INCLUDE LZDLRICK_001F01.
*----------------------------------------------------------------------*

FORM MODIFY_REGISTER.

  CHECK ZDLRICK_001-criado_por IS NOT INITIAL.

  GET TIME STAMP FIELD DATA(lv_timestamp).
  ZDLRICK_001-modificado_por = SY-UNAME.
  ZDLRICK_001-modificado_em = lv_timestamp.


ENDFORM.

FORM CREATE_REGISTER.
  GET TIME STAMP FIELD DATA(lv_timestamp).

  ZDLRICK_001-criado_por = SY-UNAME.
  ZDLRICK_001-criado_em = lv_timestamp.

ENDFORM.
