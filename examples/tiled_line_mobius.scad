use <experimental/tile_truchet.scad>;
use <hull_polyline3d.scad>;
use <ptf/ptf_ring.scad>;

size = [20, 100];
line_diameter = 1;
twist = 180;
$fn = 8;

module tiled_line_mobius(size, twist, line_diameter = 1) {
    lines = concat(
        [
            for(tile = tile_truchet(size)) 
            let(
			    x = tile[0],
				y = tile[1],
				i = tile[2]
			)
            i <= 1 ? [[x, y], [x + 1, y + 1]] : [[x + 1, y], [x, y + 1]]  
        ],
        [
            for(i = [0:size[1] - 1])
                [[0, i], [0, i + 1]]
        ],
        [
            for(i = [0:size[1] - 1])
                [[size[0], i], [size[0], i + 1]]
        ]
    );
            
    for(line = lines) {
        pts = [for(p = line) ptf_ring(size, p, size[0], twist = twist)];
        hull_polyline3d(pts, diameter = line_diameter);
    }
}

tiled_line_mobius(size, twist, line_diameter);