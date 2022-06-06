/**
* shape_path_extend.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-path_extend.html
*
**/

use <_impl/_shape_path_extend_impl.scad>

function shape_path_extend(stroke_pts, path_pts, scale = 1.0, closed = false) =
    _shape_path_extend_impl(stroke_pts, path_pts, scale, closed);