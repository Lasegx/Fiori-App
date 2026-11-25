@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse projection view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
  typeName: 'Warehouse',
  typeNamePlural: 'Warehouses',
  title: { type: #STANDARD, value: 'WarehouseName' }
}
define root view entity ZC_SPAC108_WAREHOUSE
  provider contract transactional_query
  as projection on ZR_SPAC108_WAREHOUSE
{
  @UI.facet: [
    { id: 'General', purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE,
      label: 'Warehouse', position: 10 },
    { id: 'Stock', purpose: #STANDARD, type: #LINEITEM_REFERENCE,
      label: 'Stock', position: 20, targetElement: '_Stock' },
    { id: 'Product', purpose: #STANDARD, type: #LINEITEM_REFERENCE,
      label: 'Product', position: 30, targetElement: '_AllProducts' } 
  ]

    @EndUserText.label: 'Warehouse ID'
  @UI.lineItem:       [{ position: 10 }]
  @UI.identification: [{ position: 10 },
                       { type: #FOR_ACTION, dataAction: 'CreateProduct',
                         label: 'Ny vare', position: 90 }]
  key WarehouseId,

  @EndUserText.label: 'Name'
  @UI.lineItem:       [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  WarehouseName,

  @EndUserText.label: 'Address'
  @UI.lineItem:       [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  Address,

  @EndUserText.label: 'City'
  @UI.lineItem:       [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  City,

  @EndUserText.label: 'Postal code'
  @UI.lineItem:       [{ position: 50 }]
  @UI.identification: [{ position: 50 }]
  PostalCode,

  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,

  _Stock       : redirected to composition child ZC_SPAC108_STOCK,
  _AllProducts : redirected to ZC_SPAC108_PRODUCT
}

