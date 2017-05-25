/**
* shape_pie.scad
*
* Returns shape points of a pie (circular sector) shape.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_pie.html
*
**/

include <__private__/__frags.scad>;
include <__private__/__is_vector.scad>;
include <__private__/__ra_to_xy.scad>;
include <__private__/__shape_pie.scad>;

function shape_pie(radius, angle) =
    __shape_pie(radius, angle);