# parse_number

The dir changed since 2.0. 

Parses the string argument as an number. 

## Parameters

- `t` : A string containing the number representation to be parsed.

## Examples

    use <util/parse_number.scad>;
    
	echo(parse_number("10") + 1);    // ECHO: 11
	echo(parse_number("-1.1") + 1);  // ECHO: -0.1
