use <helix.scad>;
use <along_with.scad>;
use <shear.scad>;
use <curve.scad>;
use <sweep.scad>;
use <shape_circle.scad>;
use <bezier_curve.scad>;
use <path_scaling_sections.scad>;
use <noise/nz_perlin2s.scad>;
use <dragon_head.scad>;

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
        // %scales(110, 1.25, 3, -9, 1);
        // %scales(120, 2.5, 2, -9, 1);   
    }
    
    // dorsal fin
    translate([0, 3, -3]) 
    rotate([-75, 0, 0]) 
    shear(sy = [0, 3.5])
    linear_extrude(2.25, scale = 0.2)
        square([2, 12], center = true);            
            
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

module spiral_dragon() {
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
    
    translate([28, 1, -1.6])
    rotate([-88, 0, 0])
    rotate([0, 0, 15])
    scale([.975, .975, 1.2])
        tail();

    translate([19, 0, 65]) 
    rotate([95, 0, 0]) 
        dragon_head(angy_angz);
}

module flame_mountain(beginning_radius, fn, amplitude,curve_step, smoothness) {
	seed = 1000;
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

rotate(180) {
    translate([0, 0, 7]) 
        spiral_dragon($fn = 12);
    rotate(60)
        flame_mountain(
            beginning_radius = 26, 
            fn = 18, 
            amplitude = 7, 
            curve_step = 0.04, 
            smoothness = 10
        );
}