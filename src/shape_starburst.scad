/**
* shape_star.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_starburst.html
*
**/

use <_impl/_shape_starburst_impl.scad>

function shape_starburst(r1, r2, n) = 
   let(_ = echo("`shape_starburst` is deprecated since 3.2. Use `shape_star` instead."))
   _shape_starburst_impl(r1, r2, n);