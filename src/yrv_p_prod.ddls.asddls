@AbapCatalog.sqlViewName: 'YRV_P_PROD_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product View - Private'
define view yrv_p_prod
  as select from yrv_product
{
      //YRV_PRODUCT
  key prod_id,
      name,
      category,
      price,
      currency,
      discount
}
