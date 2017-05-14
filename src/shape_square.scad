/**
* shape_square.scad
*
* Returns shape points of a rounded square or rectangle.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_square.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__frags.scad>;
include <__private__/__pie_for_rounding.scad>;
include <__private__/__half_trapezium.scad>;
include <__private__/__trapezium.scad>;

function shape_square(size, corner_r = 0) = 
    let(
        x = __is_vector(size) ? size[0] : size,
        y = __is_vector(size) ? size[1] : size        
    )
    __trapezium(
        radius = x, 
        h = y, 
        round_r = corner_r
    );
    