/**
* angle_between.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-angle_between.html
*
**/

use <_impl/_angle_between_impl.scad>

function angle_between(vt1, vt2, ccw = false) = 
    !ccw ? acos((vt1 * vt2) / sqrt((vt1 * vt1) * (vt2 * vt2))) :
    len(vt1) == 2 ? angle_between_ccw_2d(vt1, vt2) : 
                    angle_between_ccw_3d(vt1, vt2);