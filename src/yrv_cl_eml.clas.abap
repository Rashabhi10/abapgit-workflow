CLASS yrv_cl_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    DATA: lv_type TYPE c VALUE 'D'.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YRV_CL_EML IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: it_data_c TYPE TABLE FOR CREATE yrv_m_travel_sup,
          it_data_u TYPE TABLE FOR UPDATE yrv_m_travel_sup,
          it_data_d TYPE TABLE FOR DELETE yrv_m_travel_sup.

    CASE lv_type.
      WHEN 'R'.

        READ ENTITIES OF yrv_m_travel_sup
           ENTITY Travel FROM VALUE #( ( travel_id = '00001'
                                 %control = VALUE #( agency_id = if_abap_behv=>mk-on
                                                     booking_fee = if_abap_behv=>mk-on
                                                     total_price = if_abap_behv=>mk-on  ) ) )
                                                     RESULT DATA(lt_data).



        IF lt_data IS NOT INITIAL.

          out->write(
            EXPORTING
              data   =  lt_data
*            name   =
*          RECEIVING
*            output =
          ).

        ENDIF.

      WHEN 'C'.


        it_data_c = VALUE #( ( travel_id = '00000002'
                 agency_id = 70003
                 customer_id = 3
                 begin_date = cl_abap_context_info=>get_system_date( )
                 end_date = cl_abap_context_info=>get_system_date(  ) + 30
                 booking_fee = 50
                 total_price = 5000
                 currency_code = 'USD'
                 overall_status = 'O'
                 description = 'Wallah'
                 %control = VALUE #( agency_id = if_abap_behv=>mk-on
                                     travel_id =  if_abap_behv=>mk-on
                                     customer_id = if_abap_behv=>mk-on
                                     begin_date = if_abap_behv=>mk-on
                                     end_date = if_abap_behv=>mk-on
                                     booking_fee = if_abap_behv=>mk-on
                                     total_price = if_abap_behv=>mk-on
                                     currency_code = if_abap_behv=>mk-on
                                     overall_status = if_abap_behv=>mk-on
                                     description = if_abap_behv=>mk-on
                                    )  ) ).


        MODIFY ENTITIES OF yrv_m_travel_sup
        ENTITY Travel
        CREATE FROM it_data_c
        FAILED DATA(lt_fail)
        REPORTED DATA(lt_repo).


        IF lt_fail IS NOT INITIAL.
          out->write(
            EXPORTING
              data   = lt_fail
          ).
        ENDIF.


      WHEN 'U'.

        it_data_u = VALUE #( ( travel_id = '00000002'
                                description = 'Changed'
                                %control = VALUE #(
                                description = if_abap_behv=>mk-on ) ) ).

        MODIFY ENTITIES OF yrv_m_travel_sup
        ENTITY Travel
        UPDATE FROM it_data_u
        FAILED lt_fail
        REPORTED lt_repo.

        IF lt_fail IS NOT INITIAL.
          out->write(
            EXPORTING
              data   = lt_fail
          ).
        ENDIF.

      WHEN 'D'.

        it_data_d = VALUE #( ( travel_id = '00000002' ) ).

        MODIFY ENTITIES OF yrv_m_travel_sup
        ENTITY Travel
        DELETE FROM it_data_d
        FAILED lt_fail
        REPORTED lt_repo.

        IF lt_fail IS NOT INITIAL.
          out->write(
            EXPORTING
              data   = lt_fail
          ).
        ENDIF.


    ENDCASE.

    COMMIT ENTITIES.

  ENDMETHOD.
ENDCLASS.
