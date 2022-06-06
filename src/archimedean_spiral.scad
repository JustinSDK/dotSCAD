/**
* archimedean_spiral.scad
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-archimedean_spiral.html
*
**/ 

use <_impl/_archimedean_spiral_impl.scad>

function archimedean_spiral(arm_distance, init_angle, point_distance, num_of_points, rt_dir = "CT_CLK") =
    _archimedean_spiral_impl(arm_distance, init_angle, point_distance, num_of_points, rt_dir);