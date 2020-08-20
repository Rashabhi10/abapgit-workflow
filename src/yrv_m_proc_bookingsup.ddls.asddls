@EndUserText.label: 'Booking Supplement - Processor'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI.headerInfo:{
typeName: 'Booking Supp Detail',
typeNamePlural: 'Booking Supp Details',
title.type: #STANDARD,
title.value: 'booking_id'
}

define view entity yrv_m_proc_bookingsup
  as projection on yrv_m_bookingsup as BookingSup
{
      //yrv_m_bookingsup
      @UI.facet: [{position: 10,
                   id: 'Booking',
                   label: 'Booking Detail',
                   purpose: #STANDARD,
                   type: #IDENTIFICATION_REFERENCE},
                   {
                   position: 20,
                   id: 'BookingSupp',
                   label: 'Booking Supplement',
                   purpose: #STANDARD,
                   type: #LINEITEM_REFERENCE,
                   targetElement: '_suppl'
                   }]
      @UI.lineItem: [{position: 10 }]
      @UI.identification: [{position: 10 }]
  key travel_id,
      @UI.lineItem: [{position: 20 }]
      @UI.identification: [{position: 20 }]
  key booking_id,
      @UI.lineItem: [{position: 30 }]
      @UI.identification: [{position: 30 }]
  key booking_supplement_id,
      @UI.lineItem: [{position: 40 }]
      @UI.identification: [{position: 40 }]
      supplement_id,
      @UI.lineItem: [{position: 50 }]
      @UI.identification: [{position: 50 }]
      @Semantics.amount.currencyCode: 'currency_code'
      price,
      @UI.lineItem: [{position: 60 }]
      @UI.identification: [{position: 60 }]
      @Semantics.currencyCode: true
      currency_code,
      @UI.hidden: true
      last_changed_at,
      /* Associations */
      //yrv_m_bookingsup
      _booking : redirected to parent yrv_m_proc_booking,
      _suppl,
      _supplText

}
