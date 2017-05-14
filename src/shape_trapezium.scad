/**
* shape_trapezium.scad
*
* Returns shape points of an isosceles trapezium.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_trapezium.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__frags.scad>;
include <__private__/__pie_for_rounding.scad>;
include <__private__/__half_trapezium.scad>;
include <__private__/__trapezium.scad>;

function shape_trapezium(radius, h, corner_r = 0) = 
    __trapezium(
        radius = radius, 
        h = h, 
        round_r = corner_r
    );
    