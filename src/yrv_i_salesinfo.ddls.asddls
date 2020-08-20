@AbapCatalog.sqlViewName: 'YRV_I_SALESINFOV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Info'
define view YRV_i_SALESiNFO
  as select from yrv_so_i
  association [1] to yrv_p_prod as _prod on $projection.product = _prod.prod_id
  association [1] to yrv_i_saleshdr as _salesHead on $projection.order_id = _salesHead.order_id
{

      //YRV_SO_I
  key item_id,
      order_id,
      _salesHead.order_no         as orderNumber,
      _salesHead._BP.company_name as companyName,
      _salesHead._BP.country      as Country,
      _salesHead._BP.region       as Region,
      _prod.name,
      _prod.category,
      product,
      qty,
      uom,
      amount,
      currency
}
