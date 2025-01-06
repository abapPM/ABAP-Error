CLASS zcx_error DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

************************************************************************
* Error
*
* Copyright 2024 apm.to Inc. <https://apm.to>
* SPDX-License-Identifier: MIT
************************************************************************
  PUBLIC SECTION.

    CONSTANTS c_version TYPE string VALUE '1.0.0' ##NEEDED.

    INTERFACES:
      if_t100_dyn_msg,
      if_t100_message.

    CLASS-DATA null TYPE string.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !msgv1    TYPE symsgv OPTIONAL
        !msgv2    TYPE symsgv OPTIONAL
        !msgv3    TYPE symsgv OPTIONAL
        !msgv4    TYPE symsgv OPTIONAL.

    "! Raise exception with text
    "! @parameter text | Text
    "! @parameter previous | Previous exception
    "! @raising zcx_error | Exception
    CLASS-METHODS raise
      IMPORTING
        !text     TYPE clike
        !previous TYPE REF TO cx_root OPTIONAL
      RAISING
        zcx_error.

    "! Raise exception with T100 message
    "! <p>
    "! Will default to sy-msg* variables. These need to be set right before calling this method.
    "! </p>
    "! @parameter msgid | Message ID
    "! @parameter msgno | Message number
    "! @parameter msgv1 | Message variable 1
    "! @parameter msgv2 | Message variable 2
    "! @parameter msgv3 | Message variable 3
    "! @parameter msgv4 | Message variable 4
    "! @parameter previous | Previous exception
    "! @raising zcx_error | Exception
    CLASS-METHODS raise_t100
      IMPORTING
        msgid     TYPE symsgid DEFAULT sy-msgid
        msgno     TYPE symsgno DEFAULT sy-msgno
        msgv1     TYPE symsgv DEFAULT sy-msgv1
        msgv2     TYPE symsgv DEFAULT sy-msgv2
        msgv3     TYPE symsgv DEFAULT sy-msgv3
        msgv4     TYPE symsgv DEFAULT sy-msgv4
        !previous TYPE REF TO cx_root OPTIONAL
      RAISING
        zcx_error.

    "! Raise with text from previous exception
    "! @parameter previous | Previous exception
    "! @raising zcx_error | Exception
    CLASS-METHODS raise_with_text
      IMPORTING
        !previous TYPE REF TO cx_root
      RAISING
        zcx_error.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS c_generic_error_msg TYPE string VALUE `An error occured`.

ENDCLASS.



CLASS zcx_error IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    if_t100_dyn_msg~msgv1 = msgv1.
    if_t100_dyn_msg~msgv2 = msgv2.
    if_t100_dyn_msg~msgv3 = msgv3.
    if_t100_dyn_msg~msgv4 = msgv4.

    CLEAR me->textid.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.


  METHOD raise.

    IF text IS INITIAL.
      cl_message_helper=>set_msg_vars_for_clike( c_generic_error_msg ).
    ELSE.
      cl_message_helper=>set_msg_vars_for_clike( text ).
    ENDIF.

    raise_t100( previous = previous ).

  ENDMETHOD.


  METHOD raise_t100.

    DATA t100_key TYPE scx_t100key.

    IF msgid IS NOT INITIAL.
      t100_key-msgid = msgid.
      t100_key-msgno = msgno.
      t100_key-attr1 = 'IF_T100_DYN_MSG~MSGV1'.
      t100_key-attr2 = 'IF_T100_DYN_MSG~MSGV2'.
      t100_key-attr3 = 'IF_T100_DYN_MSG~MSGV3'.
      t100_key-attr4 = 'IF_T100_DYN_MSG~MSGV4'.
    ENDIF.

    RAISE EXCEPTION TYPE zcx_error
      EXPORTING
        textid   = t100_key
        msgv1    = msgv1
        msgv2    = msgv2
        msgv3    = msgv3
        msgv4    = msgv4
        previous = previous.

  ENDMETHOD.


  METHOD raise_with_text.

    raise(
      text     = previous->get_text( )
      previous = previous ).

  ENDMETHOD.
ENDCLASS.
