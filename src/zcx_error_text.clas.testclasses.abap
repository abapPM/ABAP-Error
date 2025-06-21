CLASS ltcx_error_text DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test FOR TESTING.

ENDCLASS.

CLASS ltcx_error_text IMPLEMENTATION.

  METHOD test.

    TRY.
        RAISE EXCEPTION TYPE zcx_error_text EXPORTING text = 'Test'.
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error INTO DATA(lx_error).
        cl_abap_unit_assert=>assert_equals(
          act = lx_error->get_text( )
          exp = 'Test' ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
