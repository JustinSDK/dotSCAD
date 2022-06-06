/**
* midpt_smooth.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-midpt_smooth.html
*
**/

use <_impl/_midpt_smooth_impl.scad>

function midpt_smooth(points, n, closed = false) = _midpt_smooth_impl(points, n, closed);