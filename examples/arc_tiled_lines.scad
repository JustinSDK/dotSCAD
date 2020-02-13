use <util/rand.scad>;
use <hull_polyline2d.scad>;
use <arc.scad>;
use <experimental/tf_ring.scad>;

module arc_tiled_lines(size, angle, step, line_width = 1) {
    sizexy = is_num(size) ? [size, size] : size;
    s = is_undef(step) ? line_width * 2 : step;
 
    function rand_diagonal_line_pts(x, y, size) = 
        rand(0, 1) >= 0.5 ? [[x, y], [x + size, y + size]] : [[x + size, y], [x, y + size]];
        
    lines = [
        for(x = [0:s:sizexy[0] - s]) 
            for(y = [0:s:sizexy[1] - s]) 
                rand_diagonal_line_pts(x, y, s)
    ];
    
    for(line = lines) {
        pts = [for(p = line) tf_ring(size, p, size[0], angle)];
        hull_polyline2d(pts, width = line_width);
    }
    
    arc_width = line_width * 2;
    arc(radius = size[0], angle = angle, width = arc_width, $fn = 36);
    arc(radius = size[0] * 2, angle = angle, width = arc_width, $fn = 36);
    
    if(angle != 360) {
        hull_polyline2d([[size[0], 0], [size[0] * 2, 0]], width = arc_width);
        rotate(angle) 
            hull_polyline2d([[size[0], 0], [size[0] * 2, 0]], width = arc_width);        
    }
}

size = [20, 100];
line_width = .5;
step = 1; 
angle = 360;

arc_tiled_lines(size, angle, step, line_width);
