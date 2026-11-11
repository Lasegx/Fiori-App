@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_SPAC108_STOCK
  as select from zspac108_stock
  association [0..1] to ZR_SPAC108_PRODUCT   as _Product
    on $projection.ProductId = _Product.ProductId
  association [0..1] to ZR_SPAC108_WAREHOUSE as _Warehouse
    on $projection.WarehouseId = _Warehouse.WarehouseId
{
  key warehouse_id as WarehouseId,
  key product_id   as ProductId,
      amount       as Amount,

      // Associations gøres tilgængelige for projektionen
      _Product,
      _Warehouse
}
