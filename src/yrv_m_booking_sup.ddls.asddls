@AbapCatalog.sqlViewName: 'YRV_M_BOOK_SV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Managed - Booking'
define view YRV_M_BOOKING_SUP
  as select from /dmo/booking_m as Booking
  composition[1..*] of yrv_m_bookingsup as _bookingSupp
  association to parent yrv_m_travel_sup as _travel on $projection.travel_id = _travel.travel_id
  association [1] to /DMO/I_Customer   as _bookCustomer on  $projection.customer_id = _bookCustomer.CustomerID
  association [1] to /DMO/I_Carrier    as _carrier      on  $projection.carrier_id = _carrier.AirlineID
  association [1] to /DMO/I_Connection as _conn         on  $projection.carrier_id    = _conn.AirlineID
                                                        and $projection.connection_id = _conn.ConnectionID
{

      ///dmo/booking
  key travel_id,
  key booking_id,
      booking_date,
      customer_id,
      carrier_id,
      connection_id,
      flight_date,
      @Semantics.amount.currencyCode: 'currency_code'
      flight_price,
      @Semantics.currencyCode: true
      currency_code,
       @Semantics.systemDateTime.lastChangedAt: true
      _travel.last_changed_at,
      _bookCustomer,
      _carrier,
      _conn,
      _travel,
      _bookingSupp // Make association public
}
