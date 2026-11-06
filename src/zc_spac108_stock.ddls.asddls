@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_SPAC108_STOCK
  provider contract transactional_query
  as projection on ZR_SPAC108_STOCK
{
  @UI.lineItem: [{ position: 10 }]
  key WarehouseId,

  @UI.lineItem: [{ position: 20 }]
  key ProductId,

  @UI.lineItem: [{ position: 30 }]
  Amount
}
