CLASS lhc_Stock DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Stock RESULT result.
ENDCLASS.

CLASS lhc_Stock IMPLEMENTATION.
  METHOD get_global_authorizations.
    " Ingen rettighedsstyring i denne opgave
  ENDMETHOD.
ENDCLASS.
