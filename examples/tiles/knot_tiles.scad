use <experimental/tile_truchet.scad>;
use <arc.scad>;
use <line2d.scad>;
use <experimental/select.scad>;

size = [50, 25];
tile_width = 5;
line_width = 1;

$fn = 12; // 4, 8, 12 ....

for(tile = tile_truchet(size)) {
    x = tile[0];
	y = tile[1];
	i = tile[2];

    translate([x, y] * tile_width)
	select(i) {
		tile00(x, y, tile_width, line_width);
		tile01(x, y, tile_width, line_width);
		tile02(x, y, tile_width, line_width);
		tile03(x, y, tile_width, line_width);
	};
}

module tile00(x, y, tile_width, line_width) {
	arc(0.5 * tile_width, [0, 90], line_width);
	translate([tile_width, tile_width])
		arc(0.5 * tile_width, [180, 270], line_width);
}

module tile01(x, y, tile_width, line_width) {
	translate([0, tile_width])
		arc(0.5 * tile_width, [270, 360], line_width);
	translate([tile_width, 0])
		arc(0.5 * tile_width, [90, 180], line_width);
}

module tile02(x, y, tile_width, line_width) {
	half_width = tile_width * 0.5; 
	line2d([half_width, 0], [half_width, tile_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([0, half_width], [half_width - line_width, half_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([half_width + line_width, half_width], [tile_width, half_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
}

module tile03(x, y, tile_width, line_width) {
	half_width = tile_width * 0.5; 
	line2d([0, half_width], [tile_width, half_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([half_width, 0], [half_width, half_width - line_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
	line2d([half_width, tile_width], [half_width, half_width + line_width], line_width, p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
}