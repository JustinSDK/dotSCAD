/**
* sf_splines.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_splines.html
*
**/ 

use <../matrix/m_transpose.scad>

function sf_splines(ctrl_pts, row_spline, column_spline) =
    let(
        leng_ctrl_pts = len(ctrl_pts),
        cspline = is_undef(column_spline) ? row_spline : column_spline,
        r_pts = [
		    for(r = 0; r < leng_ctrl_pts; r = r + 1)
				row_spline(ctrl_pts[r])
		],
        leng_r_pts0 = len(r_pts[0])
	)
    m_transpose([
        for(c = 0; c < leng_r_pts0; c = c + 1)
        cspline([for(pts = r_pts) pts[c]]) 
    ]);
