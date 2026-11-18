CLASS lhc_Stock DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Stock RESULT result.

    METHODS validateAmount FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateAmount.

    METHODS validateUnique FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateUnique.
ENDCLASS.


CLASS lhc_Stock IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD validateAmount.
    " Læs beholdningen på de rækker, der skal valideres
    READ ENTITIES OF zr_spac108_stock IN LOCAL MODE
      ENTITY Stock
        FIELDS ( Amount )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      " Ryd gamle beskeder for denne validation
      APPEND VALUE #( %tky        = ls_stock-%tky
                      %state_area = 'VALIDATE_AMOUNT' ) TO reported-stock.

      IF ls_stock-Amount < 0.
        " failed blokerer, at rækken bliver gemt
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-stock.

        " reported viser beskeden til brugeren
        APPEND VALUE #(
          %tky            = ls_stock-%tky
          %state_area     = 'VALIDATE_AMOUNT'
          %msg            = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Lagerbeholdningen må ikke være negativ' )
          %element-Amount = if_abap_behv=>mk-on ) TO reported-stock.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.


    METHOD validateUnique.
    READ ENTITIES OF zr_spac108_stock IN LOCAL MODE
      ENTITY Stock
        FIELDS ( WarehouseId ProductId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      " Ryd gamle beskeder for denne validation
      APPEND VALUE #( %tky        = ls_stock-%tky
                      %state_area = 'VALIDATE_UNIQUE' ) TO reported-stock.

      " Tjekket kører kun på kladden (se forklaring nedenfor)
      CHECK ls_stock-%is_draft = if_abap_behv=>mk-on.

      " Findes der allerede en aktiv (gemt) række med samme lager og vare?
      READ ENTITIES OF zr_spac108_stock IN LOCAL MODE
        ENTITY Stock
          FIELDS ( WarehouseId )
          WITH VALUE #( ( %is_draft        = if_abap_behv=>mk-off
                          %key-WarehouseId = ls_stock-WarehouseId
                          %key-ProductId   = ls_stock-ProductId ) )
        RESULT DATA(lt_existing).

      IF lt_existing IS NOT INITIAL.
        APPEND VALUE #( %tky = ls_stock-%tky ) TO failed-stock.

        APPEND VALUE #(
          %tky                 = ls_stock-%tky
          %state_area          = 'VALIDATE_UNIQUE'
          %msg                 = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = 'Varen findes allerede på dette lager' )
          %element-WarehouseId = if_abap_behv=>mk-on
          %element-ProductId   = if_abap_behv=>mk-on ) TO reported-stock.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
