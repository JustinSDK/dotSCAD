use <torus_knot.scad>
use <along_with.scad>
use <util/reverse.scad>
use <dragon_head.scad>
use <dragon_scales.scad>
use <dragon_foot.scad> 
use <fibonacci_lattice.scad>
use <polyhedron_hull.scad>
use <path_extrude.scad>
use <bezier_curve.scad>

torus_knot_dragon_and_pearl();

module torus_knot_dragon_and_pearl() {
    phi_step = 0.0525;

    body_r = 6;
    body_fn = 12;
    scale_fn = 8;
    scale_tilt_a = 3;

    knot = torus_knot(2, 3, phi_step);
    d_path = reverse([for(i = [6:len(knot) - 4]) knot[i]]);
    
    one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);
    along_with(d_path, scale = [0.6, 0.6, 0.85], method = "EULER_ANGLE")    
    scale(0.06)
        one_segment(body_r, body_fn, one_body_scale_data);

    function __angy_angz(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [ya, za];
        
    h_angy_angz = __angy_angz(d_path[len(d_path) - 2], d_path[len(d_path) - 1]);
    
	translate([2.5, -1.2, .65])
    scale(0.06)    
    rotate([0, h_angy_angz[0] + 28, h_angy_angz[1] + 247])
        dragon_head();
        
    t_angy_angz = __angy_angz(d_path[1], d_path[0]);    
    
	translate([2.09, 1.56, -.82])
	rotate([0, t_angy_angz[0], t_angy_angz[1]])
	rotate([0, -98, -70])
	scale([0.038, 0.038, 0.065])
    rotate([0, 0, 200])
	    tail();

    // pearl
    polyhedron_hull(fibonacci_lattice(66, .5));
    
    // feet
    translate([.10, -1, .225])
    rotate([7, -7.5, 26])
    scale(0.0475)
        foot();

    translate([.4, -1.75, .6])
    rotate([30, -60, -45])
    mirror([0, 1, 0])
    scale(0.0475)
        foot();

    translate([-1.6, .55, .49])
    rotate([0, 0, 150])
    mirror([0, 1, 0])
    scale(0.045)
        foot();

    translate([-1.9, .5, .745])
    rotate([-45, -30, -120])
    scale(0.045)
        foot();
}

module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);


    points = [[0, 0, 0], [0, .1, 1], [0, 1, 1.5]] * 5.5;
    path = bezier_curve(0.1, points);

    // dorsal fin
    translate([0, 3.2, -3]) 
    rotate([-65, 0, 0]) 
    path_extrude([[0, -.25], [0.5, 0], [0, .75], [-0.5, 0]] * 5.5, path, scale = .05);        
            
    // belly    
    translate([0, -2.5, .8]) 
    rotate([-5, 0, 0]) 
    scale([1, 1, 1.4])  
        sphere(5.8, $fn = 8); 
    
}

module tail() {
    $fn = 8;
    tail_scales(75, 2.5, 4.25, -4, 1.25);
    tail_scales(100, 1.25, 4.5, -7, 1);
    tail_scales(110, 1.25, 3, -9, 1);
    tail_scales(120, 2.5, 2, -9, 1);   
    translate([3, 0, -2.5])
    rotate([0, 0, 0])
    scale([.8, .8, 1])
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