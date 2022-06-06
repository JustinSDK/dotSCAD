use <pie.scad>
use <ptf/ptf_rotate.scad>
use <experimental/tile_penrose3.scad>

n = 5;
radius = 30;
$fn = 6;

lavender(n, radius);

module lavender(n, radius) {
	module draw(tris, radius) {
		module draw_tri(type, points) {
			module draw_acute_pie(p, r, a) {
				hull() {
					linear_extrude(layer_thickness * 2) 
					offset(-radius / 175) 
					translate(p)
					rotate(a)
						pie(r * 1.1, 72);
					
					linear_extrude(layer_thickness * 3) 
					offset(-radius / 100) 
					translate(p)
					rotate(a)
						pie(r, 72);
					
				}
			}
			
			module draw_obtuse_pie(p, r, a) {
				hull() {
					linear_extrude(layer_thickness * 2) 
					offset(-radius / 175) 
					translate(p)
					rotate(a)
						pie(r * 1.1, 36);
					
					linear_extrude(layer_thickness * 3) 
					offset(-radius / 100) 
					translate(p)
					rotate(a)
						pie(r, 36);
				}
			}

			v1 = points[0] - points[1];
			v2 = points[2] - points[1];
			r = norm(v1) / 2;
			clk = cross(v1, v2);
			
			color("Lavender")
			if(type == "ACUTE") {
				if(clk < 0) {
					v = (points[0] + points[1]) / 2 - points[0];
					a = atan2(v[1], v[0]);
					draw_acute_pie(points[0], r, a);
				}
				else {
					v = (points[2] + points[1]) / 2 - points[2];
					a = atan2(v[1], v[0]) - 108;
					draw_acute_pie(points[0], r, a);
				}
			} 
			else {
				if(clk < 0) {
					v = (points[0] + points[1]) / 2 - points[0];
					a = atan2(v[1], v[0]);
					draw_obtuse_pie(points[0], r, a);
				}
				else {
					v = (points[0] - points[2]);
					a = atan2(v[1], v[0]) + 180;
					draw_obtuse_pie(points[0], r, a);
				}
			}
			
			color("Lime")
			hull() {
				linear_extrude(layer_thickness)
					polygon(points);
					
				linear_extrude(layer_thickness * 2)
				offset(-radius / 175)
					polygon(points);
			}
			
			color("Maroon")
			linear_extrude(layer_thickness)
			offset(radius / 50)
				polygon(points);	
		}
	
		for(t = tris) {
			draw_tri(t[0], t[1] * radius);
		}
	}
	

	layer_thickness = radius / 50;
	draw(tile_penrose3(n), radius);
}