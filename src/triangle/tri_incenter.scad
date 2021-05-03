/**
* tri_incenter.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_incenter.html
*
**/

function tri_incenter(shape_pts) = 
    let(
        pa = shape_pts[0],
        pb = shape_pts[1],
        pc = shape_pts[2],
		a = norm(pb - pc),
		b = norm(pc - pa),
		c = norm(pa - pb)
    )
	[
        (a * pa[0] + b * pb[0] + c * pc[0]), 
        (a * pa[1] + b * pb[1] + c * pc[1])
    ] / (a + b + c);