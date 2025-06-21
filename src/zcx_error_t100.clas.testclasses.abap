CLASS ltcx_error_t100 DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test FOR TESTING.

ENDCLASS.

CLASS ltcx_error_t100 IMPLEMENTATION.

  METHOD test.

    TRY.
        MESSAGE i000(oo) WITH 'Hello,' 'World!'.
        RAISE EXCEPTION TYPE zcx_error_t100.
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error INTO DATA(lx_error).
        cl_abap_unit_assert=>assert_equals(
          act = lx_error->get_text( )
          exp = 'Hello, World!' ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
