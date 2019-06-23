# parse_number

Parses the string argument as an number. 

## Parameters

- `t` : A string containing the number representation to be parsed.

## Examples

	include <util/sub_str.scad>;
	include <util/split_str.scad>;
    include <util/parse_number.scad>;
    
	echo(parse_number("10") + 1);    // ECHO: 11
	echo(parse_number("-1.1") + 1);  // ECHO: -0.1
