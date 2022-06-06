# mz_square_get

It's a helper for getting data from a square-maze cell.

**Since:** 2.5

## Parameters

- `cell` : A maze cell.
- `query` : Accepts `"x"`, `"y"` or `"t"`. `"x"` for the cell's x coordinate. `"y"` for the cell's y coordinate. `"t"` for the cell's `type`. The returned type will be `"NO_WALL"`, `"TOP_WALL"`, `"RIGHT_WALL"`, `"TOP_RIGHT_WALL"` or `"MASK"`.

## Examples
    
	use <maze/mz_square_cells.scad>
	use <maze/mz_square_get.scad>
	use <line2d.scad>

	rows = 10;
	columns = 10;
	cell_width = 5;
	wall_thickness = 2;

	cells = mz_square_cells(rows, columns);

	for(cell = cells) {
		x = mz_square_get(cell, "x");
		y = mz_square_get(cell, "y");
		type = mz_square_get(cell, "t");
		
		translate([x, y] * cell_width) {
			if(type == "TOP_WALL" || type == "TOP_RIGHT_WALL") {
				line2d([0, cell_width], [cell_width, cell_width], wall_thickness);
			}
			
			if(type == "RIGHT_WALL" || type == "TOP_RIGHT_WALL") {
				line2d([cell_width, cell_width], [cell_width, 0], wall_thickness);
			}	
		}
	}

	line2d([0, 0], [cell_width * columns, 0], wall_thickness);
	line2d([0, 0], [0, cell_width * rows], wall_thickness);

![mz_square_get](images/lib3x-mz_square_get-1.JPG)