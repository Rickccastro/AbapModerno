class ZDLRICKCL_002 definition
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



CLASS ZDLRICKCL_002 IMPLEMENTATION.


  method VALIDATE.
    DATA(ls_projeto) = CORRESPONDING ZDLRICK_003( is_data ).

    IF ls_projeto-id IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_id
      ).

    ENDIF.

    CHECK iv_is_delete IS INITIAL.

   IF ls_projeto-titulo IS INITIAL.
      RAISE EXCEPTION NEW ZDLRICKCL_003(
          textid = ZDLRICKCL_003=>has_no_title
      ).
   ENDIF.

   IF ls_projeto-equipe IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_squad
      ).

   ENDIF.

   IF ls_projeto-responsavel IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_owner
      ).

   ENDIF.

   IF ls_projeto-descricao IS INITIAL.
     RAISE EXCEPTION NEW ZDLRICKCL_003(
           textid = ZDLRICKCL_003=>has_no_description
      ).

   ENDIF.
  endmethod.
ENDCLASS.
