*----------------------------------------------------------------------*
***INCLUDE LZDLRICK_003F01.
*----------------------------------------------------------------------*

FORM MODIFY_REGISTER.

  CHECK ZDLRICK_003-criado_por IS NOT INITIAL.

  GET TIME STAMP FIELD DATA(lv_timestamp).
  ZDLRICK_003-modificado_por = SY-UNAME.
  ZDLRICK_003-modificado_em = lv_timestamp.


ENDFORM.

FORM CREATE_REGISTER.

    GET TIME STAMP FIELD DATA(lv_timestamp).
    ZDLRICK_003-id = cl_system_uuid=>create_uuid_c32_static( ).
    ZDLRICK_003-criado_por = sy-uname.
    ZDLRICK_003-criado_em = lv_timestamp.

ENDFORM.
