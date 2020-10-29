use <bezier_curve.scad>;

function _catmull_rom_spline_4pts(t_step, points, tightness) = 
    let(
        p1x_0tightness = (points[2] - points[0]) / 4 + points[1],
        v_p1x = points[1] - p1x_0tightness,
        p1x = p1x_0tightness + v_p1x * tightness,
        p2x_0tightness = (points[1] - points[3]) / 4 + points[2],
        v_p2x = points[2] - p2x_0tightness,
        p2x = p2x_0tightness + v_p2x * tightness
    )
    bezier_curve(t_step, [points[1], p1x, p2x, points[2]]);

function catmull_rom_spline(t_step, points, tightness = 0) = 
    let(
        leng = len(points)
    )
    concat(
        [
            for(i = [0:leng - 4])
                let(
                    pts = _catmull_rom_spline_4pts(t_step, [for(j = [i:i + 3]) points[j]], tightness)
                )
                for(i = [0:len(pts) - 2]) pts[i]    
        ],
        [points[leng - 2]]
    );
    