@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse view'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_SPAC108_WAREHOUSE as select from zspac108_wh
{
    key warehouse_id as WarehouseId,
    warehouse_name as WarehouseName,
    address as Address,
    city as City,
    postal_code as PostalCode
}
