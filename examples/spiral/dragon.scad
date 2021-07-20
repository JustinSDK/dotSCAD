use <helix.scad>;
use <along_with.scad>;
use <shape_trapezium.scad>;
use <ellipse_extrude.scad>;
use <shear.scad>;
use <curve.scad>;
use <sweep.scad>;
use <paths2sections.scad>;
use <ptf/ptf_rotate.scad>;
use <shape_circle.scad>;
use <bezier_curve.scad>;
use <path_scaling_sections.scad>;
use <util/rand.scad>;
use <noise/nz_perlin2s.scad>;

r1 = 25;
r2 = 15;
levels = 3;
level_dist = 20;

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
        scales(110, 1.25, 3, -9, 1);
        scales(120, 2.5, 2, -9, 1);   
    }
    
    // dorsal fin
    translate([0, 3, -3]) 
    rotate([-75, 0, 0]) 
    shear(sy = [0, 3.5])
    linear_extrude(2.25, scale = 0.2)
        square([2, 12], center = true);            
            
    // belly
    translate([0, -2.5, 1]) 
    rotate([-10, 0, 0]) 
    scale([1.1, 0.8, 1.25])  
        sphere(5.8, $fn = 8); 

    translate([0, 0, -1.65]) 
    rotate([-5, 0, 0]) 
    scale([1, 0.8, 1.6])  
        sphere(5.5, $fn = 8);  
        
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
        translate([-10, -4, -1]) 
        rotate([40, -25, 0]) 
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

        translate([0, 0, -3]) 
        rotate([90, 0, -90]) 
            ellipse_extrude(5.5, slices = 4) 
                polygon(
                shape_trapezium([6, 20], 
                h = 20,
                corner_r = 0)
            );    
                    
        mirror([1, 0, 0]) 
        translate([0, 0, -3]) 
        rotate([85, 0, -90])
        ellipse_extrude(4, slices = 2) 
            polygon(
                shape_trapezium([6, 19], 
                h = 20,
                corner_r = 0)
            );       
    }
    
    module one_eye() {
        translate([-5, 2.6, -2]) 
        rotate([-10, 0, -25]) 
        scale([1, 1, 2]) 
            sphere(1.75, $fn = 5);      

        translate([-5.25, 3.5, -2.5]) 
        rotate([-15, 0, 75]) 
            sphere(0.65, $fn = 7);                      
    }
    
    module one_beard() {
        translate([-11, -12, -11])
        rotate(180) 
        linear_extrude(8, scale = 0.2, twist = 90) 
        translate([-10, -10, 0]) 
            circle(1.25, $fn = 6);    
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

module dragon() {
    path_pts = helix(
        radius = [r1, r2], 
        levels = levels, 
        level_dist = level_dist, 
        vt_dir = "SPI_DOWN", 
        rt_dir = "CLK", 
        $fn = 36
    );

    function __angy_angz(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [ya, za];
        
    angy_angz = __angy_angz(path_pts[0], path_pts[1]);
    
    scale(1.1) 
    along_with(path_pts, scale = 0.85, method = "EULER_ANGLE")    
        one_segment();
        
    translate([19, 0, 65]) 
    rotate([95, 0, 0]) 
    head(angy_angz);
}

module flame_mountain(beginning_radius, fn, amplitude,curve_step, smoothness) {
	seed = rand() * 1000;
	section = shape_circle(radius = beginning_radius, $fn = fn);
	pt = [beginning_radius, 0, 0];

	edge_path = bezier_curve(curve_step, [
		pt,
		pt + [-6, 0, 20],
		pt + [-7, 0, 50],
		pt + [-9, 0, 60],
		pt + [-26, 0, 72],
		pt * 0.9 + [-23.25, 0, 85]
	]);


	sections = path_scaling_sections(section, edge_path);

    noise = function(pts, seed) nz_perlin2s(pts, seed);

	noisy = [
		for(section = sections)
		let(nz = noise(section / smoothness, seed))
		[
			for(i = [0:len(nz) - 1])
			let(
				p = section[i],
				p2d = [p[0], p[1]],
				noisyP = p2d + p2d / norm(p2d) * nz[i] * amplitude
			)
			[noisyP[0], noisyP[1], p[2]]
		]
	];


	sweep(noisy);
}

translate([0, 0, 7]) 
    dragon($fn = 12);
rotate(60)
    flame_mountain(
        beginning_radius = 26, 
        fn = 18, 
        amplitude = 8, 
        curve_step = 0.04, 
        smoothness = 10
    );
