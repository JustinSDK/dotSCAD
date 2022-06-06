use <polyhedra/polar_zonohedra.scad>
use <polyhedra/octahedron.scad>
use <polyhedra/icosahedron.scad>
use <shear.scad>
use <polyline_join.scad>
use <bezier_curve.scad>
use <matrix/m_transpose.scad>
use <sweep.scad>
use <experimental/worley_sphere.scad>
use <curve.scad>
use <ptf/ptf_rotate.scad>
use <util/dedup.scad>

detail = 1;
head_angles = [5, 0, 20];

owl(detail, head_angles);
rock(detail);

// translate([100, 0, 0]) {
// 	owl(detail, [-15, 0, -20]);
// 	rock(detail);
// }

// translate([-100, 0, 0]) {
// 	owl(detail, [-35, 0, 30]);
// 	rock(detail);
// }

module owl(detail, head_angles) {
	n = (detail + 1) * 5;
	$fn = n;

	module head() {
		module eye_plane_mask() {
			translate([10, -17, 0])
			rotate([90, 0, 30])
			linear_extrude(10)
				circle(12);
		}

		module eye_ring() {
			translate([10, -16, 0])
			rotate([270, 0, 30])
			scale([1, 1, 2])
			rotate(180 / $fn)
			rotate_extrude()
			translate([12, 0, 0])
				circle(1.75);
		}

		module eye_hole_mask() {
			translate([10, -17, 0])
			rotate([270, 0, 30])
			rotate(180 / $fn)
			translate([0, 0, -1])
			linear_extrude(3, scale = .5)
			    circle(10);
		}

		module eye_ball() {
			translate([8, -13, 0])
				icosahedron(4, n / 5 - 1);
		}

		difference() {
			union() {
				difference() {
					rotate([15, 0, 0])
					shear(sy = [0, -.05])
					scale([25, 25, 25])
						octahedron(1, n / 5);

					eye_plane_mask();
					mirror([1, 0, 0])
						eye_plane_mask();
				}
				
				eye_ring();
				mirror([1, 0, 0])
					eye_ring();
			}
			
			eye_hole_mask();
			mirror([1, 0, 0])
				eye_hole_mask();
		}

		eye_ball();
		mirror([1, 0, 0])
			eye_ball();
		
		eyebrow();
		mirror([1, 0, 0])
			eyebrow();
		
		// beak
		translate([0, -23.25, -2.5])
		scale([.85, 1, 3.5])
		rotate([25, 0, 0])
			octahedron(2.5, detail);
	}

	module body() {
		// back
		translate([0, 57, 22])
		rotate([68, 0, 0])
		shear(sy = [0, .3])
		scale([110, 100, 150] / n)
			polar_zonohedra(n);


		// belly
		translate([0, 14, 22])
		rotate([5, 0, 0])
		scale([100, 90, 120] / n)
			polar_zonohedra(n);
			
		translate([0, 56.5, 15])
		rotate([12, 0, 0])
		shear(sy = [0, -1])
		scale([90, 90, 100] / n)
			polar_zonohedra(n);
		
		// tail
		translate([0, 69, 9])
		rotate([12, 0, 0])
		shear(sz = [0, .1])
		shear(sy = [0, -1.1])
		scale([80, 80, 110] / n)
			polar_zonohedra(n);

		translate([4, 69, 11])
		rotate([12, 0, 2])
		shear(sz = [0, .1])
		shear(sy = [0, -1.1])
		scale([60, 60, 100] / n)
			polar_zonohedra(n);
	}

	module wing() {
		translate([2, 61, 25])
		rotate([68, 5, 0])
		shear(sz = [0, .3])
		shear(sy = [0, .2])
		scale([120, 100, 140] / n)
			polar_zonohedra(n);
	}	

	module eyebrow() {
		t_step = 0.2 / detail;
		points = bezier_curve(t_step, [[0, -25, 0.5], [5, -26, 14.5], [15, -21, 7.5], [25, -6, 22.5]]);
		points2 = bezier_curve(t_step, [[0, -25, 0.5], [5, -26, 12.5], [20, -16, -0.5], [25, -6, 22.5]]);
		points3 = bezier_curve(t_step, [[0, -25, 0.5], [5, -11, 12.5], [15, -16, 9.5], [25, -6, 22.5]]);
		points4 = bezier_curve(t_step, [[0, -25, 0.5], [-5, -23, 17.5], [15, -21, 14.5], [25, -6, 22.5]]);

		sweep(
			m_transpose([points4, points3, points2, points])
		);
	}
	
	module claw() {
		pts = [
			[0, 0.55], [1, 0.45], [2.5, 0.375], [6, 0.825], [8, -0.375], 
			[8, -0.375], [6, 1.875], [4, 1.6], [1.8, 2.5], [1.5, 2.8], [1.2, 3.3], [1.05, 3.8], [1, 4], [0, 8]
		];

		$fn = 16;

		a = 360 / $fn;
		x = 6.2 * cos(a);
		y = 6.2 * sin(a);
		path = [
			[0, 0], [2.5, 0], [x, y], [x + 1, y + 1]
		];
		path2 = [
			for(i = len(path) - 1; i > -1; i = i - 1) 
				ptf_rotate([path[i][0], -path[i][1]], a * 2)
		];

		t_step = 0.25;
		claw_path_basic = concat(curve(t_step, path), curve(t_step, path2));

		claw_path1 = [for(p = claw_path_basic) ptf_rotate(p * 1.2, a * 2)];
		claw_path2 = [for(p = claw_path_basic) ptf_rotate(p * 1.15, a * 4)];
		claw_path3 = [for(p = claw_path_basic) ptf_rotate(p * 1.1, a * 6)];
		claw_path4 = [for(p = claw_path_basic) ptf_rotate(p, a * 12)];

		translate([10, 19, 18])
		scale([1.2, 1.2, 1.5])
		rotate([10, 0, 180])
		scale([1.15, 1.3, 1]) 
		intersection() {
			rotate_extrude($fn = 7)
				polygon(pts);
			linear_extrude(5)
				polygon(
					dedup(
						[
							each claw_path1, 
							each claw_path2, 
							each claw_path3,
							[-2, -.75], 
							[-1.45, -1.45],
							each claw_path4,
							[1.45, -1.45], 
							[2, -.75]
						]
					)
				);
		}
	}

	translate([0, 0, 82.5])
	rotate(head_angles)
		head(); 	
		
	body();

	wing();
	mirror([1, 0, 0])
		wing();

	claw();
    mirror([1, 0, 0])
		claw();
}

module rock(detail) {
    radius = 16.5;
    detail = detail;
    amplitude = .25;
    dist = "border"; 
	
	difference() {
		translate([1, 20, -6.9])
		scale([1, 1.2, 1])
		rotate([35, 3, 0])
		translate([0, 0, 12])
		scale([3, 1, 1])	
			worley_sphere(radius, detail, amplitude, dist, seed = 4);

		translate([0, 34, -30]) 
		linear_extrude(30)
			square(150, center = true);
	}
}


