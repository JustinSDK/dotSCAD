/**
* turtle3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-turtle3d.html
*
**/ 

use <_impl/_turtle3d_impl.scad>
    
function turtle3d(cmd, arg1, arg2) = _turtle3d_impl(cmd, arg1, arg2);    