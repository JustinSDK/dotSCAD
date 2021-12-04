use <torus_knot.scad>;
use <shear.scad>;
use <along_with.scad>;
use <util/reverse.scad>;
use <dragon_head.scad>;
use <dragon_scales.scad>;

torus_knot_dragon();

module torus_knot_dragon() {
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
            dx = p2.x - p1.x,
            dy = p2.y - p1.y,
            dz = p2.z - p1.z,
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [ya, za];
		
	h_angy_angz = __angy_angz(d_path[len(d_path) - 2], d_path[len(d_path) - 1]);
	
	translate([2.5, -1.1, .55])
    scale(0.07)    
    rotate([0, h_angy_angz[0] + 28, h_angy_angz[1] + 245])
        dragon_head();
		
	t_angy_angz = __angy_angz(d_path[1], d_path[0]);	
	
	translate([2.09, 1.56, -.8])
	rotate([0, t_angy_angz[0], t_angy_angz[1]])
	rotate([0, -95, -75])
	scale([0.038, 0.038, 0.065])
	    tail();
}

module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);

    // dorsal fin
    translate([0, 2.5, -3]) 
    rotate([-65, 0, 0]) 
    shear(sy = [0, 2])
    linear_extrude(4, scale = 0.2)
        square([2, 10], center = true);            
            
    // belly    
    translate([0, -2.5, .8]) 
    rotate([-5, 0, 0]) 
    scale([1, 1, 1.4])  
        sphere(5.8, $fn = 8); 
    
}

module tail() {
    $fn = 8;
    tail_scales(75, 2.5, 5, -4, 1.25);
    tail_scales(100, 1.25, 4.5, -7, 1);
    tail_scales(110, 1.25, 3, -9, 1);
    tail_scales(120, 2.5, 2, -9, 1);   
}