use <_impl/_catmull_rom_spline.scad>;

function curve(t_step, points, tightness = 0) = 
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
use <curve.scad>;
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
points = curve(t_step, pts, tightness);

hull_polyline3d(points, 5);   
*/