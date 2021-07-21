use <ellipse_extrude.scad>;
use <torus_knot.scad>;
use <shear.scad>;
use <curve.scad>;
use <along_with.scad>;
use <sweep.scad>;
use <paths2sections.scad>;
use <shape_trapezium.scad>;
use <util/reverse.scad>;
use <ptf/ptf_rotate.scad>;

torus_knot_dragon2();

module torus_knot_dragon2() {
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
        head(h_angy_angz);
		
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

module head(angy_angz) {
    module hair() {
        for(i = [16:36]) {
            rotate(i * 10) 
            translate([0, -13, 0]) 
            rotate([9, 0, 0]) 
            linear_extrude(15, scale = 0.05, twist = 50 - rands(0, 100, 1, seed = i)[0]) 
            translate([0, 10, 0]) 
                circle(3, $fn = 4);    
        }       

        for(i = [0:35]) {
            rotate(i * 12) 
            translate([0, -11.5, 0]) 
            rotate([5, 0, 0]) 
            linear_extrude(20, scale = 0.05, twist = 50 - rands(0, 100, 1, seed = i + 1)[0]) 
            translate([0, 10, 0]) 
                circle(3.2, $fn = 5);    
        }
        
        for(i = [0:35]) {
            rotate(i * 10) 
            translate([0, -10, 0]) 
            rotate([2, 0, 0]) 
            linear_extrude(22, scale = 0.05, twist = 50 - rands(0, 100, 1, seed = i + 2)[0]) 
            translate([0, 10, 0]) 
                circle(3, $fn = 5);    
        }         
    }
    
    module one_horn() {        
        translate([-9, -4, -2]) 
        rotate([45, -25, 0]) 
        linear_extrude(30, scale = 0.1, twist = -90) 
        translate([7.5, 0, 0]) 
            circle(3, $fn = 4);    
    }
    
    module mouth() {
        path1 = curve(0.4, [[0, -8, -1], [0, -11, .25], [0, -12, 5], [0, -9, 5], [0, -4, 6], [0, -0.5, 8], [0, 5, 6.5], [0, 8, 6], [0, 12, 1], [0, 16, 0]]);
        path2 = [for(p = path1) ptf_rotate(p, [0, -12, 0]) * 0.9 + [-2, 0, 0]];
        path3 = [for(i = [0:len(path1) - 1]) [-i / 6 - 1.5, i / 1.65 - 9, 0]];
        path4 = [for(p = path3) [-p[0], p[1], p[2]]];
        path5 = [for(p = path2) [-p[0], p[1], p[2]]];

        translate([0, 0, -2]) 
        rotate([90, 0, -90]) 
            sweep(paths2sections([path1, path2, path3, path4, path5]));

        translate([0, 0, -3.25]) 
        rotate([90, 0, -90]) 
            ellipse_extrude(5.5, slices = 2) 
                polygon(
                    shape_trapezium([5, 18], 
                    h = 20,
                    corner_r = 2, $fn = 4)
                );    
                    
        mirror([1, 0, 0]) 
        translate([0, 0, -3]) 
        rotate([85, 0, -90])
        ellipse_extrude(4, slices = 2) 
            polygon(
                shape_trapezium([5, 18], 
                h = 20,
                corner_r = 2, $fn = 5)
            );       
    }
    
    module one_eye() {
        translate([-5, 2.5, -2]) 
        rotate([-5, -8, -10]) 
        scale([1, 1, 1.75]) 
            sphere(1.75, $fn = 6);      

        translate([-5.1, 3.75, -2.25]) 
        rotate([-25, 0, 75]) 
            sphere(0.65, $fn = 6);                      
    }
    
    module one_beard() {
        translate([-11.15, -12, -10])
        rotate(180) 
        linear_extrude(8, scale = 0.2, twist = 90) 
        translate([-10, -10, 0]) 
            circle(1, $fn = 6);    
    }
    
    rotate([0, angy_angz[0] + 15, angy_angz[1]]) 
    translate([0, 0, -25 / 2]) 
    scale(1.15) {
        scale([0.8, 0.9, 1]) hair();

        translate([0, 0, 2]) {
            rotate(-90) {
                    one_horn();
                    mirror([-1, 0, 0]) one_horn();       
            }
            
            mouth();

            one_eye();
            mirror([0, 1, 0]) one_eye();
            
            one_beard();
            mirror([0, 1, 0]) one_beard();
        }        
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