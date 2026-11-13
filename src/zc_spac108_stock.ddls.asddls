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
  @UI.facet: [{
    id: 'General', purpose: #STANDARD,
    type: #IDENTIFICATION_REFERENCE, label: 'Stock', position: 10
  }]
  
  @EndUserText.label: 'Warehouse ID'
  @UI.identification: [{ position: 10 }]
  key WarehouseId,

  @EndUserText.label: 'Product ID'
  @UI.identification: [{ position: 20 }]
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
  @UI.identification: [{ position: 30 }]
  Amount,
  
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,

  _Product,
  _Warehouse
}
