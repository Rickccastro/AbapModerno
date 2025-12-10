class ZDLRICKCL_006 definition
  public
  inheriting from ZDLRICKCL_001
  final
  create public .

public section.

  methods VALIDATE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZDLRICKCL_006 IMPLEMENTATION.


  method VALIDATE.
    DATA(ls_ticket) = CORRESPONDING ZDLRICK_007( is_data ).

    IF ls_ticket-id IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_id
      ).

    ENDIF.

    CHECK iv_is_delete IS INITIAL.

   IF ls_ticket-titulo IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
          textid = ZDLRICKCL_003=>has_no_title
      ).
   ENDIF.

   IF ls_ticket-descricao IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_description
      ).

   ENDIF.
  endmethod.
ENDCLASS.
