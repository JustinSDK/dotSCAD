use <experimental/tile_truchet.scad>
use <polyline_join.scad>
use <ptf/ptf_torus.scad>

size = [20, 50];
line_diameter = 1;
twist = 180;
$fn = 4;

module tiled_line_torus(size, twist, line_diameter = 1) {
    lines = [
            for(tile = tile_truchet(size)) 
            let(
			    x = tile.x,
				y = tile.y
			)
            tile[2] <= 1 ? [[x, y], [x + 1, y + 1]] : [[x + 1, y], [x, y + 1]]  
        ];
            
	half_line_diameter = line_diameter / 2;
    for(line = lines) {
        pts = [for(p = line) ptf_torus(size, p, [size[0], size[0] / 2], twist = twist)];
        polyline_join(pts)
		    sphere(half_line_diameter);
    }
}

tiled_line_torus(size, twist, line_diameter);
color("black")
rotate_extrude($fn = 36)
translate([size[0] * 1.5, 0, 0])
    circle(size[0] / 2);