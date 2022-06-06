/**
* arc.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-arc.html
*
**/ 

use <shape_arc.scad>

module arc(radius, angle, width = 1, width_mode = "LINE_CROSS") {
    polygon(shape_arc(radius, angle, width, width_mode));
}