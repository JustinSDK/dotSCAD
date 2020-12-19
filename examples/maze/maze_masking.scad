use <maze/mz_square_blocks.scad>;
use <maze/mz_square_walls.scad>;
use <maze/mz_square_initialize.scad>;
use <voxel/vx_contour.scad>;

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

block_width = 3;
wall_thickness = 1;
wall_height = 2;
base_height = 1;
contour = true;
base = true;

module maze_masking(start, mask, block_width, wall_thickness, wall_height, base_height, contour, base) {
    rows = len(mask); 
    columns = len(mask[0]);

    blocks = mz_square_blocks(
        rows, columns, start,
		mz_square_initialize(mask = mask)
    );

	pts = contour ? vx_contour([
	for(y = [0:rows - 1])
	    for(x = [0:columns - 1])
		    if(mask[rows - y - 1][x] == 1)
			    [x, y]
	], sorted = true) : [];	
	
    walls = mz_square_walls(blocks, rows, columns, block_width);
	
	color("gray")
	linear_extrude(wall_height)
	intersection() {
	    union() {
			for(wall = walls) {
				for(i = [0:len(wall) - 2]) {
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
			for(y = [0:rows - 1]) {
				for(x = [0:columns - 1]) {
					if(mask[rows - y - 1][x] == 0) {
						translate([x * block_width + wall_thickness, y * block_width + wall_thickness])
						    square(block_width);
					}
			    }
			}
		}

        if(contour) {
	        translate([wall_thickness * 2, wall_thickness * 2])
	            polygon(pts * block_width);	
		}
	}
	
	if(base) {
	    if(contour) {
			translate([0, 0, -base_height])
			linear_extrude(base_height)
			translate([wall_thickness * 2, wall_thickness * 2])
			   polygon(pts * block_width);	
	    }
		else {
		    translate([0, 0, -base_height])
		    linear_extrude(base_height)
			translate([wall_thickness, wall_thickness])
			square([columns, rows] * block_width);
		}
	}
}

maze_masking(start, mask, block_width, wall_thickness, wall_height, base_height, contour, base);