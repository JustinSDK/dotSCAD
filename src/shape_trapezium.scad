/**
* shape_trapezium.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_trapezium.html
*
**/

use <__comm__/__trapezium.scad>

function shape_trapezium(length, h, corner_r = 0) = 
    __trapezium(
        length = length, 
        h = h, 
        round_r = corner_r
    );
    