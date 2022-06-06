use <../vx_bezier.scad>

function _vx_catmull_rom_spline_4pts(points, tightness) = 
    let(
        p1 = points[1],
        p2 = points[2],
        t = (tightness - 1) / 4
    )
    vx_bezier(p1, (points[0] - p2) * t + p1, (points[3] - p1) * t + p2, p2);