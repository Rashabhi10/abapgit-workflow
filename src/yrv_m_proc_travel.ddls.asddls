@EndUserText.label: 'Travel - Managed - Proccesor'
@AccessControl.authorizationCheck: #CHECK
@UI.headerInfo:{ typeName: 'Travel Detail',
                typeNamePlural: 'Travel Details',
                title: { type: #STANDARD, value: 'travel_id'}}

@Search.searchable: true

define root view entity yrv_m_proc_travel
  as projection on yrv_m_travel_sup as Travel
{
      //yrv_m_travel_sup
      @UI.facet: [{id: 'Travel',
       purpose: #STANDARD,
       type: #IDENTIFICATION_REFERENCE,
       position: 10 ,
       label: 'Travel ID'},
       {id: 'Booking',
       purpose: #STANDARD,
       type: #LINEITEM_REFERENCE,
       position: 20 ,
       label: 'Booking',
       targetElement: '_booking'}]

      @UI.lineItem: [{position: 10 },
      {type: #FOR_ACTION, dataAction: 'createTravelTemp', label: 'Create Travel Template'}]
      @UI.identification: [{position: 10 }]
      @UI.selectionField: [{position: 10 }]
      @Search.defaultSearchElement: true
  key travel_id,
      @UI.lineItem: [{position: 20 }]
      @UI.identification: [{position: 20 }]
      @UI.selectionField: [{position: 20 }]
      @Consumption.valueHelpDefinition: [{entity.name: '/DMO/I_Agency', entity.element: 'AgencyID' }]
      @ObjectModel.text.element: ['AgencyName']
      agency_id,
      _agency.AName       as AgencyName,
      @UI.lineItem: [{position: 30 }]
      @UI.identification: [{position: 30 }]
      @UI.selectionField: [{position: 30 }]
      @Consumption.valueHelpDefinition: [{entity.name: '/DMO/I_Customer', entity.element: 'CustomerID' }]
      @ObjectModel.text.element: ['FirstName']
      customer_id,
      _customer.FirstName as FirstName,
      @UI.lineItem: [{position: 40 }]
      @UI.identification: [{position: 40 }]
      @UI.selectionField: [{position: 40 }]
      begin_date,
      @UI.lineItem: [{position: 50 }]
      @UI.identification: [{position: 50 }]
      @UI.selectionField: [{position: 50 }]
      end_date,
      @UI.lineItem: [{position: 60 }]
      @UI.identification: [{position: 60 }]
      @UI.selectionField: [{position: 60 }]
      booking_fee,
      @UI.lineItem: [{position: 70 }]
      @UI.identification: [{position: 70 }]
      @UI.selectionField: [{position: 70 }]
      total_price,
      @UI.lineItem: [{position: 80 }]
      @UI.identification: [{position: 80 }]
      @UI.selectionField: [{position: 80 }]
      @Consumption.valueHelpDefinition: [{entity.name: 'I_Currency', entity.element: 'Currency' }]
      currency_code,
      @UI.lineItem: [{position: 90 }]
      @UI.identification: [{position: 90 }]
      @UI.selectionField: [{position: 90 }]
      description,
      @UI.lineItem: [{position: 100 }]
      @UI.identification: [{position: 100 }]
      @UI.selectionField: [{position: 100 }]
      overall_status,
      @UI.hidden: true
      last_changed_at,
      /* Associations */
      //yrv_m_travel_sup
      _agency,
      _booking : redirected to composition child yrv_m_proc_booking,
      _curr,
      _customer
}
