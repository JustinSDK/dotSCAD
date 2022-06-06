/**
* trim_shape.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-trim_shape.html
*
**/

use <_impl/_trim_shape_impl.scad>

function trim_shape(shape_pts, from, to, epsilon = 0.0001) = 
    _trim_shape_impl(shape_pts, from, to, epsilon);
