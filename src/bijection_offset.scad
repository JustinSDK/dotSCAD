/**
* bijection_offset.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bijection_offset.html
*
**/

use <_impl/_bijection_offset_impl.scad>
    
function bijection_offset(pts, d, epsilon = 0.0001) = 
    _bijection_offset_impl(pts, d, epsilon);
    