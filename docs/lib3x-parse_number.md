# parse_number

Parses the string argument as an number. 

## Parameters

- `t` : A string containing the number representation to be parsed.

## Examples

    use <util/parse_number.scad>
    
	assert((parse_number("10") + 1) == 11);
	assert((parse_number("-1.1") + 1) == -0.1);
