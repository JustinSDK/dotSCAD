model = "POLYGON"; // [POLYGON, BASE, BOTH]
beginning_radius = 7.5;
fn = 4;
number_of_polygons = 10;
height = 20;
thickness = 1;
spacing = thickness;
slope = 0.825;
base_height = height * 1.75;

fidget_polygon(model, beginning_radius, fn, number_of_polygons, height, thickness, spacing, slope, base_height);

module fidget_polygon(model, beginning_radius, fn, n, height, thickness, spacing, slope, base_height) {
    theta = 180 / fn;

	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness + spacing;

	module drawPolygon(r) {
		circle(r, $fn = fn);
	}
	
	rs = [for(i = [0: n + 1]) beginning_radius + i * dr];
	
	half_height = height / 2;

	s = [for(i = [1: n + 1]) (rs[i] + slope * half_height) / rs[i]];

	module half() {
	    translate([0, 0, -half_height]) {
			linear_extrude(half_height, scale = s[0])
			difference() {
				drawPolygon(beginning_radius);
				drawPolygon(beginning_radius - thickness);
			}
				
			for(i = [1:n - 1]) {
				linear_extrude(half_height, scale = s[i])
				difference() {
					drawPolygon(rs[i]);
					drawPolygon(rs[i] - thickness);
				}					
			}
		}
	}
	
	if(model == "POLYGON" || model == "BOTH") {
		half();	
		mirror([0, 0, 1])
			half();
	}
	// base

	ring_thickness = thickness * 1.5;
    module base_ring() {
		translate([0, 0, -ring_thickness])
		difference() {
			linear_extrude(ring_thickness, scale = 1.02)
			offset(ring_thickness / 3, $fn = n)
				drawPolygon(rs[n] * s[n] - thickness);

			linear_extrude(thickness * 4, center = true)
			    drawPolygon(rs[n] * s[n] - ring_thickness);	
		}
	}

    if(model == "BASE" || model == "BOTH") {
		color("white") {
			// plate
			translate([0, 0, -half_height])
			linear_extrude(half_height, scale = s[n])
			difference() {
				drawPolygon(rs[n]);
				drawPolygon(rs[n] - thickness);
			}			

			// ring
			base_ring();
			mirror([0, 0, 1])
				base_ring();

			*translate([0, 0, -base_height + ring_thickness])
			mirror([0, 0, 1])
			scale([1, 1, 1.5])
				base_ring();

			// stick
			d = rs[n] * s[n];
			off_h = -base_height + ring_thickness;
			a = 180 / fn;
			stick_r = thickness * 5;
			stick_h = base_height - ring_thickness;
			for(i = [0:fn - 1]) {
				rotate(360 / fn * i)
				translate([d + thickness * 1.5, 0, off_h]) 
				rotate(a) {
					linear_extrude(stick_h)
						circle(stick_r, $fn = fn);
					translate([0, 0, stick_h])
					linear_extrude(ring_thickness, scale = 0.75)
						circle(stick_r, $fn = fn);
				}
			}
		}
	}
}