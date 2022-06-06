use <__comm__/__frags.scad>
use <angle_between.scad>
use <triangle/tri_circumcenter.scad>
use <ptf/ptf_rotate.scad>
use <util/reverse.scad>
use <experimental/tri_is_ccw.scad>

function _tri_arc_ct_clk(shape_pts) = 
    let(
	    c = tri_circumcenter(shape_pts),
		v0 = shape_pts[0] - c,
		v2 = shape_pts[2] - c,
		r = norm(v0),
		v0_a = atan2(v0[1], v0[0]),
		a = angle_between(v0, v2, ccw = true),
		a_step = a / __frags(r)
	)
	[for(a = [0:a_step:a]) c + ptf_rotate([r * cos(a), r * sin(a)], v0_a)];

function tri_arc_path(shape_pts) = 
    tri_is_ccw(shape_pts) ? 
	    _tri_arc_ct_clk(shape_pts) : 
		reverse(_tri_arc_ct_clk(reverse(shape_pts)));

/*
use <experimental/tri_arc_path.scad>

use <util/zip.scad>
use <hull_polyline2d.scad>

$fn = 24;
pts = zip([rands(0, 20, 3), rands(0, 20, 3)]);

hull_polyline2d(tri_arc_path(pts));
#for(i = [0:len(pts) - 1]) {
    translate(pts[i])
	    sphere(1);
    translate(pts[i])
	    text(str(i), 2);
}
*/