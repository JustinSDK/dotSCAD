/**
* bezier_curve.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_curve.html
*
**/ 

use <_impl/_bezier_curve_impl.scad>

function bezier_curve(t_step, points) = _bezier_curve_impl(t_step, points);