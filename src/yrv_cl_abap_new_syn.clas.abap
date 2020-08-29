CLASS yrv_cl_abap_new_syn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS yrv_cl_abap_new_syn IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA: lv TYPE int1 VALUE 10.
    "REPEAT KEYWORD
    DATA(val) = |{ repeat( val = 'New ' occ = 5 ) }|.


    out->write( val ).

    "Logical Statement
    IF lv * lv = 100.
      out->write( lv ).
    ENDIF.

    "INLINE DECLARATION
    SELECT *  FROM /dmo/agency INTO TABLE @DATA(lt) UP TO 10 ROWS.

    out->write( lt ).

    READ TABLE lt ASSIGNING FIELD-SYMBOL(<ls>) WITH KEY agency_id = '070004'.

    out->write( <ls> ).

    "VALUE EXPRESSION - declare and initialize internal table
    TYPES: BEGIN OF ty_data,
             a TYPE i,
             b TYPE i,
           END OF ty_data,
           lt_val TYPE STANDARD TABLE OF ty_data WITH EMPTY KEY.

    DATA(lt_vals) = VALUE lt_val( ( a = 1 b = 10 )
                                ( a = 2 b = 5 )
                                a = 8
                                ( b = 10 )
                                ( b = 20 )
                                 ).

    out->write( lt_vals ).

    "VALUE CHAINING


    "DEFAULT ADDITION
    DATA lv_val TYPE i.

    DO 5 TIMES.
      lv_val = VALUE #(  lt_vals[ sy-index ]-a DEFAULT -1 ).
      out->write( lv_val ).
    ENDDO.


  ENDMETHOD.

ENDCLASS.
