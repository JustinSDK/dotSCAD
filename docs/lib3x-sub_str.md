# sub_str

Returns the part of the string from `begin` to `end`, or to the `end` of the string (`end` not included).

## Parameters

- `t` : The original string.
- `begin` : The beginning index, inclusive.
- `end` : The ending index, exclusive. If it's omitted, the substring begins with the character at the specified `begin` and extends to the end of the original string.

## Examples

    use <util/sub_str.scad>
    
	assert(sub_str("helloworld", 0, 5) == "hello");
	assert(sub_str("helloworld", 5) == "world"); 