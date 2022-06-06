/**
* rounded_square.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_square.html
*
**/

use <__comm__/__trapezium.scad>

module rounded_square(size, corner_r, center = false) {
    is_flt = is_num(size);
    x = is_flt ? size : size.x;
    y = is_flt ? size : size.y;       
    
    position = center ? [0, 0] : [x / 2, y / 2];
    points = __trapezium(
        length = x, 
        h = y, 
        round_r = corner_r
    );

    translate(position) 
        polygon(points);

    // hook for testing
    test_rounded_square(position, points);
}

// override it to test
module test_rounded_square(position, points) {
}