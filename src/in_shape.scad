/**
* in_shape.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-in_shape.html
*
**/

use <__comm__/__lines_from.scad>
use <_impl/_in_shape_impl.scad>

function in_shape(shapt_pts, pt, include_edge = false, epsilon = 0.0001) = 
    let(
        leng = len(shapt_pts),
        edges = __lines_from(shapt_pts, true)
    )
    _in_any_edges(edges, pt, epsilon) ? include_edge : 
    _in_shape_sub(shapt_pts, leng, pt, _does_pt_cross(shapt_pts[leng - 1], shapt_pts[0], pt));