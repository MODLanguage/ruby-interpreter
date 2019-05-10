0.3.4
===
- Fixed a bug with class handling to expand classes properly.

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
