use <polyline_join.scad>
use <voxel/vx_ascii.scad>

tx = "3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172";

pts = [for(p = px_spiral(1, floor(sqrt(len(tx))) + 1)) p * 8];
linear_extrude(2) 
    for(i = [0:len(tx) - 1]) {
        translate(pts[i]) 
        difference() {
            square(7, center = true);
            for(p = vx_ascii(tx[i], center = true)) {
                translate(p) square(.8);
            }
        } 
    }
    
linear_extrude(1) {
    for(i = [0:len(tx) - 1]) {
        translate(pts[i]) 
            square(7, center = true);
    }
	polyline_join([for(i = [0:len(tx) - 1]) pts[i]])
	    circle(1);
}

function _px_spiral_forward(pt, leng, dir, clockwise) = 
    let(
        DIRS = clockwise ? [
            [1, 0],
            [0, -1],
            [-1, 0],
            [0, 1]
        ]
        : [ 
            [1, 0],
            [0, 1],
            [-1, 0],
            [0, -1]
        ]
    )
    pt + DIRS[dir] * leng;

function _px_spiral_go_turn(from, leng, max_leng, clockwise, dir) = 
    let(
        range = [1:leng],
        pts = [for(i = range) _px_spiral_forward(from, i, dir % 4, clockwise)],
        ps = pts[len(pts) - 1],
        pts2 = [for(i = range) _px_spiral_forward(ps, i, (dir + 1) % 4, clockwise)],
        pd = pts2[len(pts2) - 1]
    )
    concat(pts, pts2, _px_spiral(pd, leng + 1, max_leng, clockwise, dir + 2));
    
function _px_spiral(from, leng, max_leng, clockwise, dir) = 
    leng > max_leng ? [] : _px_spiral_go_turn(from, leng, max_leng, clockwise, dir);
    
function px_spiral(init_leng, max_leng, clockwise = false) =
    let(org = [0, 0])
    [org, each _px_spiral(org, init_leng, max_leng, clockwise, 0)];
