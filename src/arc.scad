/**
* arc.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc.html
*
**/ 

include <__private__/__frags.scad>;
include <__private__/__ra_to_xy.scad>;
include <__private__/__edge_r.scad>;
include <__private__/__shape_arc.scad>;

module arc(radius, angle, width, width_mode = "LINE_CROSS") {
    polygon(__shape_arc(radius, angle, width, width_mode));
}