class ZDLRICKCL_001 definition
  public
  abstract
  create public .

public section.

  data AV_TABLE type STRING .

  methods CONSTRUCTOR
    importing
      !IV_TABLE type STRING .
  methods READ
    exporting
      !ET_DATA type ANY TABLE .
  methods CREATE
    changing
      !IS_DATA type ANY
    returning
      value(RS_RESULT) type BAPIRET2
    raising
      ZDLRICKCL_003 .
  methods UPDATE
    changing
      !IS_DATA type ANY
    returning
      value(RS_RESULT) type BAPIRET2
    raising
      ZDLRICKCL_003 .
  methods DELETE
    importing
      value(IS_DATA) type ANY
    returning
      value(RS_RESULT) type BAPIRET2
    raising
      ZDLRICKCL_003 .
  methods VALIDATE
    importing
      !IS_DATA type ANY
      !IV_IS_DELETE type XFELD optional
    raising
      ZDLRICKCL_003 .
protected section.
private section.
ENDCLASS.



CLASS ZDLRICKCL_001 IMPLEMENTATION.


  method CONSTRUCTOR.

    ME->av_table = iv_table.

  endmethod.


  METHOD create.
    GET TIME STAMP FIELD DATA(lv_timestamp).

    ASSIGN COMPONENT `CRIADO_POR` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_criado_por>).
    ASSIGN COMPONENT `CRIADO_EM` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_criado_em>).
    ASSIGN COMPONENT `ID` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_id>).

    IF <fs_criado_por> IS ASSIGNED.
      <fs_criado_por> = sy-uname.
    ENDIF.

    IF <fs_criado_em> IS ASSIGNED.
      <fs_criado_em> = lv_timestamp.
    ENDIF.

    IF <fs_id> IS ASSIGNED.
      <fs_id> = cl_system_uuid=>create_uuid_c32_static( ).
    ENDIF.

    TRY.
        me->validate( is_data ).
      CATCH zdlrickcl_003 INTO DATA(exc) .

        DATA(lv_msg) = exc->get_text( ).

        rs_result = VALUE bapiret2(
         type = 'E'
         message = lv_msg
        ).

        RETURN .
    ENDTRY.

    MODIFY (av_table) FROM is_data.

    rs_result = VALUE bapiret2(
     type = 'S'
     message = `Criado com Sucesso`
     message_v1 = <fs_id>
    ).


  ENDMETHOD.


  method DELETE.

        ASSIGN COMPONENT `ID` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_delete_id>).

    TRY.
        me->validate( EXPORTING is_data = is_data  iv_is_delete = abap_true ).
      CATCH zdlrickcl_003 INTO DATA(exc) .

        DATA(lv_msg) = exc->get_text( ).

        rs_result = VALUE bapiret2(
         type = 'E'
         message = lv_msg
        ).

        RETURN .
    ENDTRY.

    DELETE (me->AV_TABLE) FROM IS_DATA.

     rs_result = VALUE bapiret2(
     type = 'S'
     message = `DELETADO com Sucesso`
     message_v1 = <fs_delete_id>
    ).

  endmethod.


  method READ.
        SELECT * FROM (av_table) INTO TABLE et_data .
  endmethod.


  METHOD update.

       TRY.
        me->validate( is_data ).
      CATCH zdlrickcl_003 INTO DATA(exc) .

        DATA(lv_msg) = exc->get_text( ).

        rs_result = VALUE bapiret2(
         type = 'E'
         message = lv_msg
        ).

        RETURN .
    ENDTRY.


    GET TIME STAMP FIELD DATA(lv_timestamp).
    ASSIGN COMPONENT `MODIFICADO_POR` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_modificado_por>).
    ASSIGN COMPONENT `MODIFICADO_EM` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_modificado_em>).
    ASSIGN COMPONENT `ID` OF STRUCTURE is_data TO FIELD-SYMBOL(<fs_modificado_id>).

    IF <fs_modificado_por> IS ASSIGNED.
      <fs_modificado_por> = sy-uname.
    ENDIF.

    IF <fs_modificado_em> IS ASSIGNED.
      <fs_modificado_em> = lv_timestamp.
    ENDIF.

    MODIFY (av_table) FROM is_data.

     rs_result = VALUE bapiret2(
     type = 'S'
     message = `Modificado com Sucesso`
     message_v1 = <fs_modificado_id>
    ).


  ENDMETHOD.


  method VALIDATE.


  endmethod.
ENDCLASS.
