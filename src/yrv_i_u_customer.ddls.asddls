@AbapCatalog.sqlViewName: 'YRV_I_U_CUST_V'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'UnManaged Interface View - Customer Data'
define view yrv_I_u_customer
  as select from /dmo/customer
  association [1] to I_Country as _country on $projection.CountryCode = _country.Country
{

      ///dmo/customer
  key customer_id   as CustomerID,
  @Semantics.text: true
      first_name    as FirstName,
      last_name     as LastName,
      title         as Title,
      street        as Street,
      postal_code   as PostalCode,
      city          as City,
      country_code  as CountryCode,
      phone_number  as Phone,
      email_address as Email,
      _country // Make association public
}
