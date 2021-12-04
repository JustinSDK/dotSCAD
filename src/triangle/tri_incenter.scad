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
    (len(pa) == 2 ? [
        (a * pa.x + b * pb.x + c * pc.x), 
        (a * pa.y + b * pb.y + c * pc.y)
    ] : [
        (a * pa.x + b * pb.x + c * pc.x), 
        (a * pa.y + b * pb.y + c * pc.y),
        (a * pa.z + b * pb.z + c * pc.z)
    ]) / (a + b + c);