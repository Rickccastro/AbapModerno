class ZDLRICKCL_005 definition
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



CLASS ZDLRICKCL_005 IMPLEMENTATION.


  method VALIDATE.
   DATA(ls_perfil) = CORRESPONDING ZDLRICK_006( is_data ).

    IF ls_perfil-id IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_id
      ).

    ENDIF.

   IF ls_perfil-descricao IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_description
      ).

   ENDIF.

  endmethod.
ENDCLASS.
