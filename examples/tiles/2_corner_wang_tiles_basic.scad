use <experimental/tile_w2c.scad>
use <arc.scad>

size = [15, 10];
tile_width = 10;
tile_thickness = 2;
$fn = 24;

translate([tile_width, tile_width] / 2)
	for(tile = tile_w2c(size)) {
		x = tile[0];
		y = tile[1];
		i = tile[2];
		translate([x, y] * tile_width)
			sample_tile(i, tile_width, tile_thickness);
	}

module sample_tile(n, width, thickness) {
    half_w = width / 2;
	
	diff_polygons = [
	    [[]],
		[[[0, 0], [half_w, 0], [half_w, half_w], [0, half_w]]],
		[[[0, 0], [0, -half_w], [half_w, -half_w], [half_w, 0]]],
		[[[0, -half_w], [half_w, -half_w], [half_w, half_w], [0, half_w]]],
        [[[0, 0], [-half_w, 0], [-half_w, -half_w], [0, -half_w]]],
		[
		    [[0, 0], [half_w, 0], [half_w, half_w], [0, half_w]],
		    [[0, 0], [-half_w, 0], [-half_w, -half_w], [0, -half_w]]
		],
		[[[-half_w, 0], [-half_w, -half_w], [half_w, -half_w], [half_w, 0]]],
		[
			[[0, 0], [half_w, 0], [half_w, half_w], [0, half_w]],
			[[-half_w, 0], [-half_w, -half_w], [half_w, -half_w], [half_w, 0]]
		],
		[[[0, 0], [0, half_w], [-half_w, half_w], [-half_w, 0]]],
		[[[half_w, 0], [half_w, half_w], [-half_w, half_w], [-half_w, 0]]],
		[
		    [[0, 0], [0, -half_w], [half_w, -half_w], [half_w, 0]],
			[[0, 0], [0, half_w], [-half_w, half_w], [-half_w, 0]]
		],
		[
			[[half_w, 0], [half_w, half_w], [-half_w, half_w], [-half_w, 0]],
			[[0, 0], [0, -half_w], [half_w, -half_w], [half_w, 0]]
		],
		[[[0, half_w], [-half_w, half_w], [-half_w, -half_w], [0, -half_w]]],
		[
			[[0, half_w], [-half_w, half_w], [-half_w, -half_w], [0, -half_w]],
			[[0, 0], [half_w, 0], [half_w, half_w], [0, half_w]]
		],
		[
			[[-half_w, 0], [-half_w, -half_w], [half_w, -half_w], [half_w, 0]],
			[[0, 0], [0, half_w], [-half_w, half_w], [-half_w, 0]]
		],
		[[[half_w, half_w], [-half_w, half_w], [-half_w, -half_w], [half_w, -half_w]]]
	];

    color("blue")
    linear_extrude(thickness) 
	difference() {
        square(width, center = true);
		for(diff_polygon = diff_polygons[n]) {
		    offset(0.01) polygon(diff_polygon);
		}
	}
	
	color("yellow")
	linear_extrude(thickness / 2)
	    square(width, center = true);
}