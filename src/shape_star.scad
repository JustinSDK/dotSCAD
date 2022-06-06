/**
* shape_star.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_star.html
*
**/

use <_impl/_shape_star_impl.scad>

function shape_star(outer_radius = 1, inner_radius = 0.381966, n = 5) = _shape_star_impl(outer_radius, inner_radius, n);