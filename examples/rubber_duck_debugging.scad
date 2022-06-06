use <polyhedra/geom_icosahedron.scad>
use <polyline_join.scad>
use <bend_extrude.scad>

detail = 1;
object = "OpenSCAD";
font_size = 10;
thickness = 4;
bend_angle = 125;
pitch_angle = 5;

rubber_duck_debugging(detail, object, font_size, thickness, bend_angle, pitch_angle);

module rubber_duck_debugging(detail, object, font_size, thickness, bend_angle, pitch_angle) {
    r = font_size * len(object) * 0.85 * 360 / bend_angle / 2 / PI;
    difference() {
	    if($preview) {
			%duck(detail);
		}
		else {
			duck(detail);
		}
		rotate([-pitch_angle, 0, 0])
		translate([0, r - 36, -font_size / 2])
		rotate(180 + (180 - bend_angle) / 2)
		bend_extrude(
			size = [font_size * len(object) * 0.85, font_size * 1.25], thickness = thickness, 
			angle = bend_angle
		)
		translate([0, font_size / 3])
			text(
			    object, 
				size = font_size, 
				font = "Courier New:style=Bold"
			);
	}
}

module duck(detail) {
	points_faces = geom_icosahedron(1.02, detail);
	module icosphere() {
		polyhedron(points_faces[0], points_faces[1]);
	}

	module frillsAndUpperBeak() {
		pts = [   
			[0, 16, 10],
			[0, -2, 13],
			[0, -20, 8], 
			[0, -10, 28], 
			[0, -6, 52],
			[0, -13, 50], 
			[0, -16, 46], 
			[0, -23.5, 41.5],
			[0, -26.9, 41.9],
			[0, -31.9, 45.3]
		];

		polyline_join(pts) {
			scale([5, 5, 5]) icosphere();
			scale([10, 10, 10]) icosphere();	
			scale([15, 13, 15]) icosphere();
			scale([5, 5, 5]) icosphere();
			scale([6, 8, 5]) icosphere();
			scale([6, 4, 6.5]) icosphere();
			scale([5, 5, 5]) icosphere();
			scale([11, 5, 4.7]) icosphere();
			scale([9.9, 3, 4]) icosphere();
			scale([5, 3, 2]) icosphere();	
		};
	}

	module bodyBulk() {
		pts = [
			[0, 31, 25],
			[0, 27, 12],
			[0, 16, 0],
			[0, 6, 0],
			[0, -10, 3],
			[0, -10, 15],
			[0, -10, 29],
			[0, -7, 41], 
			[0, -20, 37.5], 
			[0, -28, 38]
		];

		polyline_join(pts) {
			scale([3.5, 3.5, 3.5]) icosphere();
			scale([10, 10, 10]) icosphere();	
			scale([15, 18, 16]) icosphere();
			scale([21, 20, 20]) icosphere();
			scale([28, 25, 22]) icosphere();
			scale([9, 9, 12]) icosphere();
			scale([8, 10, 8]) icosphere();
			scale([15, 17, 17]) icosphere();
			scale([13, 10, 4]) icosphere();
			scale([8, 6, 2]) icosphere();	
		};
	}

	module beakDetalAndFlank() {
		pts = [
			[0, -33, 46.5], 
			[3, -32.5, 46], 
			[6, -30.5, 43],
			[7.7, -28, 41.6],
			[9, -23, 42], 
			[8, -19, 43], 
			[8, -16, 46],
			[5, -18, 48], 
			[8, -16, 46],
			[0, -6, 46], 
			[0, -10, 8], 
			[9, -10, 4], 
			[7, 0, 3], 
			[3, 10, 3]
		];

		polyline_join(pts) {
			scale([1.5, 2.5, 2.5]) icosphere();
			scale([1.5, 2.5, 2.5]) icosphere();	
			scale([1.5, 2.5, 2]) icosphere();
			scale([2.5, 2.5, 1.5]) icosphere();
			scale([3, 2, 2]) icosphere();
			scale([3, 3, 3]) icosphere();
			scale([2, 2, 2]) icosphere();
			scale([4, 4, 4]) icosphere();
			scale([2, 2, 2]) icosphere();
			scale([2, 2, 2]) icosphere();	
			scale([10, 10, 10]) icosphere();
			scale([20, 20, 17]) icosphere();
			scale([19, 20, 18]) icosphere();
			scale([18, 20, 15]) icosphere();
		};
	}

	union() {
		frillsAndUpperBeak();
		bodyBulk();

		beakDetalAndFlank();
		mirror([1, 0, 0])
			beakDetalAndFlank();
	}
}