CLASS ltcl_error_t100 DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test FOR TESTING.

ENDCLASS.

CLASS ltcl_error_t100 IMPLEMENTATION.

  METHOD test.

    TRY.
        MESSAGE i000(oo) WITH 'Hello,' 'World!'.
        RAISE EXCEPTION TYPE /apmg/cx_error_t100.
      CATCH /apmg/cx_error INTO DATA(error).
        cl_abap_unit_assert=>assert_equals(
          act = error->get_text( )
          exp = 'Hello, World!' ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
