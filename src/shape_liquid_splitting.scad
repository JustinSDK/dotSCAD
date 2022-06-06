
/**
* shape_liquid_splitting.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_liquid_splitting.html
*
**/ 

use <_impl/_shape_liquid_splitting_impl.scad>
    
function shape_liquid_splitting(radius, centre_dist, tangent_angle = 30, t_step = 0.1) =
    _shape_liquid_splitting_impl(radius, centre_dist, tangent_angle, t_step);