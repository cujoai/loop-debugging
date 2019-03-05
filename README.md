LOOP Debugging Utilities
========================

This group contains classes useful for instrumentation of Lua code or implementation of logging mechanisms for applications.
These classes usually perform slow operations or use of the debug API of Lua and therefore should not be used heavily in implementation of performance critical applications.

- [**Viewer**](doc/Viewer.md): generate human-readable textual representation of Lua values.
- [**Matcher**](doc/Matcher.md): compare a pair of Lua values according to some criteria of similarity.
- [**Verbose**](doc/Verbose.md): generate and manage log messages during the execution of a code.
- [**Crawler**](doc/Crawler.md): nagivage through all objects accessible from a root value.
