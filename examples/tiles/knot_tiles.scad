use <experimental/tile_truchet.scad>
use <arc.scad>
use <line2d.scad>
use <select.scad>

size = [50, 25];
tile_width = 5;
line_width = 1;

$fn = 12; // 4, 8, 12 ....

for(tile = tile_truchet(size)) {
    translate([tile.x, tile.y] * tile_width)
	select(tile[2]) {
		tile00(tile_width, line_width);
		tile01(tile_width, line_width);
		tile02(tile_width, line_width);
		tile03(tile_width, line_width);
	};
}

module tile00(tile_width, line_width) {
	arc(0.5 * tile_width, [0, 90], line_width);
	translate([tile_width, tile_width])
		arc(0.5 * tile_width, [180, 270], line_width);
}

module tile01(tile_width, line_width) {
	translate([0, tile_width])
		arc(0.5 * tile_width, [270, 360], line_width);
	translate([tile_width, 0])
		arc(0.5 * tile_width, [90, 180], line_width);
}

module tile02(tile_width, line_width) {
	half_width = tile_width * 0.5; 
	line2d([half_width, 0], [half_width, tile_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([0, half_width], [half_width - line_width, half_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([half_width + line_width, half_width], [tile_width, half_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
}

module tile03(tile_width, line_width) {
	half_width = tile_width * 0.5; 
	line2d([0, half_width], [tile_width, half_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([half_width, 0], [half_width, half_width - line_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([half_width, tile_width], [half_width, half_width + line_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
}