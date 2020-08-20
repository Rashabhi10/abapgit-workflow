@AbapCatalog.sqlViewName: 'YCD_AOC_1_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Data'

@UI.headerInfo: {
    typeName: 'Employee Detail',
    typeNamePlural: 'Employee Details'
}

define root view ycds_aoc_1
  as select from ydemo_empl as a
{
      @UI.facet: [{ id : 'emp_id',
                    type: #IDENTIFICATION_REFERENCE,
                    label: 'Employee Details'}]

      @UI.selectionField: [{position: 10}]
      @UI.lineItem: [{position: 10, label: 'First Name' }]
      @UI.identification: [{position: 10 }]

  key a.first_name,
      @UI.selectionField: [{position: 20}]
      @UI.lineItem: [{position: 20, label: 'Last Name' }]
      @UI.identification: [{position: 20 }]
  key a.last_name,
      @UI.selectionField: [{position: 30}]
      @UI.lineItem: [{position: 30, label: 'Employee ID' }]
      @UI.identification: [{position: 30 }]
  key a.emp_id,
      @UI.selectionField: [{position: 40}]
      @UI.lineItem: [{position: 40 }]
      @UI.identification: [{position: 40 }]
      a.gender,
      @UI.selectionField: [{position: 50}]
      @UI.lineItem: [{position: 50 }]
      @UI.identification: [{position: 50 }]
      a.tel_number
}
