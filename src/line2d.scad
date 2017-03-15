/**
* line2d.scad
*
* Creates a line from two points.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line2d.html
*
**/

// The end-cap style
CAP_BUTT = 0;
CAP_SQUARE = 1;
CAP_ROUND = 2; 

module line2d(p1, p2, width, p1Style = CAP_SQUARE, p2Style =  CAP_SQUARE, round_fn = 24) {
    $fn = round_fn;
    half_width = 0.5 * width;

    atan_angle = atan2(p2[1] - p1[1], p2[0] - p1[0]);
    angle = 90 - atan_angle;
    
    offset_x = half_width * cos(angle);
    offset_y = half_width * sin(angle);
    
    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    polygon(points=[
        p1 + offset1, p2 + offset1,  
        p2 + offset2, p1 + offset2
    ]);
    
    module square_end(point) {
        translate(point) 
            rotate(atan_angle) 
                square(width, center = true);    
    }
    
    module round_end(point) {
        translate(point) 
            circle(half_width, center = true);    
    }
    
    if(p1Style == CAP_SQUARE) {
        square_end(p1);
    } else if(p1Style == CAP_ROUND) {
        round_end(p1);
    }
    
    if(p2Style == CAP_SQUARE) {
        square_end(p2);
    } else if(p2Style == CAP_ROUND) {
        round_end(p2);
    }
}