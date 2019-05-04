/**
* shape_square.scad
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
        is_vt = __is_vector(size),
        x = is_vt ? size[0] : size,
        y = is_vt ? size[1] : size        
    )
    __trapezium(
        length = x, 
        h = y, 
        round_r = corner_r
    );
    