@EndUserText.label: 'Parametre til ny vare'
define abstract entity ZA_SPAC108_NEW_PRODUCT
{
  @EndUserText.label: 'Product Name'
  key ProductName : abap.char(40);

  @EndUserText.label: 'Description'
  ProductDesc     : abap.char(100);
}
