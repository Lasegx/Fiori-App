@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_SPAC108_PRODUCT as select from zspac108_prod
{
    key product_id as ProductId,
    product_name as ProductName,
    product_desc as ProductDesc
}
