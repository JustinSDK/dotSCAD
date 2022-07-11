use <archimedean_spiral.scad>
use <curve.scad>
use <along_with.scad>

use <dragon_head.scad>
use <dragon_scales.scad>
use <bezier_curve.scad>
use <path_extrude.scad>
use <dragon_claw.scad>

treble_clef_dragon();

module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);

    points = [[0, 0, 0], [0, .1, 1], [0, 1, 1.5]] * 5;
    path = bezier_curve(0.1, points);

    // dorsal fin
    translate([0, 3, -2]) 
    rotate([-75, 0, 0]) 
    path_extrude([[0, -.25], [0.6, 0], [0, .75], [-0.6, 0]] * 5, path, scale = .05); 
            
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
    hair();

    module hair() {
        tail_hair = [
            [3, -1],
            [5, -1.5],
            [8, -1],
            [9.5, 0],
            [8, -0.4],
            [6.5, -0.3],
            [8, 0],
            [10, 1],
            [14, 5],
            [17, 10],
            [14, 8],
            [12, 7],
            [9, 6],
            [11.5, 10],
            [13, 12],
            [16, 14],
            [12, 13],
            [8, 11],
            [10, 14],
            [5, 11],
            [3, 8.5],
            [-1, 3]
        ];

        rotate([-2.5, 0, 0])
        translate([-1, .5, 5.5])
        scale([1.1, 1, 1.3]) {
            translate([2, 0, -3])
            scale([2, 1, .8])
            rotate([-90, 70, 15])
            linear_extrude(.75, center = true)
                polygon(tail_hair);

            scale([.8, .9, .6])
            translate([2, 0, -5])
            scale([1.75, 1, .8])
            rotate([-90, 70, 15]) {
                linear_extrude(1.5, scale = 0.5)
                    polygon(tail_hair);
                mirror([0, 0, 1])
                linear_extrude(1.5, scale = 0.5)
                    polygon(tail_hair);
            }

            scale([.6, .7, .9])
            translate([2, 0, -4])
            scale([2, 1, .85])
            rotate([-90, 70, 15]) {
                linear_extrude(3.5, scale = 0.5)
                    polygon(tail_hair);
                mirror([0, 0, 1])
                linear_extrude(3.5, scale = 0.5)
                    polygon(tail_hair);
            }
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

    // claw
    children();
}

module treble_clef_dragon() {
    function __angy_angz(p1, p2) = 
        let(v = p2 - p1) 
        [
            atan2(v.z, norm([v.x, v.y])), 
            atan2(v.y, v.x)
        ];
        
    points_angles = archimedean_spiral(
        arm_distance = 20,
        init_angle = 200,
        point_distance = 3.25,
        num_of_points = 46,
        rt_dir = "CLK"
    ); 

    points = [for(pa = points_angles) pa[0]];

    cpts = [
        points[len(points) - 2],
        points[len(points) - 1],
        [5, 49],
        [6, 75],
        [-12, 70],
        [-5, 30],
        [2, -10],
        [1, -60],
        [-20, -55],
        [-10, -10],
    ];

    t_step = 0.1;     
    path2d = concat([for(i = [0:len(points) - 2]) points[i]], curve(t_step, cpts));
    body_path = [for(i = [0:len(path2d) - 1]) [each path2d[i], 15 * cos(i * 6.9)]];

    leng_body_path = len(body_path);
    angy_angz = __angy_angz(body_path[0], body_path[1]);

    translate(body_path[0])
    rotate([0, 90 + angy_angz[0], angy_angz[1]])
    rotate(-5)
        dragon_head();

    body_r = 6;
    body_fn = 12;
    scale_fn = 4;
    scale_tilt_a = 6;
    one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);

    along_with(body_path, scale = [0.45, 0.45, 0.85], twist = -30, method = "EULER_ANGLE")    
    rotate(5)
        one_segment(body_r, body_fn, one_body_scale_data);

    ayz = __angy_angz(body_path[leng_body_path - 2], body_path[leng_body_path - 1]);

    translate(body_path[leng_body_path - 1])
    rotate([0, -45 + ayz[0], ayz[1]])
    scale([.5, .5, 1])
    rotate([0, -10, 150])
        tail();

    translate([5, -24, -22.5]) 
    rotate([0, -20, 150])
    mirror([1, 0, 0])
    scale(.9)
    foot() {
        translate([6.4, 18.95, .25])
        rotate([11, 13, 185])
        scale([1.2, 1.2, 1.2])
            dragon_claw();
    }

    translate([8, -20, -21]) 
    rotate([0, -20, 5])
    mirror([1, 0, 0])
    scale(.9)
    foot() {
        translate([6.4, 19.25, .25])
        rotate([-5, -10, 15])
        scale([1.2, 1.2, 1.2])
            dragon_claw();
    }

    translate([-5, 38, -18.5]) 
    rotate([0, 0, -26]) 
    scale(.725)
    foot() {
        translate([6.4, 18.95, .25])
        rotate([-10, -10, 15])
        scale([1.2, 1.2, 1.2])
            dragon_claw();
    }

    translate([-7, 38, -19.5]) 
    rotate([0, 0, 125]) 
    scale(.725)
    mirror([1, 0, 0])
    foot() {
        translate([6.4, 19.25, .25])
        rotate([-5, 10, 120])
        scale([1.2, 1.2, 1.2])
            dragon_claw();        
    }
}