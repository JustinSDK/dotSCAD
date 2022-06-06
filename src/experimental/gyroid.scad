use <_impl/Gyroid3.scad>

module gyroid(detail, thickness, period) {
	pp = 2 + detail;										
	w = thickness;										

	f = gyroid_faces(pp = pp);
	fi = swap_xy(m = f);			
	
	points_lt = gyroid_points(pp = pp, w = w);		
	range = [0:len(points_lt) - 1];
	faces_lt = [for(i = range) (i % 2 == 0) ? fi : f];
	
	module cell() {
		gyroid_cell()						
		for(i = range) {				
			polyhedron(points_lt[i], faces_lt[i]);	
		}
	}
	
	for(z = [0:period.z - 1], y = [0:period.y - 1], x = [0:period.x - 1]) {
		translate([x, y, z] * 360)
		    cell();
	}
}

// detail = 10;
// thickness = 20;
// period = [2, 2, 2];

// gyroid(detail, thickness, period);
