# mz_squarewalls

It's a helper for creating wall data from maze cells. You can transform wall points for creating different types of mazes.

**Since:** 3.3

## Parameters

- `cells` : Maze cells.
- `cell_width` : The width of a cell.
- `left_border` : Default to `true`. Create the leftmost border of the maze.
- `bottom_border` : Default to `true`. Create the bottommost border of the maze.

## Examples
    
	use <maze/mz_square.scad>
	use <maze/mz_squarewalls.scad>
	use <polyline2d.scad>

	rows = 10;
	columns = 10;
	cell_width = 5;
	wall_thickness = 2;

	cells = mz_square(rows, columns);
	walls = mz_squarewalls(cells, cell_width);

	for(wall = walls) {
		polyline2d(wall, wall_thickness, joinStyle = "JOIN_MITER");
	}
	
![mz_squarewalls](images/lib3x-mz_squarewalls-1.JPG)