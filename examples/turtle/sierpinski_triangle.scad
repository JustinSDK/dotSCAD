use <polyline_join.scad>
use <turtle/t2d.scad>

side_leng = 100;
min_leng = 4;
thickness = 0.5; 

sierpinski_triangle(
    t2d(point = [0, 0], angle = 0),
    side_leng, min_leng, thickness, $fn = 3
);

module triangle(t, side_leng, thickness) {    
    t2 = t2d(t, "forward", leng = side_leng);
    t3 = t2d(t2, [
        ["turn", 120],
        ["forward", side_leng]
    ]);

    polyline_join([for(turtle = [t, t2, t3, t]) t2d(turtle, "point")])
	    circle(thickness / 2);
}

module sierpinski_triangle(t, side_leng, min_leng, thickness) {
    triangle(t, side_leng, thickness);

    if(side_leng >= min_leng) { 
        half_leng = side_leng / 2;
        t2 = t2d(t, "forward", leng = half_leng); 
        t3 = t2d(t, [
            ["turn", 60],
            ["forward", half_leng],
            ["turn", -60]
        ]);
        for(turtle = [t, t2, t3]) {
            sierpinski_triangle(turtle, half_leng, min_leng, thickness);
        }
    }
}