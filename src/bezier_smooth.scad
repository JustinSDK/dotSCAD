/**
* bezier_smooth.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_curve.html
*
**/ 

use <_impl/_bezier_smooth_impl.scad>
    
function bezier_smooth(path_pts, round_d, t_step = 0.1, closed = false, angle_threshold = 0) =
    _bezier_smooth_impl(path_pts, round_d, t_step, closed, angle_threshold);