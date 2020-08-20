@AbapCatalog.sqlViewName: 'YRV_I_U_AGN_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'UnManaged Interface View - Agency'
define view yrv_i_u_agency
  as select from /dmo/agency
  association [1] to I_Country as _country on $projection.ACountryCode = _country.Country
{

      ///dmo/agency
  key agency_id as AgencyID,
  @Semantics.text: true
      name as AName,
      street as AStreet,
      postal_code as APostalCode,
      city as Aity,
      country_code as ACountryCode,
      phone_number as APhone,
      email_address as AEmail,
      web_address as WebAdd,
      _country // Make association public
}
