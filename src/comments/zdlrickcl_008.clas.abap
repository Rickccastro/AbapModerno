class ZDLRICKCL_008 definition
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



CLASS ZDLRICKCL_008 IMPLEMENTATION.


  method VALIDATE.
    DATA(ls_comments) = CORRESPONDING ZDLRICK_010( is_data ).

    IF ls_comments-id IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_id
      ).

    ENDIF.

    CHECK iv_is_delete IS INITIAL.

   IF ls_comments-comentario IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_comments
      ).

   ENDIF.
  endmethod.
ENDCLASS.
