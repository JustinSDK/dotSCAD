/**
* golden_spiral.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-golden_spiral.html
*
**/ 

use <_impl/_golden_spiral_impl.scad>

function golden_spiral(from, to, point_distance, rt_dir = "CT_CLK") =    
    _golden_spiral_impl(from, to, point_distance, rt_dir);