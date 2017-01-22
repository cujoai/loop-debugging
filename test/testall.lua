local Runner = require "loop.test.Results"
local Reporter = require "loop.test.Reporter"
local runner = Runner{ reporter = Reporter{ time = socket and socket.gettime } }
runner("LOOP Debug Classes", require("loop.tests.debug.Suite"), runner)

