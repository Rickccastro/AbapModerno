class ZDLRICKCL_007 definition
  public
  inheriting from ZDLRICKCL_001
  final
  create public .

public section.

  methods APPROVE_HOUR
    importing
      !IV_APPROVE type ZDLRICKEL_011
    changing
      !CS_DATA type ZDLRICK_009
    returning
      value(RS_RESULT) type BAPIRET2 .

  methods VALIDATE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZDLRICKCL_007 IMPLEMENTATION.


  method APPROVE_HOUR.

    CHECK IV_APPROVE CA 'AR'.
    CS_DATA-aprovacao = IV_APPROVE.
    CS_DATA-aprovacao_por = sy-uname.
    CS_DATA-aprovacao_em = sy-datum.

    MODIFY ZDLRICK_009 FROM CS_DATA .


  endmethod.


  method VALIDATE.
    DATA(ls_hour) = CORRESPONDING ZDLRICK_009( is_data ).

    IF ls_hour-id IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_id
      ).

    ENDIF.

    CHECK iv_is_delete IS INITIAL.

   IF ls_hour-descricao IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_description
      ).

   ENDIF.
  endmethod.
ENDCLASS.
