beginning_radius = 7.5;
fn = 4;
number_of_polygons = 10;
height = 20;
thickness = 1.5;
spacing = 0.5 * thickness;
slope = 1.2;

fidget_polygon(beginning_radius, fn, number_of_polygons, height, thickness, spacing, slope);

module fidget_polygon(beginning_radius, fn, n, height, thickness, spacing, slope) {
    theta = 180 / fn;

	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness + spacing;
	pw = pow((beginning_radius + dr) * sin(theta), 2);
	
	// function a(ri, ro, i) = acos((pow(ro, 2) + pow(ri, 2) - pw * pow(0.985, i)) / (2 * ro * ri));
	
	module drawPolygon(r) {
		circle(r, $fn = fn);
	}
	
	rs = [for(i = [0: n]) beginning_radius + i * dr];
	//as = [for(i = [1: n]) a(rs[i - 1], rs[i], i) / 2];
	
	half_height = height / 2;

	s = [for(i = [1: n]) (rs[i] + slope * half_height) / rs[i]];

	module half() {
	    translate([0, 0, -half_height]) {
			linear_extrude(half_height, scale = s[0])
			difference() {
				drawPolygon(beginning_radius);
				drawPolygon(beginning_radius - thickness);
			}
				
			for(i = [1:n - 1]) {
				//rotate(as[i] * 2)
				linear_extrude(half_height, scale = s[i])
				difference() {
					drawPolygon(rs[i]);
					drawPolygon(rs[i] - thickness);
				}					
			}
		}
	}
	
	half();	
	mirror([0, 0, 1])
	    half();
}