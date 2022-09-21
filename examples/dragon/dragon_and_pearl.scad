use <bezier_curve.scad>
use <along_with.scad>
use <bezier_smooth.scad>
use <fibonacci_lattice.scad>
use <polyhedron_hull.scad>
use <dragon_head.scad>
use <dragon_scales.scad>
use <dragon_foot.scad>
use <path_extrude.scad>
use <bezier_curve.scad>

dragon_and_perl();

module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);

    points = [[0, 0, 0], [0, .1, 1], [0, 1, 1.5]] * 5;
    path = bezier_curve(0.1, points);

    // dorsal fin
    translate([0, 3.2, -3]) 
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

module dragon_and_perl() {
    function __angy_angz(p1, p2) = 
        let(v = p2 - p1) 
        [
            atan2(v.z, norm([v.x, v.y])), 
            atan2(v.y, v.x)
        ];
        
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

    translate([-.4, 10, 13.5])
    rotate([-138, -4, 8])
    rotate([0, angy_angz[0], angy_angz[1]])
    scale(1.1)
        dragon_head();

    body_r = 6;
    body_fn = 12;
    scale_fn = 4;
    scale_tilt_a = 6;
    one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);

    along_with(body_path, scale = [0.25, 0.25, 0.5], method = "EULER_ANGLE")    
        one_segment(body_r, body_fn, one_body_scale_data);

    ayz = __angy_angz(body_path[leng_body_path - 2], body_path[leng_body_path - 1]);

    translate(body_path[leng_body_path - 1])
    rotate([0, ayz[0] + 82, ayz[1]])
    mirror([0, 0, 1])
    rotate(-12)
    scale([0.3, 0.3, 0.6])
        tail();

    translate([-5, 25, -12.5]) 
    rotate([-20, 0, -15]) 
        foot();

    translate([-10, 15, -6.5]) 
    rotate([-60, 45, 25]) 
    mirror([1, 0, 0])
        foot();

    translate([11.5, 107, -.5]) 
    rotate([-10, 20, -50]) 
    scale(0.65)
        foot();

    translate([7, 108, .25]) 
    rotate([5, 20, 60]) 
    rotate([10, -30, 0]) 
    scale(0.65)
    mirror([1, 0, 0])
        foot();

    translate([-27.5, 11.75, -14])
        polyhedron_hull(fibonacci_lattice(66, 7));
}