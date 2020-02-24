use <util/rand.scad>;
use <hull_polyline3d.scad>;
use <experimental/ptf_ring.scad>;

size = [20, 100];
line_width = 1;
step = 1; 
twist = 180;
$fn = 8;

module tiled_line_mobius(size, twist, step, line_width = 1) {
    sizexy = is_num(size) ? [size, size] : size;
    s = is_undef(step) ? line_width * 2 : step;
 
    function rand_diagonal_line_pts(x, y, size) = 
        rand(0, 1) >= 0.5 ? [[x, y], [x + size, y + size]] : [[x + size, y], [x, y + size]];
        
    lines = concat(
        [
            for(x = [0:s:sizexy[0] - s]) 
                for(y = [0:s:sizexy[1] - s]) 
                    rand_diagonal_line_pts(x, y, s)
        ],
        [
            for(i = [0:step:size[1] - 1])
                [[0, i], [0, i + step]]
        ],
        [
            for(i = [0:step:size[1] - 1])
                [[size[0], i], [size[0], i + step]]
        ]
    );
            
    for(line = lines) {
        pts = [for(p = line) ptf_ring(size, p, size[0], twist = twist)];
        hull_polyline3d(pts, thickness = line_width);
    }
}

tiled_line_mobius(size, twist, step, line_width);
