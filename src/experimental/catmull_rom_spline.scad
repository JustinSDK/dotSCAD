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
    let(leng = len(points))
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

/*
use <experimental/catmull_rom_spline.scad>;
use <hull_polyline3d.scad>;

pts = [
    [280, 20, 10],
    [150, 80, -100],
    [20, 140, 50],
    [280, 140, 20],
    [150, 210, 90],
    [20, 280, 0]
];

#for(pt = pts) {
    translate(pt)
        sphere(10);
}

t_step = 0.1;    
tightness = 0;
points = catmull_rom_spline(t_step, pts, tightness);

hull_polyline3d(points, 5);   
*/