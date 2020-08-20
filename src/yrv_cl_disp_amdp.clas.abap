CLASS yrv_cl_disp_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YRV_CL_DISP_AMDP IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lv_price      TYPE int4, lv_price_disc TYPE int4.
    TRY.
        yrv_cl_amdp_prd=>getproddata(
          EXPORTING
            p_id         = '12EA6C8B6E931EDAB1EEE6D5A7D7A873'
          IMPORTING
            et_price     = lv_price
            et_price_dis = lv_price_disc
        ).

        out->write(
          EXPORTING
            data   = |Discounted and actual price is : { lv_price_disc } { lv_price }|
*            name   =
*          RECEIVING
*            output =
        ).
      CATCH cx_amdp_execution_failed INTO DATA(lo_ex).
        DATA(lv_msg) = lo_ex->get_text( ).
        out->write(
         EXPORTING
           data   = | { lv_msg }|
*            name   =
*          RECEIVING
*            output =
       ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
