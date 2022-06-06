/**
* bspline_curve.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bspline_curve.html
*
**/

use <_impl/_bspline_curve_impl.scad>

function bspline_curve(t_step, degree, points, knots, weights) = 
    _bspline_curve_impl(t_step, degree, points, knots, weights);    