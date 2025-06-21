CLASS ltcx_error_prev DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test FOR TESTING.

ENDCLASS.

CLASS ltcx_error_prev IMPLEMENTATION.

  METHOD test.

    TRY.
        TRY.
            DATA(i) = 1 / 0.
          CATCH cx_root INTO DATA(previous).
            RAISE EXCEPTION TYPE zcx_error_prev EXPORTING previous = previous.
        ENDTRY.
        cl_abap_unit_assert=>fail( ).
      CATCH zcx_error INTO DATA(error).
        cl_abap_unit_assert=>assert_equals(
          act = error->get_text( )
          exp = 'Division by zero' ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
