/**
* arc.scad
*
* Create an arc. You can pass a 2 element vector to define the central angle. 
* It provides a fn parameter consistent with the $fn parameter of the circle module.
* It depends on the circular_sector module so you have to include circular_sector.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc.html
*
**/


LINE_CROSS = 0;
LINE_OUTWARD = 1; 
LINE_INWARD = 2;

module arc(radius, angles, width, width_mode = LINE_CROSS, fn = 24) {
    w_offset = width_mode == LINE_CROSS ? [width / 2, -width / 2] : (
        width_mode == LINE_INWARD ? [0, -width] : [width, 0]
    );
    
    difference() {
        sector(radius + w_offset[0], angles, fn);
        sector(radius + w_offset[1], angles, fn);
    }
} 