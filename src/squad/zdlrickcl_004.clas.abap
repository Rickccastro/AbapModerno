class ZDLRICKCL_004 definition
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



CLASS ZDLRICKCL_004 IMPLEMENTATION.


  METHOD validate.
    DATA(ls_equipe) = CORRESPONDING ZDLRICK_004( is_data ).

    IF ls_equipe-id IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_id
      ).

    ENDIF.

   IF ls_equipe-descricao IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_description
      ).

   ENDIF.


  ENDMETHOD.
ENDCLASS.
