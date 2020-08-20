CLASS yrv_cl_amdp_prd DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS getproddata
    IMPORTING VALUE(p_id) TYPE yrv_prd_id
    EXPORTING VALUE(et_price) TYPE int4 VALUE(et_price_dis) TYPE int4.

    CLASS-METHODS getorders FOR TABLE FUNCTION yrv_cds_table_func.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YRV_CL_AMDP_PRD IMPLEMENTATION.


  METHOD getproddata BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING  yrv_product.
    DECLARE lv_price,lv_disc INTEGER;
      select price, discount into lv_price, lv_disc from yrv_product WHERE prod_id = :p_id;
      et_price = lv_price;
      et_price_dis = ( lv_price * (100 - lv_disc ) / 100 );
  ENDMETHOD.


  METHOD getorders BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING yrv_so yrv_so_i yrv_product.
    lt_order = select hdr.client, hdr.order_no, item.amount, ( item.amount * ( 100 - prod.discount ) ) as amount_dis
                  from yrv_so as hdr inner join yrv_so_i as item on hdr.order_id = item.order_id
                  inner join yrv_product as prod on item.product = prod.prod_id
                  where hdr.client = :p_clnt;

                  RETURN SELECT client, order_no, sum( amount ) as gross_amount, sum( amount_dis ) as gross_dis from :lt_order
                  GROUP BY client, order_no;

  ENDMETHOD.
ENDCLASS.
