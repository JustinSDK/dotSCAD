use <../util/sort.scad>;
use <../util/dedup.scad>;
use <vx_bezier.scad>;

function _vx_catmull_rom_spline_4pts(points, tightness) = 
    let(
        p1x_0tightness = (points[2] - points[0]) / 4 + points[1],
        v_p1x = points[1] - p1x_0tightness,
        p1x = p1x_0tightness + v_p1x * tightness,
        p2x_0tightness = (points[1] - points[3]) / 4 + points[2],
        v_p2x = points[2] - p2x_0tightness,
        p2x = p2x_0tightness + v_p2x * tightness
    )
    vx_bezier(points[1], p1x, p2x, points[2]);

function vx_curve(points, tightness = 0) = 
    let(
        leng = len(points),
        pts = concat(
            [
                for(i = [0:leng - 4])
                    let(
                        pts = _vx_catmull_rom_spline_4pts([for(j = [i:i + 3]) points[j]], tightness)
                    )
                    for(i = [0:len(pts) - 2]) pts[i]    
            ],
            [points[leng - 2]]
        )
    )
    dedup(sort(pts, by = "vt"), sorted = true);