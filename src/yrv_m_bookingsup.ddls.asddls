@AbapCatalog.sqlViewName: 'YRV_M_BOOKSUP_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement'
define view yrv_m_bookingsup
  as select from /dmo/booksuppl_m
  association to parent YRV_M_BOOKING_SUP as _booking on $projection.booking_id = _booking.booking_id
  and $projection.travel_id = _booking.travel_id
  association [1] to /DMO/I_Supplement     as _suppl     on $projection.supplement_id = _suppl.SupplementID
  association [1..*] to /DMO/I_SupplementText as _supplText on $projection.supplement_id = _supplText.SupplementID
{
      ///dmo/booksuppl_m
  key travel_id,
  key booking_id,
  key booking_supplement_id,
      supplement_id,
      price,
      currency_code,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      _suppl,
      _supplText,
      _booking // Make association public
}
