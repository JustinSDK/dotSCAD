use <bezier_curve.scad>;
use <shear.scad>;
use <along_with.scad>;
use <bezier_smooth.scad>;
use <fibonacci_lattice.scad>;
use <polyhedron_hull.scad>;
use <dragon_head.scad>;
use <dragon_scales.scad>;
use <dragon_claw.scad>;

dragon_and_perl();

module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);

    // dorsal fin
    translate([0, 3.2, -3]) 
    rotate([-61, 0, 0]) 
    shear(sy = [0, 2.25])
    linear_extrude(3.25, scale = 0.3)
        square([1.5, 10], center = true);            
            
    // belly    
    translate([0, -2.5, .8]) 
    rotate([-5, 0, 0]) 
    scale([1, 1, 1.4])  
        sphere(body_r * 0.966, $fn = 8); 
    
}

module tail() {
    $fn = 4;
    tail_scales(75, 2.5, 4.25, -4, 1.25);
    tail_scales(100, 1.25, 4.5, -7, 1);
    tail_scales(110, 1.25, 3, -9, 1);
    tail_scales(120, 2.5, 2, -9, 1);   
}

module knee_scales(ang, leng, radius, height, thickness) {
    module one_scale() {
        rotate([0, ang, 0]) 
        shear(sx = [0, -2])
        linear_extrude(thickness, center = true) 
        scale([leng, 1]) 
            circle(1);    
    }

    for(a = [0:60:300]) {
        hull() {
            rotate(a) 
            translate([radius, 0, height]) 
                one_scale();
                
            rotate(a + 15) 
            translate([radius, 0, height + 1.75]) 
                one_scale();
        }
    }
}
module knee() {
    $fn = 4;
    scale([1,0.85, 1]) union() {
        knee_scales(75, 2.5, 4.25, -4, 1.25);
        knee_scales(100, 1.25, 4.5, -7, 1);
        knee_scales(110, 1.25, 3, -9, 1);
        knee_scales(120, 2.5, 2, -9, 1);   
    }
}

module foot() {
    upper_arm_r = 3.6;
    lower_arm_r = 2.7;
    arm_fn = 6;
    scale_fn = 4;
    scale_tilt_a = 6;

    upper_arm_path = [[.5, 1, 10], [1.25, 6.25, 11.25], [2, 11.5, 12.5], [2, 16.75, 13.75], [1.9, 20, 14.25]];
    lower_arm_path = [[2, 22, 14],  [3.5, 21, 10], [4.5, 20.3, 7]];

    upper_arm_scale_data = one_body_scale(upper_arm_r, arm_fn, scale_fn, scale_tilt_a);
    lower_arm_scale_data = one_body_scale(lower_arm_r, arm_fn, scale_fn, scale_tilt_a);

    along_with(upper_arm_path, scale = 0.75, method = "EULER_ANGLE") 
        rotate([-90, 0, 0])
            dragon_body_scales(upper_arm_r, arm_fn, upper_arm_scale_data);
    along_with(lower_arm_path, scale = 0.7, method = "EULER_ANGLE") 
        rotate([-90, 0, 0])
            dragon_body_scales(lower_arm_r, arm_fn, lower_arm_scale_data);
    
    translate([2.25, 14.5, 12.75])
    scale([0.7, 1.15, .8])
    rotate([108, 9, 1])
        knee();

    translate([6.4, 18.95, .25])
    rotate([11, 13, 185])
    scale([1.2, 1.2, 1.2])
        dragon_claw();
}

module dragon_and_perl() {
    function __angy_angz(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            za = atan2(dy, dx)
        ) [ya, za];
        
    body_path = bezier_curve(0.02, [
        [0, 7.5, 15],
        [0, 30, 0],
        [-30, 50, -55],
        [-50, 70, 0],
        [20, 90, 60],
        [50, 110, 0],
        [0, 130, -30],
        [-10, 150, 0],
        [-5, 170, 0]
    ]);
    leng_body_path = len(body_path);
    angy_angz = __angy_angz(body_path[0], body_path[1]);

    translate([1, 7, 14])
    rotate([-135, 0, 3])
    scale(1.15)
    rotate([0, angy_angz[0], angy_angz[1]])
        dragon_head();

    body_r = 6;
    body_fn = 12;
    scale_fn = 4;
    scale_tilt_a = 6;
    one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);

    along_with(body_path, scale = 0.5, method = "EULER_ANGLE")    
        one_segment(body_r, body_fn, one_body_scale_data);

    ayz = __angy_angz(body_path[leng_body_path - 2], body_path[leng_body_path - 1]);

    translate(body_path[leng_body_path - 1])
    rotate([0, ayz[0] + 85, ayz[1]])
    mirror([0, 0, 1])
    rotate(-12)
    scale(0.6)
        tail();

    translate([-5, 25, -13]) 
    rotate([-20, 0, -15]) 
        foot();

    translate([-10, 15, -7]) 
    rotate([-60, 45, 25]) 
    mirror([1, 0, 0])
        foot();

    translate([11.5, 110, -3]) 
    rotate([-10, 20, -50]) 
    scale(0.75)
        foot();

    translate([7, 108, -1]) 
    rotate([5, 20, 60]) 
    rotate([10, -30, 0]) 
    scale(0.75)
    mirror([1, 0, 0])
        foot();

    translate([-27.5, 11.75, -14])
        polyhedron_hull(fibonacci_lattice(66, 7));
}