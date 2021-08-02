use <dragon_head.scad>;
use <dragon_scales.scad>;
use <bezier_curve.scad>;
use <shear.scad>;
use <along_with.scad>;
use <hull_polyline3d.scad>;
use <bezier_smooth.scad>;
use <dragon_claw.scad>;

function __angy_angz(p1, p2) = 
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2],
        ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
        za = atan2(dy, dx)
    ) [ya, za];


module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);

    // dorsal fin
    translate([0, 4, -3]) 
    rotate([-65, 0, 0]) 
    shear(sy = [0, 3])
    linear_extrude(2.25, scale = 0.2)
        square([2, 12], center = true);            
            
    // belly    
    translate([0, -2.5, .8]) 
    rotate([-5, 0, 0]) 
    scale([1, 1, 1.4])  
        sphere(body_r * 0.966, $fn = 8); 
    
}

module tail() {
    $fn = 4;
    scale([1,0.85, 1]) union() {
        tail_scales(75, 2.5, 4.25, -4, 1.25);
        tail_scales(100, 1.25, 4.5, -7, 1);
        tail_scales(110, 1.25, 3, -9, 1);
        tail_scales(120, 2.5, 2, -9, 1);   
    }
}

module foot() {
    pts = [[.5, 1, 10], [1.25, 6.25, 11.25], [2, 11.5, 12.5], [2, 16.75, 13.75], [1.9, 20, 14.25]];
    pts2 = [[2, 22, 14],  [3.5, 21, 10], [4.5, 20.3, 6.5]];

    one_body_scale_data1 = one_body_scale(body_r * 0.6, 6, scale_fn, scale_tilt_a);
    one_body_scale_data2 = one_body_scale(body_r * 0.45, 6, scale_fn, scale_tilt_a);

    along_with(pts, scale = 0.75, method = "EULER_ANGLE") 
        rotate([-90, 0, 0])
            dragon_body_scales(body_r * 0.6, 6, one_body_scale_data1);
    along_with(pts2, scale = 0.6, method = "EULER_ANGLE") 
        rotate([-90, 0, 0])
            dragon_body_scales(body_r * 0.5, 6, one_body_scale_data2);
    
    translate([2.25, 14.5, 12.75])
    scale([0.7, 1.15, .8])
    rotate([107, 9, 1])
        tail();

    translate([6, 19.25, 0])
    rotate([10, 10, 185])
    scale([1.1, 1.1, 1.2])
        dragon_claw();
}

x1 = 30;
x2 = 30;
x3 = 0;
x4 = 0;

t_step = 0.02;

p0 = [0, 0, 0];
p1 = [0, 50, 35];
p2 = [-50, 70, 0];
p3 = [x1, 90, -15];
p4 = [x2, 150, -20];
p5 = [x3, 160, -3];
p6 = [x4, 180, 10];

path_pts = bezier_curve(t_step, 
    [p0, p1, p2, p3, p4, p5, p6]
);

scale(1.1)
    dragon_head(__angy_angz(path_pts[0], path_pts[1]));

body_r = 6;
body_fn = 12;
scale_fn = 4;
scale_tilt_a = 6;
one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);

along_with(path_pts, scale = 0.6, method = "EULER_ANGLE")    
    one_segment(body_r, body_fn, one_body_scale_data);

ayz = __angy_angz(path_pts[len(path_pts) - 2], path_pts[len(path_pts) - 1]);

translate(path_pts[len(path_pts) - 1])
rotate([0, ayz[0] + 25, ayz[1]])
mirror([0, 0, 1])
rotate(-12)
scale(0.775)
    tail();

translate([-2, 30, 3]) 
rotate(-15) 
    foot();

translate([-7.5, 20, 10]) 
rotate([-60, 45, 25]) 
mirror([1, 0, 0])
    foot();

translate([9, 120, -17]) 
rotate([10, 20, -60]) 
scale(0.8)
    foot();

translate([9, 125, -14]) 
rotate([20, 20, 30]) 
rotate([10, -60, 0]) 
scale(0.8)
mirror([1, 0, 0])
    foot();