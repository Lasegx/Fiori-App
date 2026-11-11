@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_SPAC108_PRODUCT
  as select from zspac108_prod
{
  key product_id        as ProductId,
      product_name      as ProductName,
      product_desc      as ProductDesc,

      @Semantics.user.createdBy: true
      local_created_by  as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at  as LocalCreatedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      local_last_change_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_change_at as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_change_at as LastChangedAt
}
