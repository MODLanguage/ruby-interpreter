0.3.11
===
- 

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
