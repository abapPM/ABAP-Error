![Version](https://img.shields.io/endpoint?url=https://shield.abappm.com/github/abapPM/ABAP-Exceptions/src/%2523apmg%2523cx_error.clas.abap/c_version&label=Version&color=blue)

[![License](https://img.shields.io/github/license/abapPM/ABAP-Exceptions?label=License&color=success)](https://github.com/abapPM/ABAP-Exceptions/blob/main/LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg?color=success)](https://github.com/abapPM/.github/blob/main/CODE_OF_CONDUCT.md)
[![REUSE Status](https://api.reuse.software/badge/github.com/abapPM/ABAP-Exceptions)](https://api.reuse.software/info/github.com/abapPM/ABAP-Exceptions)

# Error

General-purpose exception classes. Support for `RAISE EXCEPTION` statement (recommended and better debugging) and class methods (shorter code).

NO WARRANTIES, [MIT License](https://github.com/abapPM/ABAP-Exceptions/blob/main/LICENSE)

## Usage

Raise an exception with free-form text:

```abap
RAISE EXCEPTION TYPE /apmg/cx_error_text EXPORTING text = 'Not found'.
```

Raise an exception concerning another exception:

```abap
TRY.
    "... some code that raises an exception
  CATCH cx_root INTO DATA(error).
    RAISE EXCEPTION TYPE /apmg/cx_error_prev EXPORTING previous = error. 
ENDTRY.
```

Raise an exception with current system message (T100). This is useful, for example, after function calls that set a message. 

```abap
RAISE EXCEPTION TYPE /apmg/cx_error_t100.
```

For convenience, you can use `/apmg/cx_error=>null` to avoid output of the message without the need to define a local variable:

```abap
MESSAGE e001(00) WITH 'error value' 'more text' INTO /apmg/cx_error=>null. 
RAISE EXCEPTION TYPE /apmg/cx_error_t100.
```

The exception can also be raised via class method:

```abap
" Free-form text
/apmg/cx_error=>raise( 'Not found' ).

" Based on other exception
/apmg/cx_error=>raise_with_text( error ).

/apmg/cx_error=>raise(
  text     = 'Overwrite error text'
  previous = error ).

" System message
/apmg/cx_error=>raise_t100( ).

```

## Prerequisites

SAP Basis 7.50 or higher

## Installation

Install `error` as a global module in your system using [apm](https://abappm.com).

or

Specify the `error` module as a dependency in your project and import it to your namespace using [apm](https://abappm.com).

## Contributions

All contributions are welcome! Read our [Contribution Guidelines](https://github.com/abapPM/ABAP-Exceptions/blob/main/CONTRIBUTING.md), fork this repo, and create a pull request.

You can install the developer version of ABAP Error using [abapGit](https://github.com/abapGit/abapGit) either by creating a new online repository for `https://github.com/abapPM/ABAP-Exceptions`.

Recommended SAP package: `/APMG/EXCEPTIONS`

## About

Made with ❤ in Canada

Copyright 2025 apm.to Inc. <https://apm.to>

Follow [@marcf.be](https://bsky.app/profile/marcf.be) on Bluesky and [@marcfbe](https://linkedin.com/in/marcfbe) or LinkedIn
