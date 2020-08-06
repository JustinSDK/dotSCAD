/**
* px_line.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-px_line.html
*
**/ 

use <_impl/_px_line_impl.scad>;

function px_line(p1, p2) = 
    let(
        _ = echo("<b><i>pixel/px_line</i> is deprecated: use <i>voxel/vx_line</i> instead.</b>")
    )
    _px_line_impl(p1, p2);