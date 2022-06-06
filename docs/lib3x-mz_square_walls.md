# mz_square_walls

It's a helper for creating wall data from maze cells. You can transform wall points for creating different types of mazes.

**Since:** 2.5

## Parameters

- `cells` : Maze cells.
- `rows` : The rows of the maze.
- `columns` : The columns of the maze.
- `cell_width` : The width of a cell.
- `left_border` : Default to `true`. Create the leftmost border of the maze.
- `bottom_border` : Default to `true`. Create the bottommost border of the maze.

## Examples
    
	use <maze/mz_square_cells.scad>
	use <maze/mz_square_walls.scad>
	use <polyline2d.scad>

	rows = 10;
	columns = 10;
	cell_width = 5;
	wall_thickness = 2;

	cells = mz_square_cells(rows, columns);
	walls = mz_square_walls(cells, rows, columns, cell_width);

	for(wall = walls) {
		polyline2d(wall, wall_thickness, joinStyle = "JOIN_MITER");
	}
	
![mz_square_walls](images/lib3x-mz_square_walls-1.JPG)