# select

Selects module objects. 

**Since:** 3.2

## Parameters

- `i` : An index value, range, or list. Select all module objects if `i` is ignored.

## Examples

If you write code like this:
	
	i = 0;

	if(i == 0) {
		sphere(1);
	}
	else if(i == 1) {
		cube(1);
	}
	else if(i == 2) {
		cylinder(1, 1);
	}

You may use `select`:

	use <select.scad>

	i = 0;

	select(i) {
		sphere(1);
		cube(1);
		cylinder(1, 1);
	}
