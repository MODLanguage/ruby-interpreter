0.3.26
===
- Remove `*expect`
- Fix problem with references in classes.

0.3.25
===
- Update Rake due to security advisory.

0.3.24
===
- Use base_tests from the grammar repo.
- Updated grammar to support minified MODL.
- Bug fixes for handling minified MODL.

0.3.23
===
- Add support for 5- and 6-digit unicode escape sequences.

0.3.22
===
- Two bug fixes - quoted strings, and incomplete strings for certain output situations.

0.3.21
===
- Bugfix for `*assign` processing.

0.3.20
===
- Support escaping unicode escape sequences so they are not replaced by unicode characters.

0.3.19
===
- Fix bug with `*assign` when there is only 1 item in the array.

0.3.18
===
- Fix problems with `*assign`.

0.3.17
===
- Remove support for `*array`.
- Add support for unicode escape sequences including `~unnnn` and `\unnnn`
- Update `*assign` processing to support a more compact form

0.3.16
===
- Use latest ruby runtime.
- Add support for `*array` keyword.

0.3.15
===
- Interpreter Error: undefined method `text' for nil:NilClass. GitHub issue #23
- Fixed some NOT IMPLEMENTED sections for *method interpretation. GitHub issue #25
- Standardise the error messages to match the Java interpreter.

0.3.14
===
- MODL Syntax Versioning errors update. GitHub issue #11
- Support for escaped % characters - GitHub issue #43

0.3.13
===
- Added missing exceptions for Orphan Pairs

0.3.12
===
- Use file cache on load error - GitHub issue #20
- Error converting value to number - GitHub issue #21
- Problem with punycode - GitHub issue #22
- Handle orphan pairs - adopt then into a map

0.3.11
===
- Support conditional file loading.
- Updated to latest grammar.

0.3.10
===
- Fix GitHub issue #19 - Checking value of object reference in conditional

0.3.9
===
- Fix GitHub Issue #18 - Quoted strings not handled correctly in references

0.3.8
===
- Add MIT license to all non-auto-generated Ruby files.
- Use latest ANTLR4 Ruby runtime - previous version didn't build on AWS.

0.3.7
===
- Update to latest antlr4-ruby-runtime for performance improvements
- Fixed some failing base_tests
- Fixed processing of superclass type conversions.
- Fixed file caching issue - GitHub issue#1
- Fixed GitHub issue#15 unicode problem.
- Fixed GitHub issue#9 *LOAD problem
- Fixed bug in error tests handling
- Fixed stack too deep error for rafs such as `%ref%`
- Fixed GitHub issue#13 No output from objects in loaded file.
- Fixed GitHub issue#14 method chaining problem.
- Correct handling of invalid pair keys.
- Fix file encoding problem for error_tests.json on MS Windows.

0.3.6
===
- Use latest ANTLR4 Ruby.stg updated by Cameron Dutro.
- Use antrl4-runtime v0.2.2 which fixes some issues around Array2DHashSet
- Fixed a failing error test due to incorrect value type for a `*class` with supertype `num`.
- Corrected the ordering of fields within a class.
- Return `null` for empty output rather than `""`
- Fixed GitHub issue#4 - improved error reporting.

0.3.5
===
- Fixed another bug with class handling to expand classes properly.

0.3.4
===
- Fixed a bug with class handling to expand classes properly.
- Add `*expect` to the output for the `%*class` instruction.

0.3.3
===
- Change module name to MODL from Modl.
- Support simpler usage, i.e. `x = MODL.parse(str)`. README.md updated accordingly.
- Ignore *allow and *expect for now, except when used as `x=%*allow` or `x=%*expect`. Proper implementation will follow later.
- Fixed a NilClass exception.
- Disabled file caching due to garbage collection and other issues. See issue#1.
- Grammar update to catch errors from unparsed MODL input.

0.3.2
===
- Update to latest ANTLR4 Runtime

0.3.1
===
- Update to latest ANTLR4 Runtime

0.3.0
===
- First working MODL interpreter for Ruby

0.2.0
===
- Hello world.

0.1.0
===
- Initial release
