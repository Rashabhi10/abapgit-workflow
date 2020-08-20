CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS createTravelTemp FOR MODIFY
      IMPORTING keys FOR ACTION Travel~createTravelTemp RESULT result.

    METHODS approveTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~approveTravel RESULT result.

    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD createTravelTemp.



  ENDMETHOD.

  METHOD approveTravel.

    """Modify status to APPROVED

    MODIFY ENTITIES OF yrv_m_travel_sup
    ENTITY Travel
    UPDATE FROM VALUE #( FOR key IN keys ( travel_id = key-travel_id
                                           overall_status = 'A'
                                           %control-overall_status = if_abap_behv=>mk-on  ) ).

    ""READ and RETURN the RESULT
    READ ENTITIES OF yrv_m_travel_sup
    ENTITY Travel
    FROM VALUE #( FOR key IN keys ( travel_id = key-travel_id
                                    %control = VALUE #(
                                   agency_id = if_abap_behv=>mk-on
                                   begin_date = if_abap_behv=>mk-on
                                   booking_fee = if_abap_behv=>mk-on
                                   created_at = if_abap_behv=>mk-on
                                   currency_code = if_abap_behv=>mk-on
                                   customer_id = if_abap_behv=>mk-on
                                   description = if_abap_behv=>mk-on
                                   end_date = if_abap_behv=>mk-on
                                   last_changed_at = if_abap_behv=>mk-on
                                   last_changed_by = if_abap_behv=>mk-on
                                   overall_status = if_abap_behv=>mk-on
                                   total_price = if_abap_behv=>mk-on
                                   travel_id = if_abap_behv=>mk-on  ) )
                 ) RESULT DATA(lt_travel).


    result = VALUE #( FOR travel IN lt_travel (
                       travel_id = travel-travel_id
                       %param = travel ) ).

  ENDMETHOD.

  METHOD rejectTravel.
  ENDMETHOD.

  METHOD get_features.
  ENDMETHOD.

ENDCLASS.
