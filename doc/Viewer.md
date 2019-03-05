Index
=====

- [`Viewer`](#viewer)
	- [`viewer:boolean`](#viewerbooleanvalue-output-history-prefix-maxdepth)
	- [`viewer:function`](#viewerfunctionvalue-output-history-prefix-maxdepth)
	- [`viewer.history`](#viewerhistory)
	- [`viewer.indentation`](#viewerindentation)
	- [`viewer:label`](#viewerlabelvalue)
	- [`viewer.labels`](#viewerlabels)
	- [`viewer.linebreak`](#viewerlinebreak)
	- [`viewer.maxdepth`](#viewermaxdepth)
	- [`viewer.metalabels`](#viewermetalabels)
	- [`viewer.metaonly`](#viewermetaonly)
	- [`viewer:nil`](#viewernilvalue-output-history-prefix-maxdepth)
	- [`viewer.noaltquotes`](#viewernoaltquotes)
	- [`viewer.noarrays`](#viewernoarrays)
	- [`viewer.nofields`](#viewernofields)
	- [`viewer.noindices`](#viewernoindices)
	- [`viewer.nolabels`](#viewernolabels)
	- [`viewer.nolongbrackets`](#viewernolongbrackets)
	- [`viewer:number`](#viewernumbervalue-output-history-prefix-maxdepth)
	- [`viewer.output`](#vieweroutput)
	- [`viewer:packnames`](#viewerpacknamespackages)
	- [`viewer.prefix`](#viewerprefix)
	- [`viewer.singlequotes`](#viewersinglequotes)
	- [`viewer:string`](#viewerstringvalue-output-history-prefix-maxdepth)
	- [`viewer:table`](#viewertablevalue-output-history-prefix-maxdepth)
	- [`viewer:thread`](#viewerthreadvalue-output-history-prefix-maxdepth)
	- [`viewer:tostring`](#viewertostring)
	- [`viewer:userdata`](#vieweruserdatavalue-output-history-prefix-maxdepth)
	- [`viewer:write`](#viewerwrite)
	- [`viewer:writeto`](#viewerwritetooutput-)
	- [`viewer:writevalue`](#viewerwritevaluevalue-output-history-prefix-maxdepth)
- [`Remarks`](#remarks)
- [`Examples`](#examples)
	- [Global Variables](#global-variables)

Contents
========

Viewer
------

Class of objects that generate human-readable textual representation of Lua values.
This class is typically used to print out value of variables, data structures or objects in a Lua application using a syntax similar to the Lua language.
It is useful for implementation of command line debug mechanisms.
This class can also be used as a simple serialization mechanism for a restricted set of Lua values.

Basically, each object provides an operation to print values and holds some information that defines how values should be displayed like the output used.

### `viewer.metalabels`

Boolean that indicates whether metamethod `__tostring` shall be used to [generate labels](#viewerlabelvalue) for values.

### `viewer.metaonly`

Boolean that indicates whether metamethod `__tostring` shall be used as output for values instead of the default visualization.

### `viewer.nolabels`

Boolean that indicates whether value specific labels shall not be used in the output.
If this field evaluates to `true` then generic type names are used as labels.

### `viewer.noaltquotes`

Boolean that indicates whether the same string quote character must be used for string output.

### `viewer.singlequotes`

Boolean that indicates whether the single quote (`'`) must be used preferably.

### `viewer.nolongbrackets`

Boolean that indicates whether long brackes format (`[[ ]]`) shall not be used for string output.

### `viewer.noarrays`

Boolean that indicates whether values stored in tables using integer keys shall not be visualized before other values as an array part of the table.

### `viewer.noindices`

Boolean that indicates whether values stored in tables using integer keys shall not be visualized with numerical indices.

### `viewer.nofields`

Boolean that indicates whether values stored in tables using keys that are valid identifiers shall not be visualized as fields.

### `viewer.indentation`

String used as indentation level when writing nested tables.
To write tables without indentation or in a single line use the empty string.
The default value is `"  "`.

### `viewer.linebreak`

String used to add line breaks when writing tables.
To write tables in a single line use a string with a single space (`" "`).
The default value of this field is the string `"\n"`.

### `viewer.maxdepth`

Maximum number of levels of nested tables that should be visualized.
When this value is negative all levels of nested tables are visualized.
The default value of this field is `-1`.

### `viewer.prefix`

String written at the start of each new line of the visualization.
The default value of this field is an empty string.

### `viewer.output`

Object used to write visualization of values.
The object must provide the operation `output:write(...)` that receives strings to be written.
The default value of this field is the standard output file ([`io.stdout`](http://www.lua.org/manual/5.3/manual.html#pdf-io.stdout)).

### `viewer.history`

Table mapping values already processed to the label used to output the value.
Set this field to the same table to make `viewer` remember values in previous generated outputs.
By default this field is `nil`, which makes `viewer` always regenerate the output of all values.

### `viewer.labels`

Table mapping values to a string to be used instead of outputting the value.
The default value of this field is a table naming all packages loaded at the moment this class is first required.

### `viewer:label (value)`

Used to generate a label for a given value not already labeled in field `labels`.
By default this method generates labels using the `tostring` method of Lua base library.
If the value defines the `__tostring` meta-method then the original string representation is shown between parenthesis.
This method can be redefined to define other labeling policy.

### `viewer:packnames ([packages])`

Creates a new `viewer.labels` table with all the members of packages loaded in [`package.loaded`](http://www.lua.org/manual/5.3/manual.html#pdf-package.loaded).
If argument `packages` is provides it is used instead of `package.loaded`.

### `viewer:tostring (...)`

Returns a string with the textual representation of all the values passed as arguments separated by commas.

### `viewer:write (...)`

Writes the textual representation of all arguments to field `output` separated by commas.

### `viewer:writeto (output, ...)`

Writes to object `output` the textual representation of all other arguments separated by commas.
The object `output` must provide the operation `write` just like [`viewer.output`](#vieweroutput).

### `viewer:writevalue (value, output, history, prefix, maxdepth)`

Writes to object `output` the textual representation of `value` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).

### `viewer:nil (value, output, history, prefix, maxdepth)`

Used to write the nil value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method outputs `nil`.

### `viewer:boolean (value, output, history, prefix, maxdepth)`

Used to write the boolean value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method outputs either `true` or `false`.

### `viewer:number (value, output, history, prefix, maxdepth)`

Used to write the number value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method outputs the number using [`tonumber`](http://www.lua.org/manual/5.3/manual.html#pdf-tonumber).

### `viewer:string (value, output, history, prefix, maxdepth)`

Used to write the string value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method outputs the string using the current configuration.

### `viewer:table (value, output, history, prefix, maxdepth)`

Used to write the table value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method outputs the string using the current configuration.

### `viewer:function (value, output, history, prefix, maxdepth)`

Used to write the function value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method is `nil`.

### `viewer:thread (value, output, history, prefix, maxdepth)`

Used to write the thread value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method is `nil`.

### `viewer:userdata (value, output, history, prefix, maxdepth)`

Used to write the userdata value `value` to object `output` using table `history` as [`viewer.history`](#viewerhistory), `prefix` as [`viewer.prefix`](#viewerprefix), and `maxdepth` as [`viewer.maxdepth`](#viewermaxdepth).
By default this method is `nil`.

Remarks
-------

- This class can be used as an instance of itself, therefore all methods can be executed over the class itself.

Examples
--------

### Global Variables

```lua
local Viewer = require "loop.debug.Viewer"

viewer = Viewer{
  maxdepth = 3,
  indentation = "|  "
}

viewer:write(_G)
```
