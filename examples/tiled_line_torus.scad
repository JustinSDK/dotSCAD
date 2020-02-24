use <util/rand.scad>;
use <hull_polyline3d.scad>;
use <experimental/ptf_torus.scad>;

size = [20, 50];
line_width = 1;
step = 1; 
twist = 180;
$fn = 4;

module tiled_line_torus(size, twist, step, line_width = 1) {
    sizexy = is_num(size) ? [size, size] : size;
    s = is_undef(step) ? line_width * 2 : step;
 
    function rand_diagonal_line_pts(x, y, size) = 
        rand(0, 1) >= 0.5 ? [[x, y], [x + size, y + size]] : [[x + size, y], [x, y + size]];
        
    lines = concat(
        [
            for(x = [0:s:sizexy[0] - s]) 
                for(y = [0:s:sizexy[1] - s]) 
                    rand_diagonal_line_pts(x, y, s)
        ]
    );
            
    for(line = lines) {
        pts = [for(p = line) ptf_torus(size, p, [size[0], size[0] / 2], twist = twist)];
        hull_polyline3d(pts, thickness = line_width);
    }
}

tiled_line_torus(size, twist, step, line_width);
color("black")
rotate_extrude($fn = 36)
translate([size[0] * 1.5, 0, 0])
    circle(size[0] / 2);
