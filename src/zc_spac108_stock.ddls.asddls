@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_SPAC108_STOCK
  provider contract transactional_query
  as projection on ZR_SPAC108_STOCK
{
  key WarehouseId,
  key ProductId,

  @UI.lineItem: [{ position: 10 }]
  _Warehouse.WarehouseName as WarehouseName,

  @UI.lineItem: [{ position: 20 }]
  _Warehouse.City          as City,

  @UI.lineItem: [{ position: 30 }]
  _Product.ProductName     as ProductName,

  @UI.lineItem: [{ position: 40 }]
  Amount,

  _Product,
  _Warehouse
}
