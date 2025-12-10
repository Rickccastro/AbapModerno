class ZDLRICKCL_003 definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_MESSAGE .
  interfaces IF_T100_DYN_MSG .

  constants:
    begin of HAS_NO_ID,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '000',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_ID .
  constants:
    begin of HAS_NO_TITLE,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '001',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_TITLE .
  constants:
    begin of HAS_NO_SQUAD,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '002',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_SQUAD .
  constants:
    begin of HAS_NO_OWNER,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '004',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_OWNER .
  constants:
    begin of HAS_NO_DESCRIPTION,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '003',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_DESCRIPTION .
  constants:
    begin of HAS_NO_COMMENTS,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '005',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_COMMENTS .
  constants:
    begin of HAS_NO_TICKETS,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '006',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_TICKETS .
  constants:
    begin of HAS_NO_USER,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '007',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_USER .
  constants:
    begin of HAS_NO_PATH,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '009',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_PATH .
  constants:
    begin of HAS_NO_BINARY,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '008',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_BINARY .
  constants:
    begin of HAS_NO_TYPE_DOCUMENT,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '010',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_TYPE_DOCUMENT .
  constants:
    begin of HAS_NO_FILENAME,
      msgid type symsgid value 'ZDLPMRICK',
      msgno type symsgno value '011',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of HAS_NO_FILENAME .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional .
protected section.
private section.
ENDCLASS.



CLASS ZDLRICKCL_003 IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
