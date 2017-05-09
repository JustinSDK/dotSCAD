include <__private__/__frags.scad>;
include <__private__/__triangles_tape.scad>;

function _unit_xy(a) = [cos(a), sin(a)];
    
function _edge_r_begin(orig_r, a, a_step, m) =
    let(leng = orig_r * cos(a_step / 2))
    leng / cos((m - 0.5) * a_step - a);

function _edge_r_end(orig_r, a, a_step, n) =      
    let(leng = orig_r * cos(a_step / 2))    
    leng / cos((n + 0.5) * a_step - a);

function shape_arc(radius, angles, width, width_mode = "LINE_CROSS") =
    let(
        w_offset = width_mode == "LINE_CROSS" ? [width / 2, -width / 2] : (
            width_mode == "LINE_INWARD" ? [0, -width] : [width, 0]
        ),
        frags = __frags(radius),
        a_step = 360 / frags,
        half_a_step = a_step / 2,
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        r_outer = radius + w_offset[0],
        r_inner = radius + w_offset[1],
        points = concat(
            // outer arc path
            [_edge_r_begin(r_outer, angles[0], a_step, m) * _unit_xy(angles[0])],
            [
                for(i = [m:n]) 
                    r_outer * _unit_xy(a_step * i)
            ],
            [_edge_r_end(r_outer, angles[1], a_step, n) * _unit_xy(angles[1])],
            // inner arc path
            [_edge_r_end(r_inner, angles[1], a_step, n) * _unit_xy(angles[1])],
            [
                for(i = [m:n]) 
                    let(idx = (n + (m - i)))
                    r_inner * _unit_xy(a_step * idx)

            ],
            [_edge_r_begin(r_inner, angles[0], a_step, m) * _unit_xy(angles[0])]        
        ),
        triangles = __triangles_tape(points)
    )
    [
        points, 
        triangles
    ];