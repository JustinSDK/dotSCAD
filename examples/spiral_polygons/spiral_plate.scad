use <ellipse_extrude.scad>
use <util/sum.scad>

beginning_radius = 15;
fn = 5;
number_of_polygons = 10;
layer_height = 1.5;

spiral_plate(beginning_radius, fn, number_of_polygons, layer_height);

module spiral_plate(beginning_radius, fn, n, layer_height) {
    theta = 180 / fn;
	
	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta);
	pw = pow((beginning_radius + dr) * sin(theta), 2);
	
	function a(ri, ro, i) = acos((pow(ro, 2) + pow(ri, 2) - pw * pow(0.985, i)) / (2 * ro * ri));
	
	module drawPolygon(r) {
		circle(r, $fn = fn);
	}
	
	rs = [for(i = [0: n - 1]) beginning_radius + i * dr];
	as = [for(i = [1: n - 1]) a(rs[i - 1], rs[i], i) / 2];
	
	difference() {
	    h = layer_height * (n + 1);
		
	    translate([0, 0, h])
		rotate(sum([for(j = [0:n - 2]) as[j]]))
		mirror([0, 0, 1])
		ellipse_extrude(layer_height * (n + 5), h)
			drawPolygon(rs[n - 1] + y);	
			
		translate([0, 0, layer_height * 1.01]) {
			rotate(-as[0])
			linear_extrude(layer_height)
				drawPolygon(beginning_radius);

			for(i = [1:n - 1]) {
				translate([0, 0, layer_height * i])
				rotate(sum([for(j = [0:i - 1]) as[j]]))
				linear_extrude(layer_height)
					drawPolygon(rs[i]);	
			}
		}
	}
}