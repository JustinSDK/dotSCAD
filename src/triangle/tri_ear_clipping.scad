/**
* tri_circumcenter.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_ear_clipping.html
*
**/

use <_impl/_tri_ear_clipping_impl.scad>

function tri_ear_clipping(shape_pts,  ret = "TRI_INDICES", epsilon = 0.0001) = 
    let(tris = _tri_ear_clipping_impl(shape_pts,  epsilon))
    ret == "TRI_INDICES" ? tris : [for(tri = tris) [for(idx = tri) shape_pts[idx]]];