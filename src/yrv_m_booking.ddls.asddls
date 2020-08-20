@AbapCatalog.sqlViewName: 'YRV_M_BOOK_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Managed - Booking'
define view yrv_m_booking
  as select from /dmo/booking
  association to parent yrv_m_travel as _travel on $projection.travel_id = _travel.travel_id
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
      flight_price,
      currency_code,

      _bookCustomer,
      _carrier,
      _conn,
      _travel // Make association public
}
