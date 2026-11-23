CLASS lhc_Stock DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS validateAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateAmount.

    METHODS validateUnique FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateUnique.

    METHODS validateProduct FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateProduct.
ENDCLASS.


CLASS lhc_Stock IMPLEMENTATION.

  METHOD validateAmount.
    READ ENTITIES OF zr_spac108_warehouse IN LOCAL MODE
      ENTITY Stock
        FIELDS ( Amount )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      APPEND VALUE #(
        %tky        = ls_stock-%tky
        %state_area = 'VALIDATE_AMOUNT'
        %path       = VALUE #( warehouse-%is_draft   = ls_stock-%is_draft
                               warehouse-WarehouseId = ls_stock-WarehouseId )
      ) TO reported-stock.

      IF ls_stock-Amount < 0.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-stock.

        APPEND VALUE #(
          %tky            = ls_stock-%tky
          %state_area     = 'VALIDATE_AMOUNT'
          %path           = VALUE #( warehouse-%is_draft   = ls_stock-%is_draft
                                     warehouse-WarehouseId = ls_stock-WarehouseId )
          %msg            = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Lagerbeholdningen må ikke være negativ' )
          %element-Amount = if_abap_behv=>mk-on
        ) TO reported-stock.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD validateUnique.
    READ ENTITIES OF zr_spac108_warehouse IN LOCAL MODE
      ENTITY Stock
        FIELDS ( WarehouseId ProductId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      APPEND VALUE #(
        %tky        = ls_stock-%tky
        %state_area = 'VALIDATE_UNIQUE'
        %path       = VALUE #( warehouse-%is_draft   = ls_stock-%is_draft
                               warehouse-WarehouseId = ls_stock-WarehouseId )
      ) TO reported-stock.

      CHECK ls_stock-%is_draft = if_abap_behv=>mk-on.

      READ ENTITIES OF zr_spac108_warehouse IN LOCAL MODE
        ENTITY Stock
          FIELDS ( WarehouseId )
          WITH VALUE #( ( %is_draft        = if_abap_behv=>mk-off
                          %key-WarehouseId = ls_stock-WarehouseId
                          %key-ProductId   = ls_stock-ProductId ) )
        RESULT DATA(lt_existing).

      IF lt_existing IS NOT INITIAL.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-stock.

        APPEND VALUE #(
          %tky               = ls_stock-%tky
          %state_area        = 'VALIDATE_UNIQUE'
          %path              = VALUE #( warehouse-%is_draft   = ls_stock-%is_draft
                                        warehouse-WarehouseId = ls_stock-WarehouseId )
          %msg               = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Varen findes allerede på dette lager' )
          %element-ProductId = if_abap_behv=>mk-on
        ) TO reported-stock.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD validateProduct.
    READ ENTITIES OF zr_spac108_warehouse IN LOCAL MODE
      ENTITY Stock
        FIELDS ( ProductId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      APPEND VALUE #(
        %tky        = ls_stock-%tky
        %state_area = 'VALIDATE_PRODUCT'
        %path       = VALUE #( warehouse-%is_draft   = ls_stock-%is_draft
                               warehouse-WarehouseId = ls_stock-WarehouseId )
      ) TO reported-stock.

      READ ENTITIES OF zr_spac108_product
        ENTITY Product
          FIELDS ( ProductId )
          WITH VALUE #( ( %is_draft      = if_abap_behv=>mk-off
                          %key-ProductId = ls_stock-ProductId ) )
        RESULT DATA(lt_product)
        FAILED DATA(lt_failed).

      IF lt_product IS INITIAL.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-stock.

        APPEND VALUE #(
          %tky               = ls_stock-%tky
          %state_area        = 'VALIDATE_PRODUCT'
          %path              = VALUE #( warehouse-%is_draft   = ls_stock-%is_draft
                                        warehouse-WarehouseId = ls_stock-WarehouseId )
          %msg               = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Varen findes ikke' )
          %element-ProductId = if_abap_behv=>mk-on
        ) TO reported-stock.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
