Index
=====

- [`Matcher`](#matcher)
	- [`matcher.boolean`](#matcherboolean)
	- [`matcher.environment`](#matcherenvironment)
	- [`matcher.envkey`](#matcherenvkey)
	- [`matcher:error`](#matchererror-reason)
	- [`matcher.function`](#matcherfunction)
	- [`matcher.isomorphic`](#matcherisomorphic)
	- [`matcher:match`](#matchermatch-value-other)
	- [`matcher:matchfunction`](#matchermatchfunction-value-other)
	- [`matcher:matchtable`](#matchermatchtable-value-other)
	- [`matcher.metakey`](#matchermetakey)
	- [`matcher.metatable`](#matchermetatable)
	- [`matcher.number`](#matchernumber)
	- [`matcher.string`](#matcherstring)
	- [`matcher.table`](#matchertable)
	- [`matcher.thread`](#matcherthread)
	- [`matcher.upvalue`](#matcherupvalue)
	- [`matcher.userdata`](#matcheruserdata)
- [`Remarks`](#remarks)
- [`Examples`](#examples)

Contents
========

Matcher
-------

Class of objects used to compare pairs of values according to some criteria of similarity.
By default, it matches pairs of same values or structurally isomorphic tables (including their meta-tables).
Functions with same bytecodes, upvalue contents and isomorphic environments also match.
However, such matching criteria may be redefined.
This class is useful for implementing automated test mechanisms for Lua applications.

Each object provides a set of methods for comparison of values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
When a pair of distinct values are matched their correspondence is stored in the object instance.
Therefore, such correspondence is maintained in all further comparisons made by the same instance.

### `matcher.boolean`

Field that defines the method implementation used to compare two different boolean values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then boolean values are compared for equality only.
The default value for this field is `nil`.

### `matcher.envkey`

Special value used to identify a function environment retrieval.
See method [`matcher:error`](#matchererror-reason) for further information.

### `matcher.environment`

Field that defines the function used to retrieve the environment of a function.
If this field evaluates to `false` then function environments are ignored during matching.
The default value for this field is function [`os.getfenv`](http://www.lua.org/manual/5.3/manual.html#pdf-os.getenv) of the Lua library.

### `matcher.isomorphic`

If this field evaluates to `true` then table matching should be isomorphic, _i.e._ there is a one to one relation of each field of the first table to the second.
However, if its value evaluates to `false` then table matching just guarantee that all fields of the first table have a matching field in the second.
The default value for this field is `true`.

### `matcher.metakey`

Special value used to identify a meta-table retrieval.
See method [`matcher:error`](#matchererror-reason) for further information.

### `matcher.metatable`

Field that defines the method implementation used to compare meta-tables of matching values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then meta-tables are ignored during matching.
The default value for this field is method [`matcher:match`](#matchermatch-value-other) provided by the class.

### `matcher.function`

Field that defines the method implementation used to compare two different function values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then function values are compared for equality only.
The default value for this field is method `matchfunction` provided by the class.

### `matcher.number`

Field that defines the method implementation used to compare two different number values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then number values are compared for equality only.
The default value for this field is `nil`.

### `matcher.string`

Field that defines the method implementation used to compare two different string values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then string values are compared for equality only.
The default value for this field is `nil`.

### `matcher.table`

Field that defines the method implementation used to compare two different table values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then table values are compared for equality only.
The default value for this field is method [`matcher:matchtable`](#matchermatchtable-value-other) provided by the class.

### `matcher.thread`

Field that defines the method implementation used to compare two different thread values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then thread values are compared for equality only.
The default value for this field is `nil`.

### `matcher.upvalue`

Field that defines the function used to retrieve the contents of function upvalues.
If this field evaluates to `false` then upvalues contents are ignored during matching.
The default value for this field is function `debug.getupvalue` of the Lua debug library if it is loaded at the moment this class is required.

### `matcher.userdata`

Field that defines the method implementation used to compare two different userdata values passed as parameters.
The function must return `true` if the values match or `false` otherwise.
If this field evaluates to `false` then userdata values are compared for equality only.
The default value for this field is `nil`.

### `matcher:error (reason)`

Method that creates a matching error message.
The parameter `reason` is a string with a message describing the error reason.
Whenever this method is called, the object instance stores as an array (_i.e._ using integer keys) the sequence of values that identifies the path to the mismatched field.
However, indexes 0 and 1 are used to store the values being compared, that are respectively the values of parameters `other` and `value` that are passed to method [`matcher:match`](#matchermatch-value-other).
Fields [`matcher.metakey`](#matchermetakey) and [`matcher.envkey`](#matcherenvkey) hold special values that are used to identify a meta-table or function environment retrival, respectively.

### `matcher:match (value, other)`

Method that tries to match values `value` and `other`.
If they match then it returns `true`.
Otherwise, it return `false` and an error message.
The error message format is created by method [`matcher:error`](#matchererror-reason).
The default format is `<path> : <reason>`, where `<path>` is a string identifying which part doesn't match.
Upvalues are represented as table fields, for example if `value` is a table which field `func` is a function which upvalue `up` differ then the path informed will be `value.func.up`.
The `<reason>` is one of the following messages:

Message                   | Description                                       
------------------------- | --------------------------------------------------
`"no match found"`        | no similar field key found                        
`"missing"`               | missing field found in `other` table              
`"bytecodes not matched"` | bytecodes of two different function differ        
`"wrong match"`           | other value (_e.g._ previously bound) was expected
`"not matched"`           | different objects found                           

### `matcher:matchfunction (value, other)`

Method that compares two different functions informed as parameters `value` and `other` according to their bytecodes and the criteria defined by fields [`matcher.environment`](#matcherenvironment), [`matcher.upvalue`](#matcherupvalue), and [`matcher.metatable`](#matchermetatable).
If the two values matches, then it returns `true`, otherwise it returns `false` and an error message.

### `matcher:matchtable (value, other)`

Method that compares two different tables informed as parameters `value` and `other` according to their contents and the criteria defined by field `metatable`.
If the two values matches, then it returns `true`, otherwise it returns `false` and an error message.

Remarks
-------

- Each object instance keeps a mapping of the matched objects, therefore to restart comparisons without previous mapping you should create another object instance.
- Since it is only possible to check upvalue contents, matched functions are not guaranteed to produce the same effects since the upvalue variables may be actually different even though they store the same value.
- Since [`string.dump`](http://www.lua.org/manual/5.3/manual.html#pdf-string.dump) produces an error instead of returning an error message silently, values with unmatched C functions raises the error produced by [`string.dump`](http://www.lua.org/manual/5.3/manual.html#pdf-string.dump).
To handle such situation, you should use a [`pcall`](http://www.lua.org/manual/5.3/manual.html#pdf-pcall).
But be warned that this function is somewhat restricted since it can't be used with yielding co-routines.
- Methods used to compare two different values (_i.e._ fields `boolean`, `number`, `string`, `function`, `thread` and `userdata`) may store in the object instance a mapping of each machted pairs so that `self[value] == other and self[other] == value` in order to avoid further evaluation of the same pair and that they are matched to other values.
However, for positive integer numbers this should be avoided because these values are used to store the sequence of values that identifies the current path of the values being compared.
- Non-isomorphic comparisions of tables that have other tables as key values does not work well due to ambiguities when trying to find the corresponding match for each key-value pair.

Examples
--------

### Parser Test Suite

```lua
local Viewer  = require "loop.debug.Viewer"
local Matcher = require "loop.debug.Matcher"

local message = "Testcase %d failed: %s\n"

function compare(file, cases)
  local previous = io.open(file)
  if previous then
    previous:close()
    previous = dofile(file)
  else
    previous = {}
  end
  
  local results = {}
  for index, source in ipairs(cases) do
    local expected = previous[index]
    local actual = parser:evaluate(source)
    if expected then
      local matcher = Matcher{ metatable = false }
      local success, errmsg = matcher:match(expected, actual)
      if not success then
        io.stderr:write(message:format(index, errmsg))
      end
    else
      expected = actual
    end
    results[index] = expected
  end
  
  local serializer = Viewer{
    output = assert(io.open(file, "w")),
    maxdepth = -1,
  }
  serializer.output:write("return ")
  serializer:write(results)
end
```
