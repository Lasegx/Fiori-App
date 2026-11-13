@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product projection view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
  typeName: 'Product',
  typeNamePlural: 'Products',
  title: { type: #STANDARD, value: 'ProductName' }
}
define root view entity ZC_SPAC108_PRODUCT
  provider contract transactional_query
  as projection on ZR_SPAC108_PRODUCT
{
  @UI.facet: [{
    id: 'General', purpose: #STANDARD,
    type: #IDENTIFICATION_REFERENCE, label: 'Product', position: 10
  }]
  @EndUserText.label: 'Product ID'
  @UI.lineItem:       [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  key ProductId,
  
  @EndUserText.label: 'Product Name' 
  @UI.lineItem:       [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  ProductName,

  @EndUserText.label: 'Description'
  @UI.lineItem:       [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  ProductDesc,

  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
}
