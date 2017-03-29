# parse_number

Parses the string argument as an number. It depends on the `split_str` and the `sub_str` functions so remember to include split_str.scad and sub_str.scad.

## Parameters

- `t` : A String containing the number representation to be parsed.

## Examples

	echo(parse_number("10") + 1);    // ECHO: 11
	echo(parse_number("-1.1") + 1);  // ECHO: -0.1
