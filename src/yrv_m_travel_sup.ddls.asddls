@AbapCatalog.sqlViewName: 'YRV_M_TRAVEL_SV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Managed - Travel'
define root view yrv_m_travel_sup
  as select from /dmo/travel_m as Travel
  composition[0..*] of YRV_M_BOOKING_SUP as _booking
  association [0..1] to yrv_i_u_agency   as _agency   on $projection.agency_id = _agency.AgencyID
  association [0..1] to yrv_I_u_customer as _customer on $projection.customer_id = _customer.CustomerID
  association [0..1] to I_Currency       as _curr     on $projection.currency_code = _curr.Currency
{

      ///dmo/travel
      ///dmo/travel_m
  key travel_id,
      agency_id,
      customer_id,
      begin_date,
      end_date,
      @Semantics.amount.currencyCode: 'currency_code'
      booking_fee,
      @Semantics.amount.currencyCode: 'currency_code'
      total_price,
      @Semantics.currencyCode: true
      currency_code,
      description,
      overall_status,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      _agency, // Make association public
      _customer,
      _curr,
      _booking
}
