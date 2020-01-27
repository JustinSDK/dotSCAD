
/**
* shape_glued2circles.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_glued2circles.html
*
**/ 

use <_impl/_shape_glued2circles_impl.scad>;
    
function shape_glued2circles(radius, centre_dist, tangent_angle = 30, t_step = 0.1) =
    _shape_glued2circles_impl(radius, centre_dist, tangent_angle, t_step);