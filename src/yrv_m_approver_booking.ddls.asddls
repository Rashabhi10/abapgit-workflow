@EndUserText.label: 'Managed - Booking - Approver'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity yrv_m_approver_booking
  as projection on YRV_M_BOOKING_SUP as booking
{
      //YRV_M_BOOKING_SUP

      @UI.facet: [{id: 'Booking',
                    label: 'Booking',
                    purpose: #STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10}]
      @UI.lineItem: [{position: 10 }]
      @UI.identification: [{position: 10 }]

  key travel_id,
      @UI.lineItem: [{position: 20 }]
      @UI.identification: [{position: 20 }]
  key booking_id,
      @UI.lineItem: [{position: 30 }]
      @UI.identification: [{position: 30 }]
      booking_date,
      @UI.lineItem: [{position: 40 }]
      @UI.identification: [{position: 40 }]
      @Consumption.valueHelpDefinition: [{entity.name: '/DMO/I_Customer', entity.element: 'CustomerID' }]
      @ObjectModel.text.element: ['FirstName']
      customer_id,
      _bookCustomer.FirstName as FirstName,
      @UI.lineItem: [{position: 50 }]
      @UI.identification: [{position: 50 }]
      @Consumption.valueHelpDefinition: [ {entity.name: '/dmo/i_carrier', entity.element: 'AirlineID'} ]
      carrier_id,
      @UI.lineItem: [{position: 60 }]
      @UI.identification: [{position: 60 }]
      @Consumption.valueHelpDefinition: [{entity: { name: '/DMO/I_Flight', element: 'ConnectionID' },
      additionalBinding: [{ localElement: 'flight_date' , element: 'FlightDate'  },
      { localElement: 'carrier_id' , element: 'AirlineID'  },
            { localElement: 'flight_price' , element: 'Price'  },
            { localElement: 'currency_code' , element: 'CurrencyCode'  }
      ] }]
      connection_id,
      @UI.lineItem: [{position: 70 }]
      @UI.identification: [{position: 70 }]
      @Consumption.valueHelpDefinition: [{entity: { name: '/DMO/I_Flight', element: 'FlightDate' } }]
      flight_date,
      @UI.lineItem: [{position: 80 }]
      @UI.identification: [{position: 80 }]
      @Semantics.amount.currencyCode: 'currency_code'
      flight_price,
      @UI.lineItem: [{position: 90 }]
      @UI.identification: [{position: 90 }]
      @Semantics.currencyCode: true
      currency_code,
      @UI.hidden: true
      last_changed_at,
      /* Associations */
      //YRV_M_BOOKING_SUP
      _bookCustomer,
      _carrier,
      _conn,
      _bookingSupp,
      _travel      : redirected to parent yrv_m_approver_travel
}
