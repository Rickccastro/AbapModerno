class ZDLRICKCL_010 definition
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



CLASS ZDLRICKCL_010 IMPLEMENTATION.


  METHOD validate.
    DATA(ls_arquivos) = CORRESPONDING zdlrick_012( is_data ).

    IF ls_arquivos-id IS INITIAL.
      RAISE EXCEPTION NEW zdlrickcl_003( textid = zdlrickcl_003=>has_no_id
                                         ).

    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_arquivos-ticket IS INITIAL.
      RAISE EXCEPTION NEW zdlrickcl_003( textid = zdlrickcl_003=>has_no_tickets
                                         ).
    ENDIF.

    IF ls_arquivos-binario IS INITIAL.
      RAISE EXCEPTION NEW zdlrickcl_003( textid = zdlrickcl_003=>has_no_binary
                                         ).
    ENDIF.

    IF ls_arquivos-path_arquivo IS INITIAL.
      RAISE EXCEPTION NEW zdlrickcl_003( textid = zdlrickcl_003=>has_no_path
                                         ).
    ENDIF.

    IF ls_arquivos-tipo_documento IS INITIAL.
      RAISE EXCEPTION NEW zdlrickcl_003( textid = zdlrickcl_003=>has_no_type_document
                                         ).
    ENDIF.

    IF ls_arquivos-nome_arquivo IS INITIAL.
      RAISE EXCEPTION NEW zdlrickcl_003( textid = zdlrickcl_003=>has_no_filename
                                         ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
