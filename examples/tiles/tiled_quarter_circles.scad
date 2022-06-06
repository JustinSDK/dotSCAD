use <experimental/tile_truchet.scad>
use <arc.scad>

size = [50, 25];
tile_width = 5;
line_width = 1;

$fn = 4; // 4, 8, 12 ....

for(tile = tile_truchet(size)) {
    x = tile.x;
	y = tile.y;
	if(tile[2] <= 1) {
	    translate([x, y] * tile_width)
	        arc(0.5 * tile_width, [0, 90], line_width);
	    translate([x + 1, y + 1] * tile_width)
	        arc(0.5 * tile_width, [180, 270], line_width);
	}
	else {
	    translate([x, y + 1] * tile_width)
		    arc(0.5 * tile_width, [270, 360], line_width);
		translate([x + 1, y] * tile_width)
			arc(0.5 * tile_width, [90, 180], line_width);
	}
}