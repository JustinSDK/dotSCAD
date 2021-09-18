use <experimental/tile_penrose3.scad>;
use <experimental/ptf_c2sphere.scad>;
use <ptf/ptf_rotate.scad>;
use <hull_polyline3d.scad>;
use <surface/sf_thickenT.scad>;
use <polyhedron_hull.scad>;
use <util/every.scad>;

basket_radius = 40;
radius_in_plane = basket_radius / 1.25 / cos(36);
n = 4;
line_diameter = 2;
shell = "YES";
shell_random_threshold = 0.5;
$fn = 4;
		
penrose_basket(basket_radius, radius_in_plane, n, line_diameter, shell, shell_random_threshold);

module penrose_basket(basket_radius, radius_in_plane, n, line_diameter, shell, shell_random_threshold) {
	tris = tile_penrose3(n);

	for(t = tris) {
		if(every(t[1], function(p) norm(p * radius_in_plane) < radius_in_plane * 1.25)) {
			pts = [for(p = t[1] * radius_in_plane) ptf_c2sphere(p, basket_radius)];
			
			hull_polyline3d(
				pts, 
				line_diameter
			);

			if(shell == "YES" && rands(0, 1, 1)[0] < shell_random_threshold) {
				inward_ratio = (basket_radius - 0.25 * line_diameter) / basket_radius;
				outward_ratio = (basket_radius + 0.25 * line_diameter) / basket_radius;

				polyhedron_hull(concat(pts * outward_ratio, pts * inward_ratio), polyhedron_abuse = true);
			}
		}
	}
}
