# slice

Returns a list selected from `begin` to `end`, or to the `end` of the list (`end` not included).

**Since:** 2.0

## Parameters

- `lt` : The original list.
- `begin` : The beginning index, inclusive. 
- `end` : The ending index, exclusive. If it's omitted, the list begins with the character at the specified `begin` and extends to the end of the original list.

## Examples

    use <util/slice.scad>
    
	assert(slice([for(c = "helloworld") c], 0, 5) == ["h", "e", "l", "l", "o"]);
	assert(slice([for(c = "helloworld") c], 5) == ["w", "o", "r", "l", "d"]);
