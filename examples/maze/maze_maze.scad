use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>
use <maze/mz_square_initialize.scad>
use <voxel/vx_contour.scad>

start = [1, 1];
mask = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0],
	[0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0],
	[0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0],
	[0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
];

cell_width = 3;
wall_thickness = 1;
wall_height = 2;
base_height = 1;

module maze_maze(start, mask, cell_width, wall_thickness, wall_height) {
    rows = len(mask); 
    columns = len(mask[0]);

    cells = mz_square(
        rows, columns, start,
		mz_square_initialize(mask = mask)
    );

	pts = vx_contour([for(y = [0:rows - 1], x = [0:columns - 1]) if(mask[rows - y - 1][x] == 1) [x, y]]);	
    walls = mz_squarewalls(cells, cell_width);
	
	intersection() {
		linear_extrude(len(mask) * cell_width)
		difference() {
			union()
			for(y = [0:rows - 1], x = [0:columns - 1]) {
				if(mask[rows - y - 1][x] == 1) {
					translate([x * cell_width + wall_thickness, y * cell_width + wall_thickness])
						square(cell_width);
				}
			}

			union()
			for(wall = walls, i = [0:len(wall) - 2]) {
				if(wall[i][0] != 0 && wall[i][1] != 0) {
					hull() {
						translate(wall[i]) 
							square(wall_thickness);
						translate(wall[i + 1]) 
							square(wall_thickness);
					}
				}
			} 
		}

		translate([0, len(mask) * cell_width])
		rotate([90, 0, 0])
		linear_extrude(len(mask) * cell_width)
		translate([0, -1])
		offset(.1)
		union() {
			for(y = [0:rows - 1], x = [0:columns - 1]) {
				if(mask[rows - y - 1][x] == 1) {
					translate([x * cell_width + wall_thickness, y * cell_width + wall_thickness])
						square(cell_width);
				}
			}
		}
	}
		
}

maze_maze(start, mask, cell_width, wall_thickness, wall_height);