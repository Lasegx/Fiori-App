CLASS zcl_spac108_master_loader DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_spac108_master_loader IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Erklær de to interne tabeller med samme opbygning som databasetabellerne
    DATA lt_products   TYPE STANDARD TABLE OF zspac108_prod WITH EMPTY KEY.
    DATA lt_warehouses TYPE STANDARD TABLE OF zspac108_wh   WITH EMPTY KEY.

    " Fem produkter (product_id 1-5)
    lt_products = VALUE #(
      ( product_id = 1 product_name = 'Kaffe'       product_desc = 'Formalet filterkaffe, 500 g' )
      ( product_id = 2 product_name = 'Te'          product_desc = 'Sort te i breve, 100 stk.' )
      ( product_id = 3 product_name = 'Chokolade'   product_desc = 'Moerk chokolade, 200 g' )
      ( product_id = 4 product_name = 'Smaakager'   product_desc = 'Havreknas i pakke, 300 g' )
      ( product_id = 5 product_name = 'Mineralvand' product_desc = 'Danskvand, 0,5 liter' )
    ).

    " Tre lagerhaller (warehouse_id 1-3), en af dem i Esbjerg
    lt_warehouses = VALUE #(
      ( warehouse_id = 1 warehouse_name = 'Lager Aalborg'
        address = 'Havnegade 10'   city = 'Aalborg' postal_code = '9000' )
      ( warehouse_id = 2 warehouse_name = 'Lager Esbjerg'
        address = 'Kajen 5'        city = 'Esbjerg' postal_code = '6700' )
      ( warehouse_id = 3 warehouse_name = 'Lager Odense'
        address = 'Industrivej 22' city = 'Odense'  postal_code = '5000' )
    ).

    " Ryd først, så klassen kan køres flere gange uden dubletter
    DELETE FROM zspac108_prod.
    DELETE FROM zspac108_wh.

    " Indsæt rækkerne i databasen
    INSERT zspac108_prod FROM TABLE @lt_products.
    DATA(lv_products) = sy-dbcnt.

    INSERT zspac108_wh FROM TABLE @lt_warehouses.
    DATA(lv_warehouses) = sy-dbcnt.

    out->write( |{ lv_products } produkter og { lv_warehouses } lagre indsat| ).

  ENDMETHOD.

ENDCLASS.
