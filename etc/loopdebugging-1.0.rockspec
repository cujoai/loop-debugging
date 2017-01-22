package = "loopdebugging"
version = "1.0-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   summary = "LOOP classes of debugging utilities.",
   detailed = "Classes useful for instrumentation of Lua code or implementation of logging mechanisms for applications.
",
   homepage = "https://git.tecgraf.puc-rio.br/maia/lua-loopdebugging",
   license = "MIT"
}
dependencies = {
	"lua >= 5.2, < 5.4",
	"loop >= 3.0, < 4.0",
}
build = {
   type = "builtin",
   modules = {
      ['loop.debug.Crawler'] = "lua/loop/debug/Crawler.lua",
      ['loop.debug.Matcher'] = "lua/loop/debug/Matcher.lua",
      ['loop.debug.Verbose'] = "lua/loop/debug/Verbose.lua",
      ['loop.debug.Viewer'] = "lua/loop/debug/Viewer.lua"
   }
}
