/**
* in_polyline.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-in_polyline.html
*
**/

use <__comm__/__in_line.scad>

function in_polyline(line_pts, pt, epsilon = 0.0001) = 
    let(
        leng = len(line_pts),
        iend = leng - 1,
        maybe_last = [for(i = 0; i < iend && !__in_line([line_pts[i], line_pts[i + 1]], pt, epsilon); i = i + 1) i][leng - 2]
    )
    is_undef(maybe_last);
    