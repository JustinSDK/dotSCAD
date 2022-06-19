use <voronoi/vrn_sphere.scad>
use <polyline_join.scad>
use <pp/pp_sphere.scad>
use <experimental/r_union3.scad>

eyelets = 800;
radius = 50;

voronoi_melon(eyelets, radius);

module voronoi_melon(eyelets, radius) {
    pts = pp_sphere(radius, eyelets);
	cells = vrn_sphere(pts);

    color("DarkKhaki")
	for(cell = cells) {
		polyline_join([each cell, cell[0]])
			sphere(radius / 60, $fn = 4);
	}
	
	color("Olive")
	sphere(radius, $fn = 96);
	
	color("DarkOliveGreen") {
		r_union3(radius / 8.4) {
			scale(.99)
				sphere(radius, $fn = 24);
			
			translate([0, 0, radius * 0.875])
			hull() {
				$fn = 8;
				sphere(radius / 15);
				translate([0, 0, radius * .25])
					sphere(radius / 20);
			}
		}
		
		translate([0, 0, radius * 0.9]) {
			$fn = 8;

			hull() {
				translate([radius / 2, 0, radius * .30])
					sphere(radius / 40);
				translate([0, 0, radius * .25])
					sphere(radius / 20);
			}

			hull() {
				translate([-radius / 4, radius / 10, radius * .35])
					sphere(radius / 40);
				translate([0, 0, radius * .25])
					sphere(radius / 20);
			}
		}
	}
}