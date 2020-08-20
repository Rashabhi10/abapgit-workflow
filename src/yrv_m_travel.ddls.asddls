@AbapCatalog.sqlViewName: 'YRV_M_TRAVEL_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Managed - Travel'
define root view yrv_m_travel
  as select from /dmo/travel
  composition [0..*] of yrv_m_booking    as _booking
  association [0..1] to yrv_i_u_agency   as _agency   on $projection.agency_id = _agency.AgencyID
  association [0..1] to yrv_I_u_customer as _customer on $projection.customer_id = _customer.CustomerID
  association [0..1] to I_Currency as _curr on $projection.currency_code = _curr.Currency
{

      ///dmo/travel
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
      status,
      @Semantics.user.createdBy: true
      createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat,
      _agency, // Make association public
      _customer,
      _booking,
      _curr
}
