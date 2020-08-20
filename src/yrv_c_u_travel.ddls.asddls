@AbapCatalog.sqlViewName: 'YRV_C_U_TRV_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'UnManaged Cons View Travel Projection'
@UI.headerInfo:{typeName: 'Travel',typeNamePlural: 'Travels' }
@Search.searchable: true
define root view yrv_c_u_travel
  as select from /dmo/travel as Travel
  association [1] to yrv_i_u_agency   as _agency   on $projection.AgencyId = _agency.AgencyID
  association [1] to yrv_I_u_customer as _customer on $projection.customerID = _customer.CustomerID
  association [1] to I_Currency       as _currency on $projection.CurrencyCode = _currency.Currency

{

      //Travel
      @UI.facet: [{purpose: #STANDARD,type: #IDENTIFICATION_REFERENCE,label: 'Details',position: 10 }]
      @UI.selectionField: [{position: 10 }]
      @UI.lineItem: [{position: 10,label: 'Travel Number' }]
      @UI.identification: [{position: 100 }]
  key travel_id     as TravelId,
      @UI.selectionField: [{position: 20 }]
      @UI.lineItem: [{position: 20 }]
      @UI.identification: [{position: 10 }]
      @ObjectModel.text.association: '_agency'
      @Consumption.valueHelpDefinition: [{entity.name: 'yrv_i_u_agency', entity.element: 'AgencyID'}]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      agency_id     as AgencyId,
      @EndUserText.label: 'Customer Number'
      @UI.selectionField: [{position: 30 }]
      @UI.lineItem: [{position: 30 }]
      @UI.identification: [{position: 20 }]
      @ObjectModel.text.association: '_customer'
      @Consumption.valueHelpDefinition: [{entity.name: 'yrv_i_u_customer', entity.element: 'CustomerID'}]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      customer_id   as customerID,
      @UI.identification: [{position: 30 }]
      begin_date    as BeginDate,
      @UI.identification: [{position: 40 }]
      end_date      as EndDate,
      @UI.identification: [{position: 50 }]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee   as BookingFee,
      @UI.lineItem: [{position: 40 }]
      @UI.identification: [{position: 60 }]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price   as TotalPrice,
      @UI.lineItem: [{position: 50 }]
      @UI.identification: [{position: 70 }]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      currency_code as CurrencyCode,
      @UI.lineItem: [{position: 60 }]
      @UI.identification: [{position: 80 }]
      description   as Description,
      @UI.lineItem: [{position: 70, dataAction: 'set_booked',type:#FOR_ACTION,label: 'Change to Booked' }]
      @UI.identification: [{position: 90 }]
      status        as Status,
      _agency,
      _customer,
      _currency
}
