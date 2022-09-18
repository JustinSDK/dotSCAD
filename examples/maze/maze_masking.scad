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
contour = true;
base = true;

module maze_masking(start, mask, cell_width, wall_thickness, wall_height, base_height, contour, base) {
    rows = len(mask); 
    columns = len(mask[0]);

    cells = mz_square(
        rows, columns, start,
		mz_square_initialize(mask = mask)
    );

	pts = contour ? 
		vx_contour([
			for(y = [0:rows - 1], x = [0:columns - 1]) if(mask[rows - y - 1][x] == 1) [x, y]
		]) : 
		[];	
	
    walls = mz_squarewalls(cells, cell_width);
	
	color("gray")
	linear_extrude(wall_height)
	intersection() {
	    union() {
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
			for(y = [0:rows - 1], x = [0:columns - 1]) {
				if(mask[rows - y - 1][x] == 0) {
					translate([x * cell_width + wall_thickness, y * cell_width + wall_thickness])
						square(cell_width);
				}
			}
		}

        if(contour) {
	        translate([wall_thickness * 2, wall_thickness * 2])
	            polygon(pts * cell_width);	
		}
	}
	
	if(base) {
	    if(contour) {
			translate([0, 0, -base_height])
			linear_extrude(base_height)
			translate([wall_thickness * 2, wall_thickness * 2])
			    polygon(pts * cell_width);	
	    }
		else {
		    translate([0, 0, -base_height])
		    linear_extrude(base_height)
			translate([wall_thickness, wall_thickness])
			    square([columns, rows] * cell_width);
		}
	}
}

maze_masking(start, mask, cell_width, wall_thickness, wall_height, base_height, contour, base);