@AbapCatalog.sqlViewName: 'YRV_C_SALES_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales region wise'
define view yrv_c_sales
  as select from YRV_i_SALESiNFO
{
  key category,
  key currency,
      sum( amount ) as TotalSum
}
group by
  category,
  currency
