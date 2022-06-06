use <experimental/tile_penrose3.scad>
use <experimental/ptf_c2sphere.scad>
use <ptf/ptf_rotate.scad>
use <polyline_join.scad>
use <surface/sf_thickenT.scad>
use <polyhedron_hull.scad>
use <util/every.scad>

basket_radius = 40;
radius_in_plane = basket_radius;

n = 4;
line_diameter = 3;
bottom_radius = 8;
bottom_height = 4;
shell_random_threshold = 0.5; // 0 ~ 1
$fn = 4;
		
penrose_basket(basket_radius, radius_in_plane, n, line_diameter, bottom_radius, bottom_height, shell_random_threshold);

module penrose_basket(basket_radius, radius_in_plane, n, line_diameter, bottom_radius, bottom_height, shell_random_threshold) {
    line_r = line_diameter / 2;
	tris = [for(t = tile_penrose3(n)) t[1] * radius_in_plane];
	for(t = tris) {
		if(every(t, function(p) norm(p) < radius_in_plane * 1.25)) {
			pts = [
				for(p = t)
				let(cp = ptf_c2sphere(p, basket_radius)) 
				norm(p) < bottom_radius ? 
				    [cp[0], cp[1], -cp[2] + 2 * basket_radius - bottom_height * 2] : 
					cp
			];
			
			polyline_join(pts)
			    sphere(line_r);

			if(rands(0, 1, 1)[0] < shell_random_threshold) {
				inward_ratio = (basket_radius - 0.25 * line_diameter) / basket_radius;
				outward_ratio = (basket_radius + 0.25 * line_diameter) / basket_radius;

				polyhedron_hull(concat(pts * outward_ratio, pts * inward_ratio), polyhedron_abuse = true);
			}
		}
	}
}
