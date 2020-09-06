CLASS yrv_cl_http_demo_1 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS yrv_cl_http_demo_1 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA(lt_params) = request->get_form_fields(  ).
    READ TABLE lt_params REFERENCE INTO DATA(lr_params) WITH KEY name = 'cmd'.
    IF sy-subrc <> 0.
      response->set_status( i_code = 400
                       i_reason = 'Bad request').
      RETURN.
    ENDIF.
    CASE lr_params->value.
      WHEN `hello`.
        response->set_text( |Hello World! | ).
      WHEN `timestamp`.
        response->set_text( |Hello World! application executed by {
                             cl_abap_context_info=>get_user_technical_name( ) } | &&
                              | on { cl_abap_context_info=>get_system_date( ) DATE = ENVIRONMENT } | &&
                              | at { cl_abap_context_info=>get_system_time( ) TIME = ENVIRONMENT } | ).
      WHEN 'stock'.
        response->set_text( NEW yrv_cl_api_hub_001(  )->get_stock_details( ) ).
      WHEN 'bankdetails'.
        response->set_text( NEW yrv_cl_api_hub_001(  )->fetch_bank_details( ) ).
      WHEN OTHERS.
        response->set_status( i_code = 400 i_reason = 'Bad request').
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
