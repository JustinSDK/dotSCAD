use <util/degrees.scad>;

function rand_pts_sphere(radius, value_count, seed = undef) =
    let(r_nums = is_undef(seed) ? rands(0, 1, value_count * 2) :  rands(0, 1, value_count * 2, seed))
	[
		for(i = [0:value_count - 1])
		let(
			theta = degrees(2 * PI * r_nums[i]),
			phi = acos(r_nums[i + value_count] * 2 - 1),
			sin_phi = sin(phi),
			x = sin_phi * cos(theta),
			y = sin_phi * sin(theta),
			z = cos(phi)
		)
		[x, y, z]
	] * radius;

/*

use <experimental/rand_pts_sphere.scad>;
use <polyhedron_hull.scad>;

number = 20;
u = rands(0, 1, number);
v = rands(0, 1, number);
radius = 2;

points = rand_pts_sphere(radius, number);

polyhedron_hull(points);

for(p = points) {
    translate(p)
	    sphere(.05);
}

%sphere(radius, $fn = 48);

*/