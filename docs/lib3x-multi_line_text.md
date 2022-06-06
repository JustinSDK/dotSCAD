# multi_line_text

Creates multi-line text from a list of strings. Parameters are the same as the built-in `text` module except the first two parameters.

## Parameters

- `lines` : A list of strings.
- `line_spacing` : Spacing between two lines. 

## Examples
    
	use <multi_line_text.scad>

	multi_line_text(
		["Welcome", "to", "Taiwan"],
		line_spacing = 15,    
		valign = "center", 
		halign = "center"
	);

![multi_line_text](images/lib3x-multi_line_text-1.JPG)

