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
  ENDMETHOD.

  METHOD rejectTravel.
  ENDMETHOD.

  METHOD get_features.
  ENDMETHOD.

ENDCLASS.


