class ZDLRICKCL_009 definition
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



CLASS ZDLRICKCL_009 IMPLEMENTATION.


  method VALIDATE.
    DATA(ls_notifications) = CORRESPONDING ZDLRICK_011( is_data ).

    IF ls_notifications-id IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_id
      ).

    ENDIF.

    CHECK iv_is_delete IS INITIAL.

   IF ls_notifications-ticket IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
          textid = ZDLRICKCL_003=>has_no_tickets
      ).
   ENDIF.


   IF ls_notifications-usuario IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
          textid = ZDLRICKCL_003=>has_no_user
      ).
   ENDIF.

  endmethod.
ENDCLASS.
