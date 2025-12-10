*&---------------------------------------------------------------------*
*& Report ZDLRICKP_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdlrickp_002.

TABLES: zdlrick_009,zdlrick_003,zdlrick_007.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_proj FOR zdlrick_003-id.
SELECTION-SCREEN END OF BLOCK b1.


CLASS lcl_main DEFINITION.

  PUBLIC SECTION.

    DATA: lo_alv     TYPE REF TO cl_salv_table,
          lo_columns TYPE REF TO cl_salv_columns_table.

    TYPES: BEGIN OF ty_alv,
             projeto        TYPE zdlrick_003-id,
             titulo         TYPE zdlrick_003-titulo,
             total_horas    TYPE int4,
             total_apontado TYPE int4,
             progresso      TYPE int4,
             progresso_txt  TYPE string,
             color          TYPE lvc_t_scol,

           END OF ty_alv.


    DATA: lt_alv TYPE TABLE OF ty_alv.

    CLASS-METHODS create
      RETURNING
        VALUE(r_result) TYPE REF TO lcl_main.

    METHODS: run,
      get_projects,
      display_report,
      set_fieldcat,
      set_color,
      fieldcat_change IMPORTING _colmn    TYPE lvc_fname
                                _longtxt  TYPE scrtext_l OPTIONAL
                                _position TYPE int4 OPTIONAL
                                _outlen   TYPE lvc_outlen OPTIONAL
                                _display  TYPE sap_bool DEFAULT abap_true
                                _align    TYPE salv_de_alignment OPTIONAL.


  PROTECTED SECTION.
  PRIVATE   SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD create.
    CREATE OBJECT r_result.

  ENDMETHOD.

  METHOD run.
    get_projects( ).
    display_report( ).
  ENDMETHOD.

  METHOD get_projects.


    SELECT z003~id,
           z003~titulo,
           SUM( z007~hours_expected ) AS expected
           FROM zdlrick_003 AS z003
             LEFT JOIN zdlrick_007 AS z007
             ON z003~id = z007~projeto
             INTO TABLE @DATA(lt_projects)
             WHERE z003~id IN @s_proj
             GROUP BY z003~id, z003~titulo.


      SELECT z007~projeto, SUM( z009~horas ) AS horas FROM zdlrick_009 AS z009
         LEFT JOIN zdlrick_007 AS z007
         ON z009~ticket = z007~id
         INTO TABLE @DATA(lt_hours)
         WHERE aprovacao =  'A' AND z007~projeto IN @s_proj
         GROUP BY z007~projeto.


    LOOP AT lt_projects REFERENCE INTO DATA(lrf_project).
      DATA(ls_hour) = VALUE #( lt_hours[ projeto = lrf_project->id ] OPTIONAL ).
      DATA(lv_progresso) = ( ls_hour-horas * 100 ) / lrf_project->expected.

      DATA(lv_color) = COND #(
       WHEN lv_progresso >= 50 AND lv_progresso <= 99 THEN 3
       WHEN lv_progresso = 100 THEN 5
       WHEN lv_progresso > 100 THEN 6
       ELSE 4
      ).

      DATA(lt_color_column) = VALUE lvc_t_scol( ( fname = 'PROGRESSO_TXT' color-col = lv_color ) ).

      APPEND VALUE ty_alv(
      projeto     = lrf_project->id
      titulo        = lrf_project->titulo
      total_horas    = lrf_project->expected
      total_apontado = ls_hour-horas
      progresso      =  lv_progresso
      progresso_txt   = |{ lv_progresso }%|
      color     =    lt_color_column
        ) TO lt_alv.
    ENDLOOP.

  ENDMETHOD.


  METHOD display_report.

    cl_salv_table=>factory(
      IMPORTING
          r_salv_table = lo_alv
      CHANGING
          t_table = lt_alv
    ).

    lo_columns = lo_alv->get_columns( ).

    set_fieldcat( ).
    set_color( ).

    lo_alv->display( ).
  ENDMETHOD.

  METHOD set_fieldcat.
    fieldcat_change(
      _colmn = `PROJETO`
      _longtxt = `Projeto`
      _position = 1
    ).

    fieldcat_change(
      _colmn = `TITULO`
      _longtxt = `Titulo`
      _position = 2
      _outlen = 25

    ).

    fieldcat_change(
     _colmn = `PROJETO`
     _longtxt = `Projeto`
     _position = 3
     _outlen = 15
     _align  = 3
   ).

    fieldcat_change(
   _colmn = `TOTAL_HORAS`
   _longtxt = `Total Horas`
   _position = 4
   _outlen = 15
   _align  = 3
 ).

    fieldcat_change(
_colmn = `TOTAL_APONTADO`
_longtxt = `Total Apontado`
_position = 5
_outlen = 15
_align  = 3
).

    fieldcat_change(
  _colmn = `PROGRESSO`
  _display = abap_false
).


  ENDMETHOD.

  METHOD fieldcat_change.

    DATA(lo_column) = lo_columns->get_column( _colmn ).

    lo_column->set_long_text( _longtxt ).
    lo_column->set_visible( _display ).
    lo_column->set_alignment( COND #( WHEN _align IS NOT INITIAL THEN _align ELSE 1 ) ).

    lo_column->set_output_length( _outlen ).

    lo_columns->set_column_position( columnname = _colmn
                                    position   = _position ).

  ENDMETHOD.

  METHOD set_color.
    TRY.

        lo_columns->set_color_column( EXPORTING value = `COLOR` ).

      CATCH cx_salv_data_error.

    ENDTRY.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create( )->run( ).
