/**
* t3d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-t3d.html
*
**/ 

use <_impl/_t3d_impl.scad>

function t3d(t, cmd, point, unit_vectors, leng, angle) =
    _t3d_impl(t, cmd, point, unit_vectors, leng, angle);