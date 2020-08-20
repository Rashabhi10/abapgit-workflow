@AbapCatalog.sqlViewName: 'YCDS_AOC_2_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo CDS'
define view ycds_aoc_2 as select from ydemo_empl as a {
    key a.emp_id,
    a.tel_number
}
