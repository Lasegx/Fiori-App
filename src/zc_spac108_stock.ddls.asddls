@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock projection view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
  typeName: 'Stock entry',
  typeNamePlural: 'Stock'
}
define root view entity ZC_SPAC108_STOCK
  provider contract transactional_query
  as projection on ZR_SPAC108_STOCK
{
  @EndUserText.label: 'Warehouse ID'
  key WarehouseId,

  @EndUserText.label: 'Product ID'
  key ProductId,

  @EndUserText.label: 'Warehouse'
  @UI.lineItem: [{ position: 10 }]
  _Warehouse.WarehouseName as WarehouseName,

  @EndUserText.label: 'City'
  @UI.lineItem: [{ position: 20 }]
  _Warehouse.City          as City,

  @EndUserText.label: 'Product'
  @UI.lineItem: [{ position: 30 }]
  _Product.ProductName     as ProductName,

  @EndUserText.label: 'Amount in stock'
  @UI.lineItem: [{ position: 40 }]
  Amount,

  _Product,
  _Warehouse
}
