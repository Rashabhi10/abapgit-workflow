@AbapCatalog.sqlViewName: 'YRV_I_BP_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Business Plan'
define view yrv_i_bp
  as select from yrv_bp
{
      //yrv_bp
  key bp_id,
      bp_role,
      company_name,
      street,
      city,
      country,
      region
}
