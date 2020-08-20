CLASS lhc_yrv_c_u_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE yrv_c_u_travel.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE yrv_c_u_travel.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE yrv_c_u_travel.

    METHODS read FOR READ
      IMPORTING keys FOR READ yrv_c_u_travel RESULT result.

    METHODS moveData IMPORTING i_data       TYPE yrv_c_u_travel
                     RETURNING VALUE(r_val) TYPE /dmo/s_travel_in.

    METHODS set_booked FOR MODIFY
      IMPORTING keys    FOR ACTION yrv_c_u_travel~set_booked
      RESULT    results.

ENDCLASS.

CLASS lhc_yrv_c_u_travel IMPLEMENTATION.

  METHOD set_booked.

    DATA: lv_travel_id TYPE /dmo/travel-travel_id,
          lt_msg       TYPE /dmo/t_message.


    LOOP AT keys ASSIGNING FIELD-SYMBOL(<l_data>).

      lv_travel_id = <L_data>-TravelId.

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_SET_BOOKING'
        EXPORTING
          iv_travel_id = lv_travel_id
        IMPORTING
          et_messages  = lt_msg.

      LOOP AT lt_Msg TRANSPORTING NO FIELDS WHERE msgty = 'E' OR msgty = 'A'.
        INSERT VALUE #( %cid = <l_data>-%cid_ref
          TravelId = lv_travel_id ) INTO TABLE failed-yrv_c_u_travel.
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD movedata.
    r_val-agency_id = i_data-AgencyId.
    r_val-begin_date = i_data-BeginDate.
    r_val-booking_fee = i_data-BookingFee.
    r_val-currency_code = i_data-CurrencyCode.
    r_val-description = i_data-Description.
    r_val-end_date = i_data-EndDate.
    r_val-status = i_data-Status.
    r_val-total_price = i_data-TotalPrice.
    r_val-travel_id = i_data-TravelId.
    r_val-customer_id = i_data-customerID.
  ENDMETHOD.

  METHOD create.
    DATA: ls_travel     TYPE /dmo/s_travel_in,
          ls_travel_out TYPE /dmo/travel,
          lt_msg        TYPE /dmo/t_message.


    LOOP AT entities ASSIGNING FIELD-SYMBOL(<l_data>).
      ls_travel = movedata( i_data = CORRESPONDING #( <l_data> ) ).

*    Since unmanaged scenario all logic is written before and now reusing the same

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_CREATE'
        EXPORTING
          is_travel   = ls_travel
        IMPORTING
          es_travel   = ls_travel_out
          et_messages = lt_Msg.

      IF lt_msg IS INITIAL.
* Filling out TRANSACTIONAL BUFFER
        INSERT VALUE #( %cid = <l_data>-%cid
        TravelId = ls_travel_out-travel_id ) INTO TABLE mapped-yrv_c_u_travel.
      ELSE.
        LOOP AT lt_msg TRANSPORTING NO FIELDS WHERE msgty = 'E' OR msgty = 'A'.
          INSERT VALUE #( %cid = <l_data>-%cid ) INTO TABLE failed-yrv_c_u_travel.
        ENDLOOP.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<l_data>).

      DATA: lt_msg TYPE /dmo/t_message.

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_DELETE'
        EXPORTING
          iv_travel_id = <l_data>-TravelId
        IMPORTING
          et_messages  = lt_msg.

      LOOP AT lt_msg TRANSPORTING NO FIELDS WHERE msgty = 'E' OR msgty = 'A'.
        INSERT VALUE #(  %cid = <l_data>-%cid_ref
          TravelId = <l_data>-TravelId  ) INTO TABLE failed-yrv_c_u_travel.
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.

    DATA: ls_travel   TYPE /dmo/s_travel_in,
          ls_travelx  TYPE /dmo/s_travel_inx,
          lt_messages TYPE /dmo/t_message.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<l_data>).

      ls_travel = movedata( i_data = CORRESPONDING #( <l_data> ) ).

      ls_travelx-agency_id = xsdbool( <L_data>-%control-AgencyId = cl_abap_behv=>flag_changed  ).
      ls_travelx-begin_date = xsdbool( <L_data>-%control-BeginDate = cl_abap_behv=>flag_changed  ).
      ls_travelx-booking_fee = xsdbool( <L_data>-%control-BookingFee = cl_abap_behv=>flag_changed  ).
      ls_travelx-currency_code = xsdbool( <L_data>-%control-CurrencyCode = cl_abap_behv=>flag_changed  ).
      ls_travelx-description = xsdbool( <L_data>-%control-Description = cl_abap_behv=>flag_changed  ).
      ls_travelx-end_date = xsdbool( <L_data>-%control-EndDate = cl_abap_behv=>flag_changed  ).
      ls_travelx-status = xsdbool( <L_data>-%control-Status = cl_abap_behv=>flag_changed  ).
      ls_travelx-total_price = xsdbool( <L_data>-%control-TotalPrice = cl_abap_behv=>flag_changed  ).
      ls_travelx-travel_id = <L_data>-TravelId.
      ls_travelx-customer_id = xsdbool( <L_data>-%control-customerID = cl_abap_behv=>flag_changed  ).

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_UPDATE'
        EXPORTING
          is_travel   = ls_travel
          is_travelx  = ls_travelx
        IMPORTING
          et_messages = lt_messages.

      LOOP AT lt_messages TRANSPORTING NO FIELDS WHERE msgty = 'E' OR msgty = 'A'.
        INSERT VALUE #( %cid = <l_data>-%cid_ref
                  TravelId = <l_data>-TravelId  ) INTO TABLE failed-yrv_c_u_travel.
      ENDLOOP.


    ENDLOOP.



  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_yrv_c_u_travel DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_yrv_c_u_travel IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
    /dmo/cl_flight_legacy=>get_instance( )->save( ).
  ENDMETHOD.

ENDCLASS.
