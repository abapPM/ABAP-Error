CLASS zcx_error_prev DEFINITION
  PUBLIC
  INHERITING FROM zcx_error_text
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !previous LIKE previous
        !longtext TYPE csequence OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_error_prev IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor(
      text     = previous->get_text( )
      previous = previous
      longtext = longtext ).

  ENDMETHOD.
ENDCLASS.
