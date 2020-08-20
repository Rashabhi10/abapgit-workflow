@AbapCatalog.sqlViewName: 'YRV_DEMO_1_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo CDS View'

define view yrv_demo_1
  as select from /dmo/flight
{
      ///dmo/flight
      ///dmo/flight
      //Detailed Screen - INFO
      @UI.facet: [{ id : 'carrier_id',
                    type: #IDENTIFICATION_REFERENCE,
                    label: 'Flight Data'}]
      @UI.lineItem: [{position: 10 }]
      @UI.identification: [{position: 10 }]
  key carrier_id,
      @UI.lineItem: [{position: 20 }]
  key connection_id,
  key flight_date,
      @Semantics.amount.currencyCode: 'currency_code'
      price,
      @Semantics.currencyCode: true
      currency_code,
      plane_type_id,
      seats_max,
      seats_occupied
}
