use <ellipse_extrude.scad>;
use <util/sum.scad>;

beginning_radius = 7.5;
fn = 5;
number_of_polygons = 10;
height = 30;
thickness = 1.5;

spiral_plate(beginning_radius, fn, number_of_polygons, height);

module spiral_plate(beginning_radius, fn, n, height) {
    theta = 180 / fn;
	
	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness * 1.5;
	pw = pow((beginning_radius + dr) * sin(theta), 2);
	
	function a(ri, ro, i) = acos((pow(ro, 2) + pow(ri, 2) - pw * pow(0.985, i)) / (2 * ro * ri));
	
	module drawPolygon(r) {
		circle(r, $fn = fn);
	}
	
	rs = [for(i = [0: n]) beginning_radius + i * dr];
	//as = [for(i = [1: n]) a(rs[i - 1], rs[i], i) / 2];

	s = [for(i = [1: n]) (rs[i] * 1.2) / rs[i - 1]];
	
	half_height = height / 2;
	
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