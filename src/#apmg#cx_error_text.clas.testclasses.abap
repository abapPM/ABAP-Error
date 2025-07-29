CLASS ltcl_error_text DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test FOR TESTING.

ENDCLASS.

CLASS ltcl_error_text IMPLEMENTATION.

  METHOD test.

    TRY.
        RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = 'Test'.
      CATCH /apmg/cx_error INTO DATA(error).
        cl_abap_unit_assert=>assert_equals(
          act = error->get_text( )
          exp = 'Test' ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
