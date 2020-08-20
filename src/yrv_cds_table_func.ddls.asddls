@EndUserText.label: 'Table Function'
define table function yrv_cds_table_func
with parameters 
@Environment.systemField: #CLIENT
p_clnt : abap.clnt

returns {
  client : abap.clnt;
  order_no : abap.int4;
  gross_amount: abap.curr(10,2);
  gross_dis: abap.int4;
  
}
implemented by method yrv_cl_amdp_prd=>getorders; 