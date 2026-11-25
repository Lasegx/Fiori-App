@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock projection view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
  typeName: 'Stock entry',
  typeNamePlural: 'Stock'
}
define view entity ZC_SPAC108_STOCK
  as projection on ZR_SPAC108_STOCK
{
  @UI.facet: [{
    id: 'General', purpose: #STANDARD,
    type: #IDENTIFICATION_REFERENCE, label: 'Stock', position: 10
  }]

  @EndUserText.label: 'Warehouse ID'
  key WarehouseId,

  @EndUserText.label: 'Product ID'
  @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZC_SPAC108_PRODUCT', element: 'ProductId' },
    useForValidation: true }]
  @UI.lineItem:       [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  key ProductId,

  @EndUserText.label: 'Product'
  @UI.lineItem: [{ position: 20 }]
  _Product.ProductName as ProductName,

    @EndUserText.label: 'Amount in stock'
  @UI.dataPoint: {
    title: 'Amount in stock',
    criticalityCalculation: {
      improvementDirection: #MAXIMIZE,
      deviationRangeLowValue: 10,
      toleranceRangeLowValue: 50
    }
  }
  @UI.lineItem:       [{ position: 30, type: #AS_DATAPOINT }]
  @UI.identification: [{ position: 20 }]
  Amount,

  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,

  _Warehouse : redirected to parent ZC_SPAC108_WAREHOUSE,
  _Product   : redirected to ZC_SPAC108_PRODUCT
}
