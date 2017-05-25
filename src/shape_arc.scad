/**
* shape_arc.scad
*
* Returns shape points of an arc shape. 
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_arc.html
*
**/ 

include <__private__/__frags.scad>;
include <__private__/__is_vector.scad>;
include <__private__/__ra_to_xy.scad>;
include <__private__/__shape_arc.scad>;

function shape_arc(radius, angle, width, width_mode = "LINE_CROSS") =
    __shape_arc(radius, angle, width, width_mode);