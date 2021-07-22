use <torus_knot.scad>;
use <shear.scad>;
use <along_with.scad>;
use <util/reverse.scad>;
use <dragon_head.scad>;

torus_knot_dragon();

module torus_knot_dragon() {
    phi_step = 0.05;

    knot = torus_knot(2, 3, phi_step);
    d_path = reverse([for(i = [6:len(knot) - 4]) knot[i]]);
	
	along_with(d_path, scale = 0.85, method = "EULER_ANGLE")    
	scale(0.06)
	    one_segment();

    function __angy_angz(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [ya, za];
		
	h_angy_angz = __angy_angz(d_path[len(d_path) - 2], d_path[len(d_path) - 1]);
	
	translate([2.75, -.9, .45])
    rotate([0, 28, 245])
    scale(0.0625)    
        dragon_head(h_angy_angz);
		
	t_angy_angz = __angy_angz(d_path[1], d_path[0]);	
	
	translate([2.25, 1.5, -.8])
	rotate([0, t_angy_angz[0], t_angy_angz[1]])
	rotate([0, -100, -90])
	scale([0.0525, 0.0525, 0.06])
	    tail();
}

module scales(ang, leng, radius, height, thickness) {
    module one_scale() {
        rotate([0, ang, 0]) 
        shear(sx = [0, -1.5])
        linear_extrude(thickness, center = true) 
        scale([leng, 1]) 
            circle(1, $fn = 4);    
    }

    for(a = [0:30:330]) {
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

module one_segment() {
    // scales
    scale([1,0.85,1]) union() {
        scales(60, 4, 5, 0, 1.5);
        scales(75, 2.5, 5, -4, 1.25);
        scales(100, 1.25, 4.5, -7, 1);
        // %scales(110, 1.25, 3, -9, 1);
        // %scales(120, 2.5, 2, -9, 1);   
    }
    
    // dorsal fin
    translate([0, 2.5, -3]) 
    rotate([-65, 0, 0]) 
    shear(sy = [0, 2])
    linear_extrude(4, scale = 0.2)
        square([2, 10], center = true);            
            
    // belly
    hull() {
        translate([0, -2.5, 1]) 
        rotate([-10, 0, 0]) 
        scale([1.1, 0.8, 1.25])  
            sphere(5.8, $fn = 8); 

        translate([0, 0, -1.65]) 
        rotate([-5, 0, 0]) 
        scale([1, 0.8, 1.6])  
            sphere(5.5, $fn = 8);  
    } 
}

module tail() {
    scale([1,0.85,1]) union() {
        // scales(60, 4, 5, 0, 1.5);
        scales(75, 2.5, 5, -4, 1.25);
        scales(100, 1.25, 4.5, -7, 1);
        scales(110, 1.25, 3, -9, 1);
        scales(120, 2.5, 2, -9, 1);   
    }
}