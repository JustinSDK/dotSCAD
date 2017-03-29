# sub_str

Returns a new string that is a substring of the given string.

## Parameters

- `t` : The original string.
- `begin` : The beginning index, inclusive.
- `end` : The ending index, exclusive. If it's omitted, the substring begins with the character at the specified `begin` and extends to the end of the original string.

## Examples

	echo(sub_str("helloworld", 0, 5)); // ECHO: "hello"
	echo(sub_str("helloworld", 5));    // ECHO: "world"
