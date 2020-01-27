/**
* triangulate.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-triangulate.html
*
**/

use <_impl/_triangulate_impl.scad>;
    
function triangulate(shape_pts,  epsilon = 0.0001) = _triangulate_impl(shape_pts,  epsilon);