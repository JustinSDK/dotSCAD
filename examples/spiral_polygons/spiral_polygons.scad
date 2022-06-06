use <shape_circle.scad>
use <polyline_join.scad>
use <util/sum.scad>

beginning_radius = 10;
line_width = 2;
fn = 3;
number_of_polygons = 10;
height = 2;

linear_extrude(height)
    spiral_polygons(beginning_radius, line_width, fn, number_of_polygons);

module spiral_polygons(beginning_radius, line_width, fn, n) {
    theta = 180 / fn;
	
	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta);
	pw = pow((beginning_radius + dr) * sin(theta), 2);
	
	half_line_width = line_width / 2;
	
	function a(ri, ro, i) = acos((pow(ro, 2) + pow(ri, 2) - pw * pow(0.985, i)) / (2 * ro * ri));
	
	module drawPolygon(r) {
	    pts = shape_circle(radius = r, $fn = fn);
		polyline_join([each pts, pts[0]])
		    circle(half_line_width, $fn = 12);
	}
	
	rs = [for(i = [0: n - 1]) beginning_radius + i * dr];
	as = [for(i = [1: n - 1]) a(rs[i - 1], rs[i], i) / 2];
	
	rotate(-as[0])
	    drawPolygon(beginning_radius);

	for(i = [1:n - 1]) {
	    rotate(sum([for(j = [0:i - 1]) as[j]]))
	        drawPolygon(rs[i]);	
	}
}