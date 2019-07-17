include <bezier_curve.scad>;
include <pixel/px_line.scad>;
include <pixel/px_polyline.scad>;
include <pixel/px_cylinder.scad>;

x1 = 5;
x2 = 20;
x3 = 8;
thickness = 1;

module pixel_vase(x1, x2, x3, thickness) {
    p0 = [x1, 0, 0];
    p1 = [10, 0, 4];
    p2 = [x2, 0, 8];
    p3 = [3, 0, 20];
    p4 = [x3, 0, 30];

    rounded_points = [for(pt = bezier_curve(0.1, 
        [p0, p1, p2, p3, p4]
    )) [round(pt[0]), round(pt[1]), round(pt[2])]];

    px_path = px_polyline(rounded_points);
    leng = len(px_path);

    for(p = px_cylinder(px_path[0][0], 1, true)) { 
        linear_extrude(1) union() {
            translate([p[0], p[1]])
                square(1.1, center = true);
        }
    }

    for(i = [0:leng - 1]) {
        r = px_path[i][0];
        for(p = px_cylinder(r, 1, thickness = thickness)) { 
            translate([0, 0, i]) 
                linear_extrude(1) union() {
                    translate([p[0], p[1]])
                        square(1.1, center = true);
                }
        }
    }  
}    

pixel_vase(x1, x2, x3, thickness);