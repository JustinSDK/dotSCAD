use <shape_circle.scad>;
use <polyhedron_hull.scad>;
use <ptf/ptf_rotate.scad>;
use <experimental/convex_hull3.scad>;

function one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a) =  
    let(
	    scale_r = PI * body_r / body_fn,
		double_scale_r = scale_r * 2,
		shape_scale = shape_circle(scale_r, $fn = scale_fn),
		scale_pts = concat(
			[[0, 0, scale_r / 2 + body_r]], 
			[
				for(p = shape_scale) 
					ptf_rotate([p[0], p[1] * 2.01, body_r], [scale_tilt_a, 0, 0])
			], 
			[for(p = shape_scale) [p[0], p[1] * 2.01, 0]]
		)
	)
    convex_hull3(scale_pts);


module dragon_body_scales(body_r, body_fn, one_scale_points_faces) {
	double_scale_r = PI * body_r / body_fn * 2;

	module ring_scales() {
	    a_step = 360 / body_fn;
		for(a = [0:body_fn - 1]) {
			rotate([0, a * a_step, 0])
			polyhedron(
			     one_scale_points_faces[0], 
				 one_scale_points_faces[1]
		    );
		}
	}
	
	a = 180 / body_fn;
	for(y = [0:1]) {
		translate([0, y * double_scale_r])
		rotate([0, (y % 2) * a])
		    ring_scales();
	}	
}