*        &---------------------------------------------------------------------*
*        & Report ZDLRICKP_006
*        &---------------------------------------------------------------------*
*        &
*        &---------------------------------------------------------------------*
        REPORT zdlrickp_006.


        " GERANDO UM ALV IDA EM UMA LINHA DE CODIGO


*        cl_salv_gui_table_ida=>create( 'SPFLI' )->fullscreen( )->display( ).


        TABLES: spfli.

        " ALV IDA - SPFLI (Tabela de voos), e SFLIGHT (Detalhamento dos Voos)


        SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

          PARAMETERS p_carrid TYPE spfli-carrid.
          SELECT-OPTIONS s_connid FOR spfli-connid.
        SELECTION-SCREEN END OF BLOCK b1 .



        CLASS lcl_main DEFINITION CREATE PRIVATE.

          PUBLIC SECTION.

            DATA: lo_ida TYPE REF TO if_salv_gui_table_ida.

            CLASS-METHODS create
              RETURNING
                VALUE(r_result) TYPE REF TO lcl_main.

            METHODS: run,
             set_filters,
             set_fieldcat,
             set_sort,
             set_toolbar_actions,
             handle_action FOR EVENT function_selected OF if_salv_gui_toolbar_ida.


          PROTECTED SECTION.
          PRIVATE   SECTION.

        ENDCLASS.

        CLASS lcl_main IMPLEMENTATION.
          METHOD create.
            CREATE OBJECT r_result.

          ENDMETHOD.

          METHOD run.

            lo_ida = cl_salv_gui_table_ida=>create( 'SPFLI' ).

            set_filters( ).
            set_fieldcat(  ).
            set_sort(  ).
            set_toolbar_actions(  ).

            lo_ida->fullscreen( )->display(  ).

          ENDMETHOD.


          METHOD set_filters.

            DATA(lo_collector) = NEW cl_salv_range_tab_collector( ).

            "Adiciona Parametros

            IF p_carrid IS NOT INITIAL.

              DATA(lr_carrid) = VALUE rseloption(
                   ( sign = 'I' option = 'EQ' low = p_carrid )
               ).

            ENDIF.

            lo_collector->add_ranges_for_name( iv_name = 'CARRID' it_ranges = lr_carrid[] ).


            "Adiciona Ranges
            lo_collector->add_ranges_for_name( iv_name = 'CONNID' it_ranges = s_connid[] ).

            " Monto uma tabela de ranges de filtro
            lo_collector->get_collected_ranges( IMPORTING et_named_ranges = DATA(lt_named_ranges) ).

            "Adiciono a tabela de ranges ao IDA
            lo_ida->set_select_options( lt_named_ranges[] ).


          ENDMETHOD.

          METHOD set_fieldcat.

            DATA(lt_field_names) = VALUE if_salv_gui_types_ida=>yts_field_name(
                ( CONV string( 'CARRID' ) )
                ( CONV string( 'CONNID' ) )
                ( CONV string( 'COUNTRYFR' ) )
                ( CONV string( 'CITYFROM' ) )
                ( CONV string( 'AIRPFROM' ) )
                ( CONV string( 'COUNTRYTO' ) )
                ( CONV string( 'CITYTO' ) )
                ( CONV string( 'AIRPTO' ) )
                ( CONV string( 'FLTIME' ) )
                ( CONV string( 'DEPTIME' ) )
                ( CONV string( 'ARRTIME' ) )
            ).

            lo_ida->field_catalog( )->set_available_fields( lt_field_names ).

          ENDMETHOD.

          METHOD set_sort.
            DATA(lt_sort_order) = VALUE if_salv_gui_types_ida=>yt_sort_rule(
                ( field_name = 'CITYFROM' descending = abap_true is_grouped = abap_true )
             ).

            lo_ida->default_layout( )->set_sort_order( lt_sort_order ).

          ENDMETHOD.

          METHOD set_toolbar_actions.

            lo_ida->toolbar(  )->add_button( EXPORTING iv_fcode = 'DISP'
                                                       iv_icon  = '@16@'
                                                       iv_text  = 'Detalhar Vôo' ).

            lo_ida->selection( )->set_selection_mode( 'SINGLE' ).

            "Adiciona evento de clique
            SET HANDLER handle_action FOR lo_ida->toolbar( ).





          ENDMETHOD.

          METHOD handle_action.

          DATA ls_spfli TYPE spfli.

            IF lo_ida IS BOUND.
               IF lo_ida->selection( )->is_row_selected( ).

                  lo_ida->selection( )->get_selected_row( IMPORTING es_row = ls_spfli ).

                  DATA(lo_ida_detail) = cl_salv_gui_table_ida=>create( 'SFLIGHT' ).

                  if lo_ida_detail is bound.

                    DATA(lt_named_ranges_detail) = VALUE if_salv_service_types=>yt_named_ranges(
                    ( name = 'CARRID' sign = 'I' option = 'EQ' low = ls_spfli-carrid )
                    ( name = 'CONNID' sign = 'I' option = 'EQ' low = ls_spfli-connid )

                    ).

                    lo_ida_detail->set_select_options( lt_named_ranges_detail[] ).

                    lo_ida_detail->fullscreen( )->display( ).

                  endif.


               ENDIF.
            ENDIF.


          ENDMETHOD.

ENDCLASS.

        START-OF-SELECTION.
          lcl_main=>create( )->run( ).
