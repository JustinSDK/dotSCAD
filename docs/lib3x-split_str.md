# split_str

Splits the given string around matches of the given delimiting character. 

## Parameters

- `t` : The source string.
- `delimiter` : The delimiting character.

## Examples
    
	use <util/split_str.scad>
	
	assert(split_str("hello,world", ",") == ["hello", "world"]);

