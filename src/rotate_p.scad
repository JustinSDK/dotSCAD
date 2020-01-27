/**
* rotate_p.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html
*
**/ 

use <_impl/_rotate_p_impl.scad>;

function rotate_p(point, a, v) = _rotate_p_impl(point, a, v);