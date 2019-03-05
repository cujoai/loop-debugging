Index
=====

- [`Verbose`](#verbose)
	- [`verbose.custom`](#verbosecustom)
	- [`verbose:flag`](#verboseflag-name--status)
	- [`verbose.groups`](#verbosegroups)
	- [`verbose:level`](#verboselevel-value)
	- [`verbose:newlevel`](#verbosenewlevel-level--group)
	- [`verbose.pause`](#verbosepause)
	- [`verbose:setgroup`](#verbosesetgroup-name-group)
	- [`verbose:setlevel`](#verbosesetlevel-level-group)
	- [`verbose:settimeformat`](#verbosesettimeformat-format)
	- [`verbose.showthread`](#verboseshowthread)
	- [`verbose.taglength`](#verbosetaglength)
	- [`verbose.timed`](#verbosetimed)
	- [`verbose.viewer`](#verboseviewer)
- [`Remarks`](#remarks)
- [`Examples`](#examples)
	- [Counter Log](#counter-log)

Contents
========

Verbose
-------

Class of objects that provide operations to generate and manage verbose messages of a continuous application.
All messages are flagged and may be hierarchly organized in order to reflect the application structure.
The flagged messages can be turned on/off by flag or group of flags.
The messages also provides support for indentation in order to reflect the hierarchical structure of the calls of functions of the application.
This class is useful for implementation of logging mechanisms in server applications.

Each object can be indexed to provide a method to be used to generate verbose messages.
The name of the method is the flag of the message produced.
The methods provided accept an abritrary number of values that are written to the output if the message flag is active.
Optionally, these methods also receive a `boolean` as the first parameter that indicates if the indentation level should be increased (`true`) or decreased (`false`).

### `verbose.viewer`

Object used to print out messages of the command prompt.
The object must provide the same API of instances of [`Viewer`](Viewer.md).
The default value for this field is an instance of `Viewer` with `maxdepth` set to 2.

### `verbose.taglength`

Number indicating how much characters of the flag name shall be in the output message.
The default value is 9.

### `verbose.showthread`

Boolean that indicates whether the change of the current thread shall be indicated in the output.

### `verbose.threadruler`

String that prefixes the thread label whenever a different thread generates an output message.
The default value is:
```
------------------------------------------------------------------------------->
```

### `verbose.groups`

Table that maps the name of a group of flags to a list of the flags belonging tho that group.
It also maps the number of a given verbose level to the list of flags introduced at that level.
This table should be accessed through metods [`verbose:newlevel`](#verbosenewlevel-level--group), [`verbose:setgroup`](#verbosesetgroup-name-group), and [`verbose:setlevel`](#verbosesetlevel-level-group).

### `verbose.custom`

Table that maps the name of a flag to a function used to generate a custom message from the parameters passed to the method used to generate the message.
The custom function receives as arguments the `Verbose` instance (_i.e._ like an ordinary method) and all the values passed to the method called to generate the message.
The custom function is responsible to write the message using the `viewer` field.
Additionally, the custom function may cancel the message customization by returning some value (that evaluates to `true`), in such case the message is produced as if no custom function were defined.

### `verbose.pause`

Table that maps the name of a flag or group of flags to a function that is called after each message of that flag is generated.
Typically, this is used to introduce a pause at each message of a given flag.
Optionally, this field may be set to a function, in such case, this function is used for all flagged messages generated through that instance.
If the value set for a given flag or group of flags or even all flags (_i.e._ by setting the value of the field itself) is the value `true` then the function `io.read()` is used to introduce a pause at the end of each message generation.

### `verbose.timed`

Table that map the name of a flag or group of flags to a string used as a parameter to the function [`os.date`](http://www.lua.org/manual/5.3/manual.html#pdf-os.date) to generate a timestamp for each generated message of that flag.
Optionally, this field may be set to a string, in such case, this string is used for all flagged messages generated through that instance.
If the value set for a given flag or group of flags or even all flags (_i.e._ by setting the value of the field itself) is the value `true` then default format of function [`os.date`](http://www.lua.org/manual/5.3/manual.html#pdf-os.date) is used to create a timestamp for the messages.

### `verbose:settimeformat (format)`

Sets the format passed to function [`os.date`](http://www.lua.org/manual/5.3/manual.html#pdf-os.date) to generate time stamps as defined by field [`verbose.timed`](#verbosetimed).

### `verbose:flag (name [, status])`

Activates the flag or group of flags `name` if `status` evaluates to `true`, and all further messages generated with that flag will be printed.
Otherwise, the flag or group of flags `name` is deactivated and all calls to the method used to generate messages with that flags are ignored.
If `status` is not provided, the call returns `true` if the flag is currently activated or `false` otherwise.

### `verbose:level ([value])`

If `value` is provided then this value is set as the current verbose level in such way that all flags from the same level or lower are active and flags of levels higher than `level` are inactive.
Otherwise, the current verbose level is returned.

### `verbose:newlevel ([level, ] group)`

Inserts the list of flags `group` in the verbose level `level` shifting all upper levels.
If no `level` is provided the group is added to the higher level available.
Therefore, when the verbose level is set to a level equal or greater than `level`, these flags will be active.

### `verbose:setgroup (name, group)`

Defines that the list of flags `group` compose the group of flags `name`.
Therefore, whenever the status of flag `name` is changed, all the flags of the group are changed to the same status.

### `verbose:setlevel (level, group)`

Defines that the list of flags `group` defines the set of flags added at level `group`.

Remarks
-------

- The following flags are reserved for the internal implementation of the `Verbose` class:
	- `custom`
	- `flag`
	- `flags`
	- `groups`
	- `pause`
	- `level`
	- `newlevel`
	- `setgroup`
	- `setlevel`
	- `timed`
	- `updatetabs`

Examples
--------

### Counter Log

```lua
local Verbose = require "loop.debug.Verbose"
local Viewer = require "loop.debug.Viewer"

LOG = Verbose{
  groups = {
    -- levels
    {"main"},
    {"counter"},
    -- aliases
    all = {"main", "counter"},
  },
  viewer = Viewer{
    maxdepth = 2,
    indentation = "|  ",
  }
}
LOG:flag("all", true)



local oo = require "loop.base"

local Counter = oo.class{
  value = 0,
  step = 1,
}
function Counter:add()                LOG:counter "Adding step to counter"
  self.value = self.value + self.step
end

counter = Counter()                   LOG:main "Counter object created"
steps = 10                            LOG:main(true, "Counting ",steps," steps")
for i=1, steps do counter:add() end   LOG:main(false, "Done! Counter=",counter)
```

- Output

```
[main]    Counter object created
[main]    Counting 10 steps
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[counter] |  Adding step to counter
[main]    Done! Counter={ table: 0x9c3e390
          |  value = 10,
          }
```
