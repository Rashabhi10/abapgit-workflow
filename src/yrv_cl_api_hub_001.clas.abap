CLASS yrv_cl_api_hub_001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:constructor,
      get_stock_details RETURNING VALUE(r_json) TYPE string,
      fetch_Bank_details RETURNING VALUE(r_json) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: gv_url TYPE string VALUE 'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/'.
    DATA: go_http_client TYPE REF TO  if_web_http_client.
ENDCLASS.



CLASS yrv_cl_api_hub_001 IMPLEMENTATION.
  METHOD constructor.
    go_http_client = cl_web_http_client_manager=>create_by_http_destination(
                i_destination = cl_http_destination_provider=>create_by_url( gv_url ) ).
  ENDMETHOD.

  METHOD get_stock_details.

    DATA(lo_request) = go_http_client->get_http_request( ).

    lo_request->set_header_fields( VALUE #(
       (  name = 'Content-Type' value = 'application/json' )
       (  name = 'Accept' value = 'application/json' )
       (  name = 'APIKey' value = 'h9u2IqNul92O6dzmT33eNgeG3J1TL8w2') ) ).

    lo_request->set_uri_path(
       i_uri_path = gv_url && 'API_MATERIAL_STOCK_SRV/A_MatlStkInAcctMod?$top=5&$format=json'  ).

    TRY.
        DATA(lv_response) = go_http_client->execute( i_method = if_web_http_client=>get )->get_text(  ).
      CATCH cx_web_http_client_error.
    ENDTRY.

    r_json = lv_response.

  ENDMETHOD.

  METHOD fetch_bank_details.
    DATA(lo_request) = go_http_client->get_http_request( ).

    lo_request->set_header_fields( VALUE #(
       (  name = 'Content-Type' value = 'application/json' )
       (  name = 'Accept' value = 'application/json' )
       (  name = 'APIKey' value = 'h9u2IqNul92O6dzmT33eNgeG3J1TL8w2') ) ).

    lo_request->set_uri_path(
       i_uri_path = gv_url && 'API_BANKDETAIL_SRV/A_BankDetail?$top=25'  ).

    TRY.
        DATA(lv_response) = go_http_client->execute( i_method = if_web_http_client=>get )->get_text(  ).
      CATCH cx_web_http_client_error.
    ENDTRY.

    r_json = lv_response.
  ENDMETHOD.

ENDCLASS.
