@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_SPAC108_STOCK 
    as select from zspac108_stock
{
    key warehouse_id as WarehouseId,
    key product_id as ProductId,
    amount as Amount
}
