/**
* rotate_p.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-rotate_p.html
*
**/ 

use <_impl/_ptf_rotate_impl.scad>;

function ptf_rotate(point, a, v) = _rotate_p_impl(point, a, v);