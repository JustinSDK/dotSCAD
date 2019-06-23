# split_str

Splits the given string around matches of the given delimiting character. 

## Parameters

- `t` : The source string.
- `delimiter` : The delimiting character.

## Examples
    
	include <util/sub_str.scad>;
	include <util/split_str.scad>;
	
	echo(split_str("hello,world", ","));  // ECHO: ["hello", "world"]

