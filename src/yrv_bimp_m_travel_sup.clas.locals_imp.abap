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

    DATA lt_create TYPE TABLE FOR CREATE yrv_m_travel_sup.

    SELECT MAX( travel_id ) FROM /dmo/travel_m INTO @DATA(lv_travel_id).

    READ ENTITY yrv_m_travel_sup
    FROM VALUE #( FOR key IN keys (
                    %key = key-%key
                    %control-travel_id = if_abap_behv=>mk-on
                    %control-agency_id = if_abap_behv=>mk-on
                    %control-customer_id = if_abap_behv=>mk-on
                    %control-booking_fee = if_abap_behv=>mk-on
                    %control-total_price = if_abap_behv=>mk-on
                    %control-currency_code = if_abap_behv=>mk-on
     ) )  RESULT DATA(lt_travel).


    DATA(lv_date) = cl_abap_context_info=>get_system_date( ).

    lt_create = VALUE #( FOR row IN lt_travel INDEX INTO idx (
                            travel_id = lv_travel_id + idx
                            agency_id = row-agency_id
                            customer_id = row-customer_id
                            booking_fee = row-booking_fee
                            begin_date = lv_date
                            end_date = lv_date + 30
                            total_price = row-total_price
                            currency_code = row-currency_code
                            description = 'Welcome to the RAP'
                            overall_status = 'O'
                            %control = VALUE #(
                                travel_id = if_abap_behv=>mk-on
                                agency_id = if_abap_behv=>mk-on
                                customer_id = if_abap_behv=>mk-on
                                begin_date = if_abap_behv=>mk-on
                                end_date = if_abap_behv=>mk-on
                                total_price = if_abap_behv=>mk-on
                                currency_code = if_abap_behv=>mk-on
                                description = if_abap_behv=>mk-on
                                overall_status = if_abap_behv=>mk-on
                                booking_fee = if_abap_behv=>mk-on
                             )
     ) ).


    MODIFY ENTITIES OF yrv_m_travel_sup
    ENTITY Travel
    CREATE FROM lt_create
    MAPPED mapped
    FAILED failed
    REPORTED reported.

    result = VALUE #( FOR created IN lt_create INDEX INTO idx (
    %cid_ref = keys[ idx ]-%cid_ref
    %key = keys[ idx ]-%key
    %param = CORRESPONDING #( created )
 ) ).


  ENDMETHOD.

  METHOD approveTravel.

***Dynamic Feature Control
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

    """Modify status to REJECT

    MODIFY ENTITIES OF yrv_m_travel_sup
   ENTITY Travel
   UPDATE FROM VALUE #( FOR key IN keys (
                           travel_id = key-travel_id
                           overall_status = 'X'
                           %control-overall_status = if_abap_behv=>mk-on
    ) ).
    "2. Read and return the updated values to output
    READ ENTITIES OF yrv_m_travel_sup
    ENTITY Travel
    FROM VALUE #( FOR key IN keys (
                            travel_id = key-travel_id
                            %control = VALUE #(
                                        agency_id = if_abap_behv=>mk-on
                                        travel_id = if_abap_behv=>mk-on
                                        currency_code = if_abap_behv=>mk-on
                                        customer_id = if_abap_behv=>mk-on
                                        begin_date = if_abap_behv=>mk-on
                                        end_date = if_abap_behv=>mk-on
                                        booking_fee = if_abap_behv=>mk-on
                                        description = if_abap_behv=>mk-on
                                        total_price = if_abap_behv=>mk-on
                                        overall_status = if_abap_behv=>mk-on
                                        created_at = if_abap_behv=>mk-on
                                        created_by = if_abap_behv=>mk-on
                             )
     ) ) RESULT DATA(lt_travel).

    result = VALUE #( FOR travel IN lt_travel (
                       travel_id = travel-travel_id
                       %param = travel
     ) ).
  ENDMETHOD.

  METHOD get_features.

    "step 1: read the BO using its key with the help of EML
    READ ENTITY yrv_m_travel_sup FROM VALUE #( FOR keyval IN keys (
        %key = keyval-%key
        %control-travel_id = if_abap_behv=>mk-on
        %control-overall_status = if_abap_behv=>mk-on
     ) )  RESULT DATA(lt_travel).

    result = VALUE #( FOR ls_travel IN lt_travel (
        %key = ls_travel-%key
        %field-travel_id = if_abap_behv=>fc-f-read_only
        %features-%action-approveTravel = COND #( WHEN
                        ls_travel-overall_status = 'A' THEN
                                if_abap_behv=>fc-o-disabled
                        ELSE if_abap_behv=>fc-o-enabled )
        %features-%action-rejectTravel = COND #( WHEN
                        ls_travel-overall_status = 'X' THEN
                                if_abap_behv=>fc-o-disabled
                        ELSE if_abap_behv=>fc-o-enabled )
     ) ).

  ENDMETHOD.

ENDCLASS.
