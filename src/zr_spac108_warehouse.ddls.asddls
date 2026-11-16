@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_SPAC108_WAREHOUSE
  as select from zspac108_wh
{
  key warehouse_id   as WarehouseId,
      warehouse_name as WarehouseName,
      address        as Address,
      city           as City,
      postal_code    as PostalCode,

      @Semantics.user.createdBy: true
      local_created_by as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at as LocalCreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      local_last_change_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_change_at as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_change_at as LastChangedAt
}
