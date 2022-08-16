/**
* tri_subdivide.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_subdivide.html
*
**/

use <_impl/_tri_subdivide_impl.scad>
    
function tri_subdivide(shape_pts, n = 1) =
    n == 0 ? [shape_pts] :
    let(
        pts = _tri_subdivide_pts(shape_pts, n + 1),
        indices = _tri_subdivide_indices(n + 1)
    )
    [
        for(ti = indices) 
        [pts[ti[0]], pts[ti[1]], pts[ti[2]]]
    ];
    