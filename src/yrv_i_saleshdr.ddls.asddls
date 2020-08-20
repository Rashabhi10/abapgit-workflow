@AbapCatalog.sqlViewName: 'YRV_I_SALESHDR_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Header Info'
define view yrv_i_saleshdr
  as select from yrv_so
  association [1] to yrv_bp as _BP on $projection.buyer = _BP.bp_id
{
      //YRV_SO
  key order_id,
      order_no,
      buyer,
      gross_amount,
      currency,
      _BP // Make association public
}
