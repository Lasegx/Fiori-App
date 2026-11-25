CLASS lhc_Warehouse DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Warehouse RESULT result.

    METHODS createProduct FOR MODIFY
      IMPORTING keys FOR ACTION Warehouse~CreateProduct.
ENDCLASS.


CLASS lhc_Warehouse IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.


      METHOD createProduct.
    LOOP AT keys INTO DATA(ls_key).

      DATA(lv_name) = condense( ls_key-%param-ProductName ).

      IF lv_name IS INITIAL.
        APPEND VALUE #( %tky = ls_key-%tky ) TO failed-warehouse.
        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Varenavn skal udfyldes' )
        ) TO reported-warehouse.
        CONTINUE.
      ENDIF.

      " Find det næste ledige varenummer
      SELECT MAX( ProductId ) FROM zr_spac108_product INTO @DATA(lv_max).
      DATA(lv_next) = lv_max + 1.

      MODIFY ENTITIES OF zr_spac108_product
        ENTITY Product
          CREATE FIELDS ( ProductId ProductName ProductDesc )
          WITH VALUE #( ( %cid        = 'NEWPRODUCT'
                          %is_draft   = if_abap_behv=>mk-off
                          ProductId   = lv_next
                          ProductName = lv_name
                          ProductDesc = ls_key-%param-ProductDesc ) )
        FAILED   DATA(ls_failed)
        REPORTED DATA(ls_reported).

      IF ls_failed-product IS NOT INITIAL.
        APPEND VALUE #( %tky = ls_key-%tky ) TO failed-warehouse.
        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Varen kunne ikke oprettes' )
        ) TO reported-warehouse.
      ELSE.
        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-success
                   text     = |Varen er oprettet med nummer { lv_next }| )
        ) TO reported-warehouse.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
